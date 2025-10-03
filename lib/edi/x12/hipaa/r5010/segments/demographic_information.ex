defmodule Edi.X12.Hipaa.R5010.Segments.DemographicInformation do
  @moduledoc """
  `DMG` - Demographic Information

  To supply demographic information
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [
             :date_time_period_format_qualifier,
             :date_time_period,
             :gender_code,
             :marital_status_code,
             :composite_race_or_ethnicity_information,
             :citizenship_status_code,
             :country_code,
             :basis_of_verification_code,
             :quantity,
             :code_list_qualifier_code,
             :industry_code
           ]}
  @enforce_keys []
  defstruct date_time_period_format_qualifier: nil,
            date_time_period: nil,
            gender_code: nil,
            marital_status_code: nil,
            composite_race_or_ethnicity_information: nil,
            citizenship_status_code: nil,
            country_code: nil,
            basis_of_verification_code: nil,
            quantity: nil,
            code_list_qualifier_code: nil,
            industry_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          date_time_period_format_qualifier: nil | Identifier.t(),
          date_time_period: nil | binary(),
          gender_code: nil | Identifier.t(),
          marital_status_code: nil | Identifier.t(),
          composite_race_or_ethnicity_information: nil | any(),
          citizenship_status_code: nil | Identifier.t(),
          country_code: nil | Identifier.t(),
          basis_of_verification_code: nil | Identifier.t(),
          quantity: nil | number(),
          code_list_qualifier_code: nil | Identifier.t(),
          industry_code: nil | binary()
        }

  ## Module attributes

  @prefix "DMG"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :date_time_period_format_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/date_time_period_format_qualifier.json"
             )
  @external_resource @file_path
  @date_time_period_format_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :gender_code %>
  @file_path Application.app_dir(:edi_x12, "priv/element_values/hipaa/r5010/gender_code.json")
  @external_resource @file_path
  @gender_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :marital_status_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/marital_status_code.json"
             )
  @external_resource @file_path
  @marital_status_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :citizenship_status_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/citizenship_status_code.json"
             )
  @external_resource @file_path
  @citizenship_status_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :country_code %>
  @file_path Application.app_dir(:edi_x12, "priv/element_values/hipaa/r5010/country_code.json")
  @external_resource @file_path
  @country_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :basis_of_verification_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/basis_of_verification_code.json"
             )
  @external_resource @file_path
  @basis_of_verification_code_values @file_path |> File.read!() |> Jason.decode!()

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
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (1250 - Date Time Period Format Qualifier) and tag as: :date_time_period_format_qualifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@date_time_period_format_qualifier_values]}
        ),
        :date_time_period_format_qualifier
      )
    )

    # Parse element (1251 - Date Time Period) and tag as: :date_time_period
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 35), {Parser, :string, []}),
        :date_time_period
      )
    )

    # Parse element (1068 - Gender Code) and tag as: :gender_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@gender_code_values]}
        ),
        :gender_code
      )
    )

    # Parse element (1067 - Marital Status Code) and tag as: :marital_status_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@marital_status_code_values]}
        ),
        :marital_status_code
      )
    )

    # Parse element (C056 - Composite Race or Ethnicity Information) and tag as: :composite_race_or_ethnicity_information
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :composite_race_or_ethnicity_information
      )
    )

    # Parse element (1066 - Citizenship Status Code) and tag as: :citizenship_status_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@citizenship_status_code_values]}
        ),
        :citizenship_status_code
      )
    )

    # Parse element (26 - Country Code) and tag as: :country_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@country_code_values]}
        ),
        :country_code
      )
    )

    # Parse element (659 - Basis of Verification Code) and tag as: :basis_of_verification_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@basis_of_verification_code_values]}
        ),
        :basis_of_verification_code
      )
    )

    # Parse element (380 - Quantity) and tag as: :quantity
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 15), {Parser, :decimal2, []}),
        :quantity
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

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end