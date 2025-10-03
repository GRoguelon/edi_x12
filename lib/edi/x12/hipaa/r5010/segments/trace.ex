defmodule Edi.X12.Hipaa.R5010.Segments.Trace do
  @moduledoc """
  `TRN` - Trace

  To uniquely identify a transaction to an application
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect, optional: [:originating_company_identifier, :reference_identification_2]}
  @enforce_keys [
    :trace_type_code,
    :reference_identification_1
  ]
  defstruct trace_type_code: nil,
            reference_identification_1: nil,
            originating_company_identifier: nil,
            reference_identification_2: nil

  ## Typespecs

  @type t :: %__MODULE__{
          trace_type_code: Identifier.t(),
          reference_identification_1: binary(),
          originating_company_identifier: nil | binary(),
          reference_identification_2: nil | binary()
        }

  ## Module attributes

  @prefix "TRN"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :trace_type_code %>
  @file_path Application.app_dir(:edi_x12, "priv/element_values/hipaa/r5010/trace_type_code.json")
  @external_resource @file_path
  @trace_type_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (481 - Trace Type Code) and tag as: :trace_type_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], min: 1, max: 2),
        {Parser, :identifier, [@trace_type_code_values]}
      ),
      :trace_type_code
    )

    # Parse element (127 - Reference Identification) and tag as: :reference_identification_1
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1, max: 50), {Parser, :string, []}),
      :reference_identification_1
    )

    # Parse element (509 - Originating Company Identifier) and tag as: :originating_company_identifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 10), {Parser, :string, []}),
        :originating_company_identifier
      )
    )

    # Parse element (127 - Reference Identification) and tag as: :reference_identification_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 50), {Parser, :string, []}),
        :reference_identification_2
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end