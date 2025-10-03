defmodule Edi.X12.Hipaa.R5010.Segments.TransactionSetHeader do
  @moduledoc """
  `ST` - Transaction Set Header

  To indicate the start of a transaction set and to assign a control number
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect, optional: [:implementation_convention_reference]}
  @enforce_keys [
    :transaction_set_identifier_code,
    :transaction_set_control_number
  ]
  defstruct transaction_set_identifier_code: nil,
            transaction_set_control_number: nil,
            implementation_convention_reference: nil

  ## Typespecs

  @type t :: %__MODULE__{
          transaction_set_identifier_code: Identifier.t(),
          transaction_set_control_number: binary(),
          implementation_convention_reference: nil | binary()
        }

  ## Module attributes

  @prefix "ST"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :transaction_set_identifier_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/transaction_set_identifier_code.json"
             )
  @external_resource @file_path
  @transaction_set_identifier_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (143 - Transaction Set Identifier Code) and tag as: :transaction_set_identifier_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 3),
        {Parser, :identifier, [@transaction_set_identifier_code_values]}
      ),
      :transaction_set_identifier_code
    )

    # Parse element (329 - Transaction Set Control Number) and tag as: :transaction_set_control_number
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 4, max: 9), {Parser, :string, []}),
      :transaction_set_control_number
    )

    # Parse element (1705 - Implementation Convention Reference) and tag as: :implementation_convention_reference
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 35), {Parser, :string, []}),
        :implementation_convention_reference
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end