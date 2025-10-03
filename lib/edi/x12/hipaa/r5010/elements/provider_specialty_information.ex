defmodule Edi.X12.Hipaa.R5010.Elements.ProviderSpecialtyInformation do
  @moduledoc """
  `C035` - Provider Specialty Information

  To provide provider specialty information
  """

  use Edi.X12.Parser, parser: :element

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           except: [:__key__],
           optional: [:agency_qualifier_code, :yes_no_condition_or_response_code]}
  @enforce_keys [
    :provider_specialty_code
  ]
  defstruct __key__: :provider_specialty_information,
            provider_specialty_code: nil,
            agency_qualifier_code: nil,
            yes_no_condition_or_response_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          __key__: :provider_specialty_information,
          provider_specialty_code: binary(),
          agency_qualifier_code: nil | Identifier.t(),
          yes_no_condition_or_response_code: nil | Identifier.t()
        }

  ## Module attributes

  @element_seperator ":"

  # Load the values for the values for :agency_qualifier_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/agency_qualifier_code.json"
             )
  @external_resource @file_path
  @agency_qualifier_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :yes_no_condition_or_response_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/yes_no_condition_or_response_code.json"
             )
  @external_resource @file_path
  @yes_no_condition_or_response_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()

    # Parse element (1222 - Provider Specialty Code) and tag as: :provider_specialty_code
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1, max: 3), {Parser, :string, []}),
      :provider_specialty_code
    )

    # Parse element (559 - Agency Qualifier Code) and tag as: :agency_qualifier_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@agency_qualifier_code_values]}
        ),
        :agency_qualifier_code
      )
    )

    # Parse element (1073 - Yes/No Condition or Response Code) and tag as: :yes_no_condition_or_response_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@yes_no_condition_or_response_code_values]}
        ),
        :yes_no_condition_or_response_code
      )
    )

  @doc false
  defparsec(:element, combinator, export_combinator: true, inline: Mix.env() == :prod)
end