defmodule Edi.X12.Hipaa.R5010.Segments.EligibilityOrBenefitInformation do
  @moduledoc """
  `EB` - Eligibility or Benefit Information

  To supply eligibility or benefit information
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [
             :coverage_level_code,
             :service_type_code,
             :insurance_type_code,
             :plan_coverage_description,
             :time_period_qualifier,
             :monetary_amount,
             :percentage_as_decimal,
             :quantity_qualifier,
             :quantity,
             :yes_no_condition_or_response_code_1,
             :yes_no_condition_or_response_code_2,
             :composite_medical_procedure_identifier,
             :composite_diagnosis_code_pointer
           ]}
  @enforce_keys [
    :eligibility_or_benefit_information_code
  ]
  defstruct eligibility_or_benefit_information_code: nil,
            coverage_level_code: nil,
            service_type_code: nil,
            insurance_type_code: nil,
            plan_coverage_description: nil,
            time_period_qualifier: nil,
            monetary_amount: nil,
            percentage_as_decimal: nil,
            quantity_qualifier: nil,
            quantity: nil,
            yes_no_condition_or_response_code_1: nil,
            yes_no_condition_or_response_code_2: nil,
            composite_medical_procedure_identifier: nil,
            composite_diagnosis_code_pointer: nil

  ## Typespecs

  @type t :: %__MODULE__{
          eligibility_or_benefit_information_code: Identifier.t(),
          coverage_level_code: nil | Identifier.t(),
          service_type_code: nil | Identifier.t(),
          insurance_type_code: nil | Identifier.t(),
          plan_coverage_description: nil | binary(),
          time_period_qualifier: nil | Identifier.t(),
          monetary_amount: nil | number(),
          percentage_as_decimal: nil | number(),
          quantity_qualifier: nil | Identifier.t(),
          quantity: nil | number(),
          yes_no_condition_or_response_code_1: nil | Identifier.t(),
          yes_no_condition_or_response_code_2: nil | Identifier.t(),
          composite_medical_procedure_identifier: nil | any(),
          composite_diagnosis_code_pointer: nil | any()
        }

  ## Module attributes

  @prefix "EB"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :eligibility_or_benefit_information_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/eligibility_or_benefit_information_code.json"
             )
  @external_resource @file_path
  @eligibility_or_benefit_information_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :coverage_level_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/coverage_level_code.json"
             )
  @external_resource @file_path
  @coverage_level_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :service_type_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/service_type_code.json"
             )
  @external_resource @file_path
  @service_type_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :insurance_type_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/insurance_type_code.json"
             )
  @external_resource @file_path
  @insurance_type_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :time_period_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/time_period_qualifier.json"
             )
  @external_resource @file_path
  @time_period_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :quantity_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/quantity_qualifier.json"
             )
  @external_resource @file_path
  @quantity_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :yes_no_condition_or_response_code_1 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/yes_no_condition_or_response_code.json"
             )
  @external_resource @file_path
  @yes_no_condition_or_response_code_1_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :yes_no_condition_or_response_code_2 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/yes_no_condition_or_response_code.json"
             )
  @external_resource @file_path
  @yes_no_condition_or_response_code_2_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (1390 - Eligibility or Benefit Information Code) and tag as: :eligibility_or_benefit_information_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], min: 1, max: 2),
        {Parser, :identifier, [@eligibility_or_benefit_information_code_values]}
      ),
      :eligibility_or_benefit_information_code
    )

    # Parse element (1207 - Coverage Level Code) and tag as: :coverage_level_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@coverage_level_code_values]}
        ),
        :coverage_level_code
      )
    )

    # Parse element (1365 - Service Type Code) and tag as: :service_type_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 296),
          {Parser, :identifier, [@service_type_code_values]}
        ),
        :service_type_code
      )
    )

    # Parse element (1336 - Insurance Type Code) and tag as: :insurance_type_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@insurance_type_code_values]}
        ),
        :insurance_type_code
      )
    )

    # Parse element (1204 - Plan Coverage Description) and tag as: :plan_coverage_description
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 50), {Parser, :string, []}),
        :plan_coverage_description
      )
    )

    # Parse element (615 - Time Period Qualifier) and tag as: :time_period_qualifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@time_period_qualifier_values]}
        ),
        :time_period_qualifier
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

    # Parse element (954 - Percentage as Decimal) and tag as: :percentage_as_decimal
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 10), {Parser, :decimal2, []}),
        :percentage_as_decimal
      )
    )

    # Parse element (673 - Quantity Qualifier) and tag as: :quantity_qualifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@quantity_qualifier_values]}
        ),
        :quantity_qualifier
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

    # Parse element (1073 - Yes/No Condition or Response Code) and tag as: :yes_no_condition_or_response_code_1
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@yes_no_condition_or_response_code_1_values]}
        ),
        :yes_no_condition_or_response_code_1
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

    # Parse element (C003 - Composite Medical Procedure Identifier) and tag as: :composite_medical_procedure_identifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :composite_medical_procedure_identifier
      )
    )

    # Parse element (C004 - Composite Diagnosis Code Pointer) and tag as: :composite_diagnosis_code_pointer
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :composite_diagnosis_code_pointer
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end