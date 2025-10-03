defmodule Edi.X12.Hipaa.R5010.Elements.HealthCareCodeInformation do
  @moduledoc """
  `C022` - Health Care Code Information

  To send health care codes and their associated dates, amounts and quantities
  """

  use Edi.X12.Parser, parser: :element

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           except: [:__key__],
           optional: [
             :date_time_period_format_qualifier,
             :date_time_period,
             :monetary_amount,
             :quantity,
             :version_identifier,
             :industry_code_2,
             :yes_no_condition_or_response_code
           ]}
  @enforce_keys [
    :code_list_qualifier_code,
    :industry_code_1
  ]
  defstruct __key__: :health_care_code_information_12,
            code_list_qualifier_code: nil,
            industry_code_1: nil,
            date_time_period_format_qualifier: nil,
            date_time_period: nil,
            monetary_amount: nil,
            quantity: nil,
            version_identifier: nil,
            industry_code_2: nil,
            yes_no_condition_or_response_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          __key__: :health_care_code_information_12,
          code_list_qualifier_code: Identifier.t(),
          industry_code_1: binary(),
          date_time_period_format_qualifier: nil | Identifier.t(),
          date_time_period: nil | binary(),
          monetary_amount: nil | number(),
          quantity: nil | number(),
          version_identifier: nil | binary(),
          industry_code_2: nil | binary(),
          yes_no_condition_or_response_code: nil | Identifier.t()
        }

  ## Module attributes

  @element_seperator ":"

  # Load the values for the values for :code_list_qualifier_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/code_list_qualifier_code.json"
             )
  @external_resource @file_path
  @code_list_qualifier_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :date_time_period_format_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/date_time_period_format_qualifier.json"
             )
  @external_resource @file_path
  @date_time_period_format_qualifier_values @file_path |> File.read!() |> Jason.decode!()

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

    # Parse element (1270 - Code List Qualifier Code) and tag as: :code_list_qualifier_code
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], min: 1, max: 3),
        {Parser, :identifier, [@code_list_qualifier_code_values]}
      ),
      :code_list_qualifier_code
    )

    # Parse element (1271 - Industry Code) and tag as: :industry_code_1
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1, max: 30), {Parser, :string, []}),
      :industry_code_1
    )

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

    # Parse element (782 - Monetary Amount) and tag as: :monetary_amount
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 18), {Parser, :decimal2, []}),
        :monetary_amount
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

    # Parse element (799 - Version Identifier) and tag as: :version_identifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 30), {Parser, :string, []}),
        :version_identifier
      )
    )

    # Parse element (1271 - Industry Code) and tag as: :industry_code_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 30), {Parser, :string, []}),
        :industry_code_2
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