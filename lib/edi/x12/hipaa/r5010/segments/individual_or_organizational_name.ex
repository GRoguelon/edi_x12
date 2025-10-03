defmodule Edi.X12.Hipaa.R5010.Segments.IndividualOrOrganizationalName do
  @moduledoc """
  `NM1` - Individual or Organizational Name

  To supply the full name of an individual or organizational entity
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [
             :name_last_or_organization_name_1,
             :name_first,
             :name_middle,
             :name_prefix,
             :name_suffix,
             :identification_code_qualifier,
             :identification_code,
             :entity_relationship_code,
             :entity_identifier_code_2,
             :name_last_or_organization_name_2
           ]}
  @enforce_keys [
    :entity_identifier_code_1,
    :entity_type_qualifier
  ]
  defstruct entity_identifier_code_1: nil,
            entity_type_qualifier: nil,
            name_last_or_organization_name_1: nil,
            name_first: nil,
            name_middle: nil,
            name_prefix: nil,
            name_suffix: nil,
            identification_code_qualifier: nil,
            identification_code: nil,
            entity_relationship_code: nil,
            entity_identifier_code_2: nil,
            name_last_or_organization_name_2: nil

  ## Typespecs

  @type t :: %__MODULE__{
          entity_identifier_code_1: Identifier.t(),
          entity_type_qualifier: Identifier.t(),
          name_last_or_organization_name_1: nil | binary(),
          name_first: nil | binary(),
          name_middle: nil | binary(),
          name_prefix: nil | binary(),
          name_suffix: nil | binary(),
          identification_code_qualifier: nil | Identifier.t(),
          identification_code: nil | binary(),
          entity_relationship_code: nil | Identifier.t(),
          entity_identifier_code_2: nil | Identifier.t(),
          name_last_or_organization_name_2: nil | binary()
        }

  ## Module attributes

  @prefix "NM1"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :entity_identifier_code_1 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/entity_identifier_code_1.json"
             )
  @external_resource @file_path
  @entity_identifier_code_1_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :entity_type_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/entity_type_qualifier.json"
             )
  @external_resource @file_path
  @entity_type_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :identification_code_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/identification_code_qualifier.json"
             )
  @external_resource @file_path
  @identification_code_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :entity_relationship_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/entity_relationship_code.json"
             )
  @external_resource @file_path
  @entity_relationship_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :entity_identifier_code_2 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/entity_identifier_code_2.json"
             )
  @external_resource @file_path
  @entity_identifier_code_2_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (98 - Entity Identifier Code) and tag as: :entity_identifier_code_1
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], min: 2, max: 3),
        {Parser, :identifier, [@entity_identifier_code_1_values]}
      ),
      :entity_identifier_code_1
    )

    # Parse element (1065 - Entity Type Qualifier) and tag as: :entity_type_qualifier
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 1),
        {Parser, :identifier, [@entity_type_qualifier_values]}
      ),
      :entity_type_qualifier
    )

    # Parse element (1035 - Name Last or Organization Name) and tag as: :name_last_or_organization_name_1
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 60), {Parser, :string, []}),
        :name_last_or_organization_name_1
      )
    )

    # Parse element (1036 - Name First) and tag as: :name_first
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 35), {Parser, :string, []}),
        :name_first
      )
    )

    # Parse element (1037 - Name Middle) and tag as: :name_middle
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 25), {Parser, :string, []}),
        :name_middle
      )
    )

    # Parse element (1038 - Name Prefix) and tag as: :name_prefix
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 10), {Parser, :string, []}),
        :name_prefix
      )
    )

    # Parse element (1039 - Name Suffix) and tag as: :name_suffix
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 10), {Parser, :string, []}),
        :name_suffix
      )
    )

    # Parse element (66 - Identification Code Qualifier) and tag as: :identification_code_qualifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@identification_code_qualifier_values]}
        ),
        :identification_code_qualifier
      )
    )

    # Parse element (67 - Identification Code) and tag as: :identification_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 80), {Parser, :string, []}),
        :identification_code
      )
    )

    # Parse element (706 - Entity Relationship Code) and tag as: :entity_relationship_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@entity_relationship_code_values]}
        ),
        :entity_relationship_code
      )
    )

    # Parse element (98 - Entity Identifier Code) and tag as: :entity_identifier_code_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@entity_identifier_code_2_values]}
        ),
        :entity_identifier_code_2
      )
    )

    # Parse element (1035 - Name Last or Organization Name) and tag as: :name_last_or_organization_name_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 60), {Parser, :string, []}),
        :name_last_or_organization_name_2
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end