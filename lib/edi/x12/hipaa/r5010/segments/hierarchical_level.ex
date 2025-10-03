defmodule Edi.X12.Hipaa.R5010.Segments.HierarchicalLevel do
  @moduledoc """
  `HL` - Hierarchical Level

  To identify dependencies among and the content of hierarchically related groups of data segments
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect, optional: [:hierarchical_parent_id_number, :hierarchical_child_code]}
  @enforce_keys [
    :hierarchical_id_number,
    :hierarchical_level_code
  ]
  defstruct hierarchical_id_number: nil,
            hierarchical_parent_id_number: nil,
            hierarchical_level_code: nil,
            hierarchical_child_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          hierarchical_id_number: binary(),
          hierarchical_parent_id_number: nil | binary(),
          hierarchical_level_code: Identifier.t(),
          hierarchical_child_code: nil | Identifier.t()
        }

  ## Module attributes

  @prefix "HL"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :hierarchical_level_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/hierarchical_level_code.json"
             )
  @external_resource @file_path
  @hierarchical_level_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :hierarchical_child_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/hierarchical_child_code.json"
             )
  @external_resource @file_path
  @hierarchical_child_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (628 - Hierarchical ID Number) and tag as: :hierarchical_id_number
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1, max: 12), {Parser, :string, []}),
      :hierarchical_id_number
    )

    # Parse element (734 - Hierarchical Parent ID Number) and tag as: :hierarchical_parent_id_number
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 0, max: 12), {Parser, :string, []}),
      :hierarchical_parent_id_number
    )

    # Parse element (735 - Hierarchical Level Code) and tag as: :hierarchical_level_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], min: 1, max: 2),
        {Parser, :identifier, [@hierarchical_level_code_values]}
      ),
      :hierarchical_level_code
    )

    # Parse element (736 - Hierarchical Child Code) and tag as: :hierarchical_child_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@hierarchical_child_code_values]}
        ),
        :hierarchical_child_code
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end