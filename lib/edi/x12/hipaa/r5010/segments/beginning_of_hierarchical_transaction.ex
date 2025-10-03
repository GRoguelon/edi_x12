defmodule Edi.X12.Hipaa.R5010.Segments.BeginningOfHierarchicalTransaction do
  @moduledoc """
  `BHT` - Beginning of Hierarchical Transaction

  To define the business hierarchical structure of the transaction set and identify the business application purpose and reference data, i.e., number, date, and time
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect, optional: [:reference_identification, :date, :time, :transaction_type_code]}
  @enforce_keys [
    :hierarchical_structure_code,
    :transaction_set_purpose_code
  ]
  defstruct hierarchical_structure_code: nil,
            transaction_set_purpose_code: nil,
            reference_identification: nil,
            date: nil,
            time: nil,
            transaction_type_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          hierarchical_structure_code: Identifier.t(),
          transaction_set_purpose_code: Identifier.t(),
          reference_identification: nil | binary(),
          date: nil | Date.t(),
          time: nil | Time.t(),
          transaction_type_code: nil | Identifier.t()
        }

  ## Module attributes

  @prefix "BHT"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :hierarchical_structure_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/hierarchical_structure_code.json"
             )
  @external_resource @file_path
  @hierarchical_structure_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :transaction_set_purpose_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/transaction_set_purpose_code.json"
             )
  @external_resource @file_path
  @transaction_set_purpose_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :transaction_type_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/transaction_type_code.json"
             )
  @external_resource @file_path
  @transaction_type_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (1005 - Hierarchical Structure Code) and tag as: :hierarchical_structure_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 4),
        {Parser, :identifier, [@hierarchical_structure_code_values]}
      ),
      :hierarchical_structure_code
    )

    # Parse element (353 - Transaction Set Purpose Code) and tag as: :transaction_set_purpose_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@transaction_set_purpose_code_values]}
      ),
      :transaction_set_purpose_code
    )

    # Parse element (127 - Reference Identification) and tag as: :reference_identification
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 50), {Parser, :string, []}),
        :reference_identification
      )
    )

    # Parse element (373 - Date) and tag as: :date
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 8), {Parser, :date, []}),
        :date
      )
    )

    # Parse element (337 - Time) and tag as: :time
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 8), {Parser, :time, []}),
        :time
      )
    )

    # Parse element (640 - Transaction Type Code) and tag as: :transaction_type_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@transaction_type_code_values]}
        ),
        :transaction_type_code
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end