defmodule Edi.X12.Hipaa.R5010.Elements.ReferenceIdentifier do
  @moduledoc """
  `C040` - Reference Identifier

  To identify one or more reference numbers or identification numbers as specified by the Reference Qualifier
  """

  use Edi.X12.Parser, parser: :element

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           except: [:__key__],
           optional: [
             :reference_identification_qualifier_2,
             :reference_identification_2,
             :reference_identification_qualifier_3,
             :reference_identification_3
           ]}
  @enforce_keys [
    :reference_identification_qualifier_1,
    :reference_identification_1
  ]
  defstruct __key__: :reference_identifier,
            reference_identification_qualifier_1: nil,
            reference_identification_1: nil,
            reference_identification_qualifier_2: nil,
            reference_identification_2: nil,
            reference_identification_qualifier_3: nil,
            reference_identification_3: nil

  ## Typespecs

  @type t :: %__MODULE__{
          __key__: :reference_identifier,
          reference_identification_qualifier_1: Identifier.t(),
          reference_identification_1: binary(),
          reference_identification_qualifier_2: nil | Identifier.t(),
          reference_identification_2: nil | binary(),
          reference_identification_qualifier_3: nil | Identifier.t(),
          reference_identification_3: nil | binary()
        }

  ## Module attributes

  @element_seperator ":"

  # Load the values for the values for :reference_identification_qualifier_1 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/reference_identification_qualifier_1.json"
             )
  @external_resource @file_path
  @reference_identification_qualifier_1_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :reference_identification_qualifier_2 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/reference_identification_qualifier_2.json"
             )
  @external_resource @file_path
  @reference_identification_qualifier_2_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :reference_identification_qualifier_3 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/reference_identification_qualifier_3.json"
             )
  @external_resource @file_path
  @reference_identification_qualifier_3_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()

    # Parse element (128 - Reference Identification Qualifier) and tag as: :reference_identification_qualifier_1
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], min: 2, max: 3),
        {Parser, :identifier, [@reference_identification_qualifier_1_values]}
      ),
      :reference_identification_qualifier_1
    )

    # Parse element (127 - Reference Identification) and tag as: :reference_identification_1
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1, max: 50), {Parser, :string, []}),
      :reference_identification_1
    )

    # Parse element (128 - Reference Identification Qualifier) and tag as: :reference_identification_qualifier_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@reference_identification_qualifier_2_values]}
        ),
        :reference_identification_qualifier_2
      )
    )

    # Parse element (127 - Reference Identification) and tag as: :reference_identification_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 50), {Parser, :string, []}),
        :reference_identification_2
      )
    )

    # Parse element (128 - Reference Identification Qualifier) and tag as: :reference_identification_qualifier_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@reference_identification_qualifier_3_values]}
        ),
        :reference_identification_qualifier_3
      )
    )

    # Parse element (127 - Reference Identification) and tag as: :reference_identification_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 50), {Parser, :string, []}),
        :reference_identification_3
      )
    )

  @doc false
  defparsec(:element, combinator, export_combinator: true, inline: Mix.env() == :prod)
end