defmodule Edi.X12.Hipaa.R5010.Segments.PartyLocation do
  @moduledoc """
  `N3` - Party Location

  To specify the location of the named party
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser

  ## Strucuture

  @derive {Inspect, optional: [:address_information_2]}
  @enforce_keys [
    :address_information_1
  ]
  defstruct address_information_1: nil,
            address_information_2: nil

  ## Typespecs

  @type t :: %__MODULE__{
          address_information_1: binary(),
          address_information_2: nil | binary()
        }

  ## Module attributes

  @prefix "N3"

  @element_seperator "*"

  @segment_terminator "~"

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (166 - Address Information) and tag as: :address_information_1
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1, max: 55), {Parser, :string, []}),
      :address_information_1
    )

    # Parse element (166 - Address Information) and tag as: :address_information_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 55), {Parser, :string, []}),
        :address_information_2
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end