defmodule Edi.X12.Hipaa.R5010.Elements.CompositeRaceOrEthnicityInformation do
  @moduledoc """
  `C056` - Composite Race or Ethnicity Information

  To send general and detailed information on race or ethnicity
  """

  use Edi.X12.Parser, parser: :element

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           except: [:__key__],
           optional: [:race_or_ethnicity_code, :code_list_qualifier_code, :industry_code]}
  @enforce_keys []
  defstruct __key__: :composite_race_or_ethnicity_information,
            race_or_ethnicity_code: nil,
            code_list_qualifier_code: nil,
            industry_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          __key__: :composite_race_or_ethnicity_information,
          race_or_ethnicity_code: nil | Identifier.t(),
          code_list_qualifier_code: nil | Identifier.t(),
          industry_code: nil | binary()
        }

  ## Module attributes

  @element_seperator ":"

  # Load the values for the values for :race_or_ethnicity_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/race_or_ethnicity_code.json"
             )
  @external_resource @file_path
  @race_or_ethnicity_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :code_list_qualifier_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/code_list_qualifier_code.json"
             )
  @external_resource @file_path
  @code_list_qualifier_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()

    # Parse element (1109 - Race or Ethnicity Code) and tag as: :race_or_ethnicity_code
    |> optional(
      unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@race_or_ethnicity_code_values]}
        ),
        :race_or_ethnicity_code
      )
    )

    # Parse element (1270 - Code List Qualifier Code) and tag as: :code_list_qualifier_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@code_list_qualifier_code_values]}
        ),
        :code_list_qualifier_code
      )
    )

    # Parse element (1271 - Industry Code) and tag as: :industry_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 30), {Parser, :string, []}),
        :industry_code
      )
    )

  @doc false
  defparsec(:element, combinator, export_combinator: true, inline: Mix.env() == :prod)
end