defmodule Edi.X12.Hipaa.R5010.Segments.DateOrTimeOrPeriod do
  @moduledoc """
  `DTP` - Date or Time or Period

  To specify any or all of a date, a time, or a time period
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect, optional: []}
  @enforce_keys [
    :date_time_qualifier,
    :date_time_period_format_qualifier,
    :date_time_period
  ]
  defstruct date_time_qualifier: nil,
            date_time_period_format_qualifier: nil,
            date_time_period: nil

  ## Typespecs

  @type t :: %__MODULE__{
          date_time_qualifier: Identifier.t(),
          date_time_period_format_qualifier: Identifier.t(),
          date_time_period: binary()
        }

  ## Module attributes

  @prefix "DTP"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :date_time_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/date_time_qualifier.json"
             )
  @external_resource @file_path
  @date_time_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :date_time_period_format_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/date_time_period_format_qualifier.json"
             )
  @external_resource @file_path
  @date_time_period_format_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (374 - Date/Time Qualifier) and tag as: :date_time_qualifier
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 3),
        {Parser, :identifier, [@date_time_qualifier_values]}
      ),
      :date_time_qualifier
    )

    # Parse element (1250 - Date Time Period Format Qualifier) and tag as: :date_time_period_format_qualifier
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], min: 2, max: 3),
        {Parser, :identifier, [@date_time_period_format_qualifier_values]}
      ),
      :date_time_period_format_qualifier
    )

    # Parse element (1251 - Date Time Period) and tag as: :date_time_period
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1, max: 35), {Parser, :string, []}),
      :date_time_period
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end