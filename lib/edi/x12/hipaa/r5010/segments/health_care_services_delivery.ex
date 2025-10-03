defmodule Edi.X12.Hipaa.R5010.Segments.HealthCareServicesDelivery do
  @moduledoc """
  `HSD` - Health Care Services Delivery

  To specify the delivery pattern of health care services
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [
             :quantity_qualifier,
             :quantity,
             :unit_or_basis_for_measurement_code,
             :sample_selection_modulus,
             :time_period_qualifier,
             :number_of_periods,
             :ship_delivery_or_calendar_pattern_code,
             :ship_delivery_pattern_time_code
           ]}
  @enforce_keys []
  defstruct quantity_qualifier: nil,
            quantity: nil,
            unit_or_basis_for_measurement_code: nil,
            sample_selection_modulus: nil,
            time_period_qualifier: nil,
            number_of_periods: nil,
            ship_delivery_or_calendar_pattern_code: nil,
            ship_delivery_pattern_time_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          quantity_qualifier: nil | Identifier.t(),
          quantity: nil | number(),
          unit_or_basis_for_measurement_code: nil | Identifier.t(),
          sample_selection_modulus: nil | number(),
          time_period_qualifier: nil | Identifier.t(),
          number_of_periods: nil | number(),
          ship_delivery_or_calendar_pattern_code: nil | Identifier.t(),
          ship_delivery_pattern_time_code: nil | Identifier.t()
        }

  ## Module attributes

  @prefix "HSD"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :quantity_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/quantity_qualifier.json"
             )
  @external_resource @file_path
  @quantity_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :unit_or_basis_for_measurement_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/unit_or_basis_for_measurement_code.json"
             )
  @external_resource @file_path
  @unit_or_basis_for_measurement_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :time_period_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/time_period_qualifier.json"
             )
  @external_resource @file_path
  @time_period_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :ship_delivery_or_calendar_pattern_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/ship_delivery_or_calendar_pattern_code.json"
             )
  @external_resource @file_path
  @ship_delivery_or_calendar_pattern_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :ship_delivery_pattern_time_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/ship_delivery_pattern_time_code.json"
             )
  @external_resource @file_path
  @ship_delivery_pattern_time_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

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

    # Parse element (355 - Unit or Basis for Measurement Code) and tag as: :unit_or_basis_for_measurement_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@unit_or_basis_for_measurement_code_values]}
        ),
        :unit_or_basis_for_measurement_code
      )
    )

    # Parse element (1167 - Sample Selection Modulus) and tag as: :sample_selection_modulus
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 6), {Parser, :decimal2, []}),
        :sample_selection_modulus
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

    # Parse element (616 - Number of Periods) and tag as: :number_of_periods
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?-, ?0..?9, ?., ?|], min: 0, max: 3), {Parser, :number2, [0]}),
        :number_of_periods
      )
    )

    # Parse element (678 - Ship/Delivery or Calendar Pattern Code) and tag as: :ship_delivery_or_calendar_pattern_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@ship_delivery_or_calendar_pattern_code_values]}
        ),
        :ship_delivery_or_calendar_pattern_code
      )
    )

    # Parse element (679 - Ship/Delivery Pattern Time Code) and tag as: :ship_delivery_pattern_time_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@ship_delivery_pattern_time_code_values]}
        ),
        :ship_delivery_pattern_time_code
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end