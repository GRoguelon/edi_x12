defmodule Edi.X12.Hipaa.R5010.Segments.ProviderInformation do
  @moduledoc """
  `PRV` - Provider Information

  To specify the identifying characteristics of a provider
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [
             :reference_identification_qualifier,
             :reference_identification,
             :state_or_province_code,
             :provider_specialty_information,
             :provider_organization_code
           ]}
  @enforce_keys [
    :provider_code
  ]
  defstruct provider_code: nil,
            reference_identification_qualifier: nil,
            reference_identification: nil,
            state_or_province_code: nil,
            provider_specialty_information: nil,
            provider_organization_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          provider_code: Identifier.t(),
          reference_identification_qualifier: nil | Identifier.t(),
          reference_identification: nil | binary(),
          state_or_province_code: nil | Identifier.t(),
          provider_specialty_information: nil | any(),
          provider_organization_code: nil | Identifier.t()
        }

  ## Module attributes

  @prefix "PRV"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :provider_code %>
  @file_path Application.app_dir(:edi_x12, "priv/element_values/hipaa/r5010/provider_code.json")
  @external_resource @file_path
  @provider_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :reference_identification_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/reference_identification_qualifier.json"
             )
  @external_resource @file_path
  @reference_identification_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :state_or_province_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/state_or_province_code.json"
             )
  @external_resource @file_path
  @state_or_province_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :provider_organization_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/provider_organization_code.json"
             )
  @external_resource @file_path
  @provider_organization_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (1221 - Provider Code) and tag as: :provider_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], min: 1, max: 3),
        {Parser, :identifier, [@provider_code_values]}
      ),
      :provider_code
    )

    # Parse element (128 - Reference Identification Qualifier) and tag as: :reference_identification_qualifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@reference_identification_qualifier_values]}
        ),
        :reference_identification_qualifier
      )
    )

    # Parse element (127 - Reference Identification) and tag as: :reference_identification
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 50), {Parser, :string, []}),
        :reference_identification
      )
    )

    # Parse element (156 - State or Province Code) and tag as: :state_or_province_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@state_or_province_code_values]}
        ),
        :state_or_province_code
      )
    )

    # Parse element (C035 - Provider Specialty Information) and tag as: :provider_specialty_information
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :provider_specialty_information
      )
    )

    # Parse element (1223 - Provider Organization Code) and tag as: :provider_organization_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@provider_organization_code_values]}
        ),
        :provider_organization_code
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end