defmodule Edi.X12.Hipaa.R5010.Segments.Information do
  @moduledoc """
  `III` - Information

  To report information
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [
             :code_list_qualifier_code,
             :industry_code,
             :code_category,
             :free_form_message_text,
             :quantity,
             :composite_unit_of_measure,
             :surface_layer_position_code_1,
             :surface_layer_position_code_2,
             :surface_layer_position_code_3
           ]}
  @enforce_keys []
  defstruct code_list_qualifier_code: nil,
            industry_code: nil,
            code_category: nil,
            free_form_message_text: nil,
            quantity: nil,
            composite_unit_of_measure: nil,
            surface_layer_position_code_1: nil,
            surface_layer_position_code_2: nil,
            surface_layer_position_code_3: nil

  ## Typespecs

  @type t :: %__MODULE__{
          code_list_qualifier_code: nil | Identifier.t(),
          industry_code: nil | binary(),
          code_category: nil | Identifier.t(),
          free_form_message_text: nil | binary(),
          quantity: nil | number(),
          composite_unit_of_measure: nil | any(),
          surface_layer_position_code_1: nil | Identifier.t(),
          surface_layer_position_code_2: nil | Identifier.t(),
          surface_layer_position_code_3: nil | Identifier.t()
        }

  ## Module attributes

  @prefix "III"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :code_list_qualifier_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/code_list_qualifier_code.json"
             )
  @external_resource @file_path
  @code_list_qualifier_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :code_category %>
  @file_path Application.app_dir(:edi_x12, "priv/element_values/hipaa/r5010/code_category.json")
  @external_resource @file_path
  @code_category_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :surface_layer_position_code_1 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/surface_layer_position_code_1.json"
             )
  @external_resource @file_path
  @surface_layer_position_code_1_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :surface_layer_position_code_2 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/surface_layer_position_code_2.json"
             )
  @external_resource @file_path
  @surface_layer_position_code_2_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :surface_layer_position_code_3 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/surface_layer_position_code_3.json"
             )
  @external_resource @file_path
  @surface_layer_position_code_3_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

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

    # Parse element (1136 - Code Category) and tag as: :code_category
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@code_category_values]}
        ),
        :code_category
      )
    )

    # Parse element (933 - Free-form Message Text) and tag as: :free_form_message_text
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 264), {Parser, :string, []}),
        :free_form_message_text
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

    # Parse element (C001 - Composite Unit of Measure) and tag as: :composite_unit_of_measure
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :composite_unit_of_measure
      )
    )

    # Parse element (752 - Surface/Layer/Position Code) and tag as: :surface_layer_position_code_1
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@surface_layer_position_code_1_values]}
        ),
        :surface_layer_position_code_1
      )
    )

    # Parse element (752 - Surface/Layer/Position Code) and tag as: :surface_layer_position_code_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@surface_layer_position_code_2_values]}
        ),
        :surface_layer_position_code_2
      )
    )

    # Parse element (752 - Surface/Layer/Position Code) and tag as: :surface_layer_position_code_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@surface_layer_position_code_3_values]}
        ),
        :surface_layer_position_code_3
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end