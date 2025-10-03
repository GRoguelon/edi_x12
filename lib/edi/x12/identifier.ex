defmodule Edi.X12.Identifier do
  @moduledoc """
  Defines an identifier which is similar to an enum in other languages.
  """

  ## Structure

  @enforce_keys [:code, :value]
  defstruct [:code, :value]

  ## Typespecs

  @type t :: %__MODULE__{
          code: binary(),
          value: binary()
        }

  defimpl Inspect do
    def inspect(%{code: code, value: value}, _opts) do
      Inspect.Algebra.concat(["#Identifier<", code, "=", value, ">"])
    end
  end
end
