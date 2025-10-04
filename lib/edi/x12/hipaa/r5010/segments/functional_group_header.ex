defmodule Edi.X12.Hipaa.R5010.Segments.FunctionalGroupHeader do
  @moduledoc """
  `GS` - Functional Group Header

  To indicate the beginning of a functional group and to provide control information
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect, optional: []}
  @enforce_keys [
    :functional_identifier_code,
    :application_sender_s_code,
    :application_receiver_s_code,
    :date,
    :time,
    :group_control_number,
    :responsible_agency_code,
    :version_release_industry_identifier_code
  ]
  defstruct functional_identifier_code: nil,
            application_sender_s_code: nil,
            application_receiver_s_code: nil,
            date: nil,
            time: nil,
            group_control_number: nil,
            responsible_agency_code: nil,
            version_release_industry_identifier_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          functional_identifier_code: Identifier.t(),
          application_sender_s_code: binary(),
          application_receiver_s_code: binary(),
          date: Date.t(),
          time: Time.t(),
          group_control_number: number(),
          responsible_agency_code: Identifier.t(),
          version_release_industry_identifier_code: binary()
        }

  ## Module attributes

  @prefix "GS"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :functional_identifier_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/functional_identifier_code.json"
             )
  @external_resource @file_path
  @functional_identifier_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :responsible_agency_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/responsible_agency_code.json"
             )
  @external_resource @file_path
  @responsible_agency_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (479 - Functional Identifier Code) and tag as: :functional_identifier_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@functional_identifier_code_values]}
      ),
      :functional_identifier_code
    )

    # Parse element (142 - Application Sender's Code) and tag as: :application_sender_s_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 2, max: 15), {Parser, :string, []}),
      :application_sender_s_code
    )

    # Parse element (124 - Application Receiver's Code) and tag as: :application_receiver_s_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 2, max: 15), {Parser, :string, []}),
      :application_receiver_s_code
    )

    # Parse element (373 - Date) and tag as: :date
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(map(ascii_string([not: ?*, not: ?~], 8), {Parser, :date, []}), :date)

    # Parse element (337 - Time) and tag as: :time
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 4, max: 8), {Parser, :time, []}),
      :time
    )

    # Parse element (28 - Group Control Number) and tag as: :group_control_number
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([?-, ?0..?9, ?., ?|], min: 1, max: 9), {Parser, :number2, [0]}),
      :group_control_number
    )

    # Parse element (455 - Responsible Agency Code) and tag as: :responsible_agency_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], min: 1, max: 2),
        {Parser, :identifier, [@responsible_agency_code_values]}
      ),
      :responsible_agency_code
    )

    # Parse element (480 - Version / Release / Industry Identifier Code) and tag as: :version_release_industry_identifier_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1, max: 12), {Parser, :string, []}),
      :version_release_industry_identifier_code
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end