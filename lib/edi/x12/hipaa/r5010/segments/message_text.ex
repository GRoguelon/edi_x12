defmodule Edi.X12.Hipaa.R5010.Segments.MessageText do
  @moduledoc """
  `MSG` - Message Text

  To provide a free-form format that allows the transmission of text information
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect, optional: [:printer_carriage_control_code, :number]}
  @enforce_keys [
    :free_form_message_text
  ]
  defstruct free_form_message_text: nil,
            printer_carriage_control_code: nil,
            number: nil

  ## Typespecs

  @type t :: %__MODULE__{
          free_form_message_text: binary(),
          printer_carriage_control_code: nil | Identifier.t(),
          number: nil | number()
        }

  ## Module attributes

  @prefix "MSG"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :printer_carriage_control_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/printer_carriage_control_code.json"
             )
  @external_resource @file_path
  @printer_carriage_control_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (933 - Free-form Message Text) and tag as: :free_form_message_text
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1, max: 264), {Parser, :string, []}),
      :free_form_message_text
    )

    # Parse element (934 - Printer Carriage Control Code) and tag as: :printer_carriage_control_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@printer_carriage_control_code_values]}
        ),
        :printer_carriage_control_code
      )
    )

    # Parse element (1470 - Number) and tag as: :number
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([?-, ?0..?9, ?., ?|], min: 0, max: 9), {Parser, :number2, [0]}),
        :number
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end