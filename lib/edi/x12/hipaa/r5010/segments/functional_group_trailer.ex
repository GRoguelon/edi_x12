defmodule Edi.X12.Hipaa.R5010.Segments.FunctionalGroupTrailer do
  @moduledoc """
  `GE` - Functional Group Trailer

  To indicate the end of a functional group and to provide control information
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser

  ## Strucuture

  @derive {Inspect, optional: []}
  @enforce_keys [
    :number_of_transaction_sets_included,
    :group_control_number
  ]
  defstruct number_of_transaction_sets_included: nil,
            group_control_number: nil

  ## Typespecs

  @type t :: %__MODULE__{
          number_of_transaction_sets_included: number(),
          group_control_number: number()
        }

  ## Module attributes

  @prefix "GE"

  @element_seperator "*"

  @segment_terminator "~"

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (97 - Number of Transaction Sets Included) and tag as: :number_of_transaction_sets_included
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([?-, ?0..?9, ?., ?|], min: 1, max: 6), {Parser, :number2, [0]}),
      :number_of_transaction_sets_included
    )

    # Parse element (28 - Group Control Number) and tag as: :group_control_number
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([?-, ?0..?9, ?., ?|], min: 1, max: 9), {Parser, :number2, [0]}),
      :group_control_number
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end