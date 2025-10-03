defmodule Edi.X12.Hipaa.R5010.Segments.LoopTrailer do
  @moduledoc """
  `LE` - Loop Trailer

  To indicate that the loop immediately preceding this segment is complete
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser

  ## Strucuture

  @derive {Inspect, optional: []}
  @enforce_keys [
    :loop_identifier_code
  ]
  defstruct loop_identifier_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          loop_identifier_code: binary()
        }

  ## Module attributes

  @prefix "LE"

  @element_seperator "*"

  @segment_terminator "~"

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (447 - Loop Identifier Code) and tag as: :loop_identifier_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1, max: 4), {Parser, :string, []}),
      :loop_identifier_code
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end