defmodule Edi.X12.Hipaa.R5010.Segments.ReferenceInformation do
  @moduledoc """
  `REF` - Reference Information

  To specify identifying information
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect, optional: [:reference_identification, :description, :reference_identifier]}
  @enforce_keys [
    :reference_identification_qualifier
  ]
  defstruct reference_identification_qualifier: nil,
            reference_identification: nil,
            description: nil,
            reference_identifier: nil

  ## Typespecs

  @type t :: %__MODULE__{
          reference_identification_qualifier: Identifier.t(),
          reference_identification: nil | binary(),
          description: nil | binary(),
          reference_identifier: nil | any()
        }

  ## Module attributes

  @prefix "REF"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :reference_identification_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/reference_identification_qualifier.json"
             )
  @external_resource @file_path
  @reference_identification_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (128 - Reference Identification Qualifier) and tag as: :reference_identification_qualifier
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], min: 2, max: 3),
        {Parser, :identifier, [@reference_identification_qualifier_values]}
      ),
      :reference_identification_qualifier
    )

    # Parse element (127 - Reference Identification) and tag as: :reference_identification
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 50), {Parser, :string, []}),
        :reference_identification
      )
    )

    # Parse element (352 - Description) and tag as: :description
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 80), {Parser, :string, []}),
        :description
      )
    )

    # Parse element (C040 - Reference Identifier) and tag as: :reference_identifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :reference_identifier
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end