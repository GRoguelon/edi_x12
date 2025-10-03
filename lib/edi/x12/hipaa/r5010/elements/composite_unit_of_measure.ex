defmodule Edi.X12.Hipaa.R5010.Elements.CompositeUnitOfMeasure do
  @moduledoc """
  `C001` - Composite Unit of Measure

  To identify a composite unit of measure

  (See Figures Appendix for examples of use)
  """

  use Edi.X12.Parser, parser: :element

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           except: [:__key__],
           optional: [
             :exponent_1,
             :multiplier_1,
             :unit_or_basis_for_measurement_code_2,
             :exponent_2,
             :multiplier_2,
             :unit_or_basis_for_measurement_code_3,
             :exponent_3,
             :multiplier_3,
             :unit_or_basis_for_measurement_code_4,
             :exponent_4,
             :multiplier_4,
             :unit_or_basis_for_measurement_code_5,
             :exponent_5,
             :multiplier_5
           ]}
  @enforce_keys [
    :unit_or_basis_for_measurement_code_1
  ]
  defstruct __key__: :composite_unit_of_measure,
            unit_or_basis_for_measurement_code_1: nil,
            exponent_1: nil,
            multiplier_1: nil,
            unit_or_basis_for_measurement_code_2: nil,
            exponent_2: nil,
            multiplier_2: nil,
            unit_or_basis_for_measurement_code_3: nil,
            exponent_3: nil,
            multiplier_3: nil,
            unit_or_basis_for_measurement_code_4: nil,
            exponent_4: nil,
            multiplier_4: nil,
            unit_or_basis_for_measurement_code_5: nil,
            exponent_5: nil,
            multiplier_5: nil

  ## Typespecs

  @type t :: %__MODULE__{
          __key__: :composite_unit_of_measure,
          unit_or_basis_for_measurement_code_1: Identifier.t(),
          exponent_1: nil | number(),
          multiplier_1: nil | number(),
          unit_or_basis_for_measurement_code_2: nil | Identifier.t(),
          exponent_2: nil | number(),
          multiplier_2: nil | number(),
          unit_or_basis_for_measurement_code_3: nil | Identifier.t(),
          exponent_3: nil | number(),
          multiplier_3: nil | number(),
          unit_or_basis_for_measurement_code_4: nil | Identifier.t(),
          exponent_4: nil | number(),
          multiplier_4: nil | number(),
          unit_or_basis_for_measurement_code_5: nil | Identifier.t(),
          exponent_5: nil | number(),
          multiplier_5: nil | number()
        }

  ## Module attributes

  @element_seperator ":"

  # Load the values for the values for :unit_or_basis_for_measurement_code_1 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/unit_or_basis_for_measurement_code_1.json"
             )
  @external_resource @file_path
  @unit_or_basis_for_measurement_code_1_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :unit_or_basis_for_measurement_code_2 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/unit_or_basis_for_measurement_code_2.json"
             )
  @external_resource @file_path
  @unit_or_basis_for_measurement_code_2_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :unit_or_basis_for_measurement_code_3 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/unit_or_basis_for_measurement_code_3.json"
             )
  @external_resource @file_path
  @unit_or_basis_for_measurement_code_3_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :unit_or_basis_for_measurement_code_4 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/unit_or_basis_for_measurement_code_4.json"
             )
  @external_resource @file_path
  @unit_or_basis_for_measurement_code_4_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :unit_or_basis_for_measurement_code_5 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/unit_or_basis_for_measurement_code_5.json"
             )
  @external_resource @file_path
  @unit_or_basis_for_measurement_code_5_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()

    # Parse element (355 - Unit or Basis for Measurement Code) and tag as: :unit_or_basis_for_measurement_code_1
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@unit_or_basis_for_measurement_code_1_values]}
      ),
      :unit_or_basis_for_measurement_code_1
    )

    # Parse element (1018 - Exponent) and tag as: :exponent_1
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 15), {Parser, :decimal2, []}),
        :exponent_1
      )
    )

    # Parse element (649 - Multiplier) and tag as: :multiplier_1
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 10), {Parser, :decimal2, []}),
        :multiplier_1
      )
    )

    # Parse element (355 - Unit or Basis for Measurement Code) and tag as: :unit_or_basis_for_measurement_code_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@unit_or_basis_for_measurement_code_2_values]}
        ),
        :unit_or_basis_for_measurement_code_2
      )
    )

    # Parse element (1018 - Exponent) and tag as: :exponent_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 15), {Parser, :decimal2, []}),
        :exponent_2
      )
    )

    # Parse element (649 - Multiplier) and tag as: :multiplier_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 10), {Parser, :decimal2, []}),
        :multiplier_2
      )
    )

    # Parse element (355 - Unit or Basis for Measurement Code) and tag as: :unit_or_basis_for_measurement_code_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@unit_or_basis_for_measurement_code_3_values]}
        ),
        :unit_or_basis_for_measurement_code_3
      )
    )

    # Parse element (1018 - Exponent) and tag as: :exponent_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 15), {Parser, :decimal2, []}),
        :exponent_3
      )
    )

    # Parse element (649 - Multiplier) and tag as: :multiplier_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 10), {Parser, :decimal2, []}),
        :multiplier_3
      )
    )

    # Parse element (355 - Unit or Basis for Measurement Code) and tag as: :unit_or_basis_for_measurement_code_4
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@unit_or_basis_for_measurement_code_4_values]}
        ),
        :unit_or_basis_for_measurement_code_4
      )
    )

    # Parse element (1018 - Exponent) and tag as: :exponent_4
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 15), {Parser, :decimal2, []}),
        :exponent_4
      )
    )

    # Parse element (649 - Multiplier) and tag as: :multiplier_4
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 10), {Parser, :decimal2, []}),
        :multiplier_4
      )
    )

    # Parse element (355 - Unit or Basis for Measurement Code) and tag as: :unit_or_basis_for_measurement_code_5
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@unit_or_basis_for_measurement_code_5_values]}
        ),
        :unit_or_basis_for_measurement_code_5
      )
    )

    # Parse element (1018 - Exponent) and tag as: :exponent_5
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 15), {Parser, :decimal2, []}),
        :exponent_5
      )
    )

    # Parse element (649 - Multiplier) and tag as: :multiplier_5
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?0..?9, ?-, ?., ?|], min: 0, max: 10), {Parser, :decimal2, []}),
        :multiplier_5
      )
    )

  @doc false
  defparsec(:element, combinator, export_combinator: true, inline: Mix.env() == :prod)
end