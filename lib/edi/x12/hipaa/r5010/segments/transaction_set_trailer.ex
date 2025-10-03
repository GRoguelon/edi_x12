defmodule Edi.X12.Hipaa.R5010.Segments.TransactionSetTrailer do
  @moduledoc """
  `SE` - Transaction Set Trailer

  To indicate the end of the transaction set and provide the count of the transmitted segments (including the beginning (ST) and ending (SE) segments)
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser

  ## Strucuture

  @derive {Inspect, optional: []}
  @enforce_keys [
    :number_of_included_segments,
    :transaction_set_control_number
  ]
  defstruct number_of_included_segments: nil,
            transaction_set_control_number: nil

  ## Typespecs

  @type t :: %__MODULE__{
          number_of_included_segments: number(),
          transaction_set_control_number: binary()
        }

  ## Module attributes

  @prefix "SE"

  @element_seperator "*"

  @segment_terminator "~"

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (96 - Number of Included Segments) and tag as: :number_of_included_segments
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?-], min: 0, max: 1) |> ascii_string([?0..?9, ?., ?|], min: 1, max: 10),
        {Parser, :number2, [0]}
      ),
      :number_of_included_segments
    )

    # Parse element (329 - Transaction Set Control Number) and tag as: :transaction_set_control_number
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 4, max: 9), {Parser, :string, []}),
      :transaction_set_control_number
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end