defmodule Edi.X12.Hipaa.R5010.Elements.CompositeDiagnosisCodePointer do
  @moduledoc """
  `C004` - Composite Diagnosis Code Pointer

  To identify one or more diagnosis code pointers
  """

  use Edi.X12.Parser, parser: :element

  import NimbleParsec

  alias Edi.X12.Parser

  ## Strucuture

  @derive {Inspect,
           except: [:__key__],
           optional: [
             :diagnosis_code_pointer_2,
             :diagnosis_code_pointer_3,
             :diagnosis_code_pointer_4
           ]}
  @enforce_keys [
    :diagnosis_code_pointer_1
  ]
  defstruct __key__: :composite_diagnosis_code_pointer,
            diagnosis_code_pointer_1: nil,
            diagnosis_code_pointer_2: nil,
            diagnosis_code_pointer_3: nil,
            diagnosis_code_pointer_4: nil

  ## Typespecs

  @type t :: %__MODULE__{
          __key__: :composite_diagnosis_code_pointer,
          diagnosis_code_pointer_1: number(),
          diagnosis_code_pointer_2: nil | number(),
          diagnosis_code_pointer_3: nil | number(),
          diagnosis_code_pointer_4: nil | number()
        }

  ## Module attributes

  @element_seperator ":"

  ## Nimble Parsec

  combinator =
    empty()

    # Parse element (1328 - Diagnosis Code Pointer) and tag as: :diagnosis_code_pointer_1
    |> optional(
      unwrap_and_tag(
        map(ascii_string([?-, ?0..?9, ?., ?|], min: 1, max: 2), {Parser, :number2, [0]}),
        :diagnosis_code_pointer_1
      )
    )

    # Parse element (1328 - Diagnosis Code Pointer) and tag as: :diagnosis_code_pointer_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?-, ?0..?9, ?., ?|], min: 0, max: 2), {Parser, :number2, [0]}),
        :diagnosis_code_pointer_2
      )
    )

    # Parse element (1328 - Diagnosis Code Pointer) and tag as: :diagnosis_code_pointer_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?-, ?0..?9, ?., ?|], min: 0, max: 2), {Parser, :number2, [0]}),
        :diagnosis_code_pointer_3
      )
    )

    # Parse element (1328 - Diagnosis Code Pointer) and tag as: :diagnosis_code_pointer_4
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?-, ?0..?9, ?., ?|], min: 0, max: 2), {Parser, :number2, [0]}),
        :diagnosis_code_pointer_4
      )
    )

  @doc false
  defparsec(:element, combinator, export_combinator: true, inline: Mix.env() == :prod)
end