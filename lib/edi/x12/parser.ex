defmodule Edi.X12.Parser do
  @moduledoc false

  ## Public macros

  defmacro __using__(_env) do
    quote do
      @spec new(binary()) :: {:ok, t()}
      def new(value) when is_binary(value) do
        case parse(value) do
          {:ok, result, "", _, _, _} ->
            {:ok, struct!(__MODULE__, result)}

          {:error, error, rest, _, _, _} ->
            {:error, error, rest}
        end
      end
    end
  end

  ## Public functions

  def date(<<year::binary-size(4), month::binary-size(2), day::binary-size(2)>>) do
    {year, ""} = Integer.parse(year)
    {month, ""} = Integer.parse(month)
    {day, ""} = Integer.parse(day)

    Date.new!(year, month, day)
  end

  def date(<<year::binary-size(2), month::binary-size(2), day::binary-size(2)>>) do
    {year, ""} = Integer.parse(year)
    {month, ""} = Integer.parse(month)
    {day, ""} = Integer.parse(day)

    Date.new!(2_000 + year, month, day)
  end

  def time(
        <<hour::binary-size(2), minute::binary-size(2), second::binary-size(2),
          decimal::binary-size(2)>>
      ) do
    {hour, ""} = Integer.parse(hour)
    {minute, ""} = Integer.parse(minute)
    {second, ""} = Integer.parse(second)
    {decimal, ""} = Integer.parse(decimal)

    Time.new!(hour, minute, second, {decimal * 10_000, 2})
  end

  def time(<<hour::binary-size(2), minute::binary-size(2), second::binary-size(2)>>) do
    {hour, ""} = Integer.parse(hour)
    {minute, ""} = Integer.parse(minute)
    {second, ""} = Integer.parse(second)

    Time.new!(hour, minute, second)
  end

  def time(<<hour::binary-size(2), minute::binary-size(2)>>) do
    {hour, ""} = Integer.parse(hour)
    {minute, ""} = Integer.parse(minute)

    Time.new!(hour, minute, 0)
  end

  def string(value) do
    case String.trim_trailing(value) do
      "" ->
        nil

      string ->
        string
    end
  end

  def identifier(value, values) when is_binary(value) and value != "" do
    case String.split(value, "|") do
      [item] ->
        description = Map.fetch!(values, item)

        %Edi.X12.Identifier{code: item, value: description}

      items ->
        Enum.map(items, fn item ->
          description = Map.fetch!(values, item)

          %Edi.X12.Identifier{code: item, value: description}
        end)
    end
  end

  def identifier(_value, _values), do: nil

  def numeric(values, scale) do
    value = Enum.join(values)
    {integer, ""} = Integer.parse(value)

    if scale > 0 do
      Float.round(integer / Integer.pow(10, scale), scale)
    else
      integer
    end
  end

  def number2(values, scale) do
    value = Enum.join(values)
    {integer, ""} = Integer.parse(value)

    if scale > 0 do
      Float.round(integer / Integer.pow(10, scale), scale)
    else
      integer
    end
  end

  def composite(values) do
    values
  end

  def decimal(values) do
    value = Enum.join(values)
    {float, ""} = Float.parse(value)

    float
  end

  def decimal2(values) do
    value = Enum.join(values)
    {float, ""} = Float.parse(value)

    float
  end

  def char(codepoint) do
    List.to_string([codepoint])
  end
end
