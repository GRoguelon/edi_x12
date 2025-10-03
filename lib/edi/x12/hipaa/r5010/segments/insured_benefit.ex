defmodule Edi.X12.Hipaa.R5010.Segments.InsuredBenefit do
  @moduledoc """
  `INS` - Insured Benefit

  To provide benefit information on insured entities
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [
             :maintenance_type_code,
             :maintenance_reason_code,
             :benefit_status_code,
             :medicare_status_code,
             :consolidated_omnibus_budget_reconciliation_act_cobra_qualifying_event_code,
             :employment_status_code,
             :student_status_code,
             :yes_no_condition_or_response_code_2,
             :date_time_period_format_qualifier,
             :date_time_period,
             :confidentiality_code,
             :city_name,
             :state_or_province_code,
             :country_code,
             :number
           ]}
  @enforce_keys [
    :yes_no_condition_or_response_code_1,
    :individual_relationship_code
  ]
  defstruct yes_no_condition_or_response_code_1: nil,
            individual_relationship_code: nil,
            maintenance_type_code: nil,
            maintenance_reason_code: nil,
            benefit_status_code: nil,
            medicare_status_code: nil,
            consolidated_omnibus_budget_reconciliation_act_cobra_qualifying_event_code: nil,
            employment_status_code: nil,
            student_status_code: nil,
            yes_no_condition_or_response_code_2: nil,
            date_time_period_format_qualifier: nil,
            date_time_period: nil,
            confidentiality_code: nil,
            city_name: nil,
            state_or_province_code: nil,
            country_code: nil,
            number: nil

  ## Typespecs

  @type t :: %__MODULE__{
          yes_no_condition_or_response_code_1: Identifier.t(),
          individual_relationship_code: Identifier.t(),
          maintenance_type_code: nil | Identifier.t(),
          maintenance_reason_code: nil | Identifier.t(),
          benefit_status_code: nil | Identifier.t(),
          medicare_status_code: nil | any(),
          consolidated_omnibus_budget_reconciliation_act_cobra_qualifying_event_code:
            nil | Identifier.t(),
          employment_status_code: nil | Identifier.t(),
          student_status_code: nil | Identifier.t(),
          yes_no_condition_or_response_code_2: nil | Identifier.t(),
          date_time_period_format_qualifier: nil | Identifier.t(),
          date_time_period: nil | binary(),
          confidentiality_code: nil | Identifier.t(),
          city_name: nil | binary(),
          state_or_province_code: nil | Identifier.t(),
          country_code: nil | Identifier.t(),
          number: nil | number()
        }

  ## Module attributes

  @prefix "INS"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :yes_no_condition_or_response_code_1 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/yes_no_condition_or_response_code_1.json"
             )
  @external_resource @file_path
  @yes_no_condition_or_response_code_1_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :individual_relationship_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/individual_relationship_code.json"
             )
  @external_resource @file_path
  @individual_relationship_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :maintenance_type_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/maintenance_type_code.json"
             )
  @external_resource @file_path
  @maintenance_type_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :maintenance_reason_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/maintenance_reason_code.json"
             )
  @external_resource @file_path
  @maintenance_reason_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :benefit_status_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/benefit_status_code.json"
             )
  @external_resource @file_path
  @benefit_status_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :consolidated_omnibus_budget_reconciliation_act_cobra_qualifying_event_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/consolidated_omnibus_budget_reconciliation_act_cobra_qualifying_event_code.json"
             )
  @external_resource @file_path
  @consolidated_omnibus_budget_reconciliation_act_cobra_qualifying_event_code_values @file_path
                                                                                     |> File.read!()
                                                                                     |> Jason.decode!()

  # Load the values for the values for :employment_status_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/employment_status_code.json"
             )
  @external_resource @file_path
  @employment_status_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :student_status_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/student_status_code.json"
             )
  @external_resource @file_path
  @student_status_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :yes_no_condition_or_response_code_2 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/yes_no_condition_or_response_code_2.json"
             )
  @external_resource @file_path
  @yes_no_condition_or_response_code_2_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :date_time_period_format_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/date_time_period_format_qualifier.json"
             )
  @external_resource @file_path
  @date_time_period_format_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :confidentiality_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/confidentiality_code.json"
             )
  @external_resource @file_path
  @confidentiality_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :state_or_province_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/state_or_province_code.json"
             )
  @external_resource @file_path
  @state_or_province_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :country_code %>
  @file_path Application.app_dir(:edi_x12, "priv/element_values/hipaa/r5010/country_code.json")
  @external_resource @file_path
  @country_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (1073 - Yes/No Condition or Response Code) and tag as: :yes_no_condition_or_response_code_1
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 1),
        {Parser, :identifier, [@yes_no_condition_or_response_code_1_values]}
      ),
      :yes_no_condition_or_response_code_1
    )

    # Parse element (1069 - Individual Relationship Code) and tag as: :individual_relationship_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@individual_relationship_code_values]}
      ),
      :individual_relationship_code
    )

    # Parse element (875 - Maintenance Type Code) and tag as: :maintenance_type_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@maintenance_type_code_values]}
        ),
        :maintenance_type_code
      )
    )

    # Parse element (1203 - Maintenance Reason Code) and tag as: :maintenance_reason_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@maintenance_reason_code_values]}
        ),
        :maintenance_reason_code
      )
    )

    # Parse element (1216 - Benefit Status Code) and tag as: :benefit_status_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@benefit_status_code_values]}
        ),
        :benefit_status_code
      )
    )

    # Parse element (C052 - Medicare Status Code) and tag as: :medicare_status_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :medicare_status_code
      )
    )

    # Parse element (1219 - Consolidated Omnibus Budget Reconciliation Act (COBRA) Qualifying Event Code) and tag as: :consolidated_omnibus_budget_reconciliation_act_cobra_qualifying_event_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier,
           [@consolidated_omnibus_budget_reconciliation_act_cobra_qualifying_event_code_values]}
        ),
        :consolidated_omnibus_budget_reconciliation_act_cobra_qualifying_event_code
      )
    )

    # Parse element (584 - Employment Status Code) and tag as: :employment_status_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@employment_status_code_values]}
        ),
        :employment_status_code
      )
    )

    # Parse element (1220 - Student Status Code) and tag as: :student_status_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@student_status_code_values]}
        ),
        :student_status_code
      )
    )

    # Parse element (1073 - Yes/No Condition or Response Code) and tag as: :yes_no_condition_or_response_code_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@yes_no_condition_or_response_code_2_values]}
        ),
        :yes_no_condition_or_response_code_2
      )
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

    # Parse element (1165 - Confidentiality Code) and tag as: :confidentiality_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@confidentiality_code_values]}
        ),
        :confidentiality_code
      )
    )

    # Parse element (19 - City Name) and tag as: :city_name
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 30), {Parser, :string, []}),
        :city_name
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

    # Parse element (1470 - Number) and tag as: :number
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?-, ?0..?9, ?., ?|], min: 0, max: 9), {Parser, :number2, [0]}),
        :number
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end