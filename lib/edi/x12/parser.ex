defmodule Edi.X12.Parser do
  @moduledoc false

  ## Public macros

  defmacro __using__(opts) do
    function = Keyword.fetch!(opts, :parser)

    quote do
      @doc """
      Parse the `value` and create a struct.

      ### Examples

          iex> parse("XX*Y*ZZ~")
          {:ok, %Struct{elem_1: "Y", elem_2: "ZZ"}}
      """
      @spec parse(binary()) :: {:ok, t()} | {:error, binary(), binary()}
      def parse(value) when is_binary(value) do
        case unquote(function)(value) do
          {:ok, result, "", _, _, _} ->
            {:ok, struct!(__MODULE__, result)}

          {:error, error, rest, _, _, _} ->
            {:error, error, rest}
        end
      end

      @doc """
      Convert the `list` into a struct.

      ### Examples

          iex> parse(elem_1: "Y", elem_2: "ZZ")
          {:ok, %Struct{elem_1: "Y", elem_2: "ZZ"}}
      """
      @spec parse(keyword() | map()) :: {:ok, t()} | {:error, binary(), binary()}
      def parse(list) when is_list(list) or is_map(list) do
        {:ok, struct!(__MODULE__, list)}
      end

      @doc """
      Convert the `list` into a struct.

      ### Examples

          iex> parse!(elem_1: "Y", elem_2: "ZZ")
          %Struct{
            elem_1: "Y",
            elem_2: "ZZ"
          }
      """
      @spec parse!(keyword() | map()) :: t()
      def parse!(list) do
        case parse(list) do
          {:ok, result} ->
            result

          {:error, error, _rest} ->
            raise error
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

  def identifier(value, values) when is_binary(value) and value != "" and values == %{} do
    value
    |> String.split("|")
    |> Enum.map(fn item ->
      %Edi.X12.Identifier{code: item, value: item}
    end)
    |> case do
      [item] ->
        item

      items ->
        items
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

  def number2("", _scale), do: nil

  def number2(values, scale) do
    {integer, ""} = Integer.parse(values)

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

  def decimal2(value) when is_binary(value) and value != "" do
    {float, ""} = Float.parse(value)

    float
  end

  def decimal2(_values), do: nil
end
