defmodule Edi.X12.Hipaa.R5010.Segments.InterchangeControlHeader do
  @moduledoc """
  `ISA` - Interchange Control Header

  To start and identify an interchange of zero or more functional groups and interchange-related control segments
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect, optional: []}
  @enforce_keys [
    :authorization_information_qualifier,
    :authorization_information,
    :security_information_qualifier,
    :security_information,
    :interchange_id_qualifier_1,
    :interchange_sender_id,
    :interchange_id_qualifier_2,
    :interchange_receiver_id,
    :interchange_date,
    :interchange_time,
    :repetition_separator,
    :interchange_control_version_number,
    :interchange_control_number,
    :acknowledgment_requested,
    :interchange_usage_indicator,
    :component_element_separator
  ]
  defstruct authorization_information_qualifier: nil,
            authorization_information: nil,
            security_information_qualifier: nil,
            security_information: nil,
            interchange_id_qualifier_1: nil,
            interchange_sender_id: nil,
            interchange_id_qualifier_2: nil,
            interchange_receiver_id: nil,
            interchange_date: nil,
            interchange_time: nil,
            repetition_separator: nil,
            interchange_control_version_number: nil,
            interchange_control_number: nil,
            acknowledgment_requested: nil,
            interchange_usage_indicator: nil,
            component_element_separator: nil

  ## Typespecs

  @type t :: %__MODULE__{
          authorization_information_qualifier: Identifier.t(),
          authorization_information: binary(),
          security_information_qualifier: Identifier.t(),
          security_information: binary(),
          interchange_id_qualifier_1: Identifier.t(),
          interchange_sender_id: binary(),
          interchange_id_qualifier_2: Identifier.t(),
          interchange_receiver_id: binary(),
          interchange_date: Date.t(),
          interchange_time: Time.t(),
          repetition_separator: binary(),
          interchange_control_version_number: Identifier.t(),
          interchange_control_number: number(),
          acknowledgment_requested: Identifier.t(),
          interchange_usage_indicator: Identifier.t(),
          component_element_separator: binary()
        }

  ## Module attributes

  @prefix "ISA"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :authorization_information_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/authorization_information_qualifier.json"
             )
  @external_resource @file_path
  @authorization_information_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :security_information_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/security_information_qualifier.json"
             )
  @external_resource @file_path
  @security_information_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :interchange_id_qualifier_1 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/interchange_id_qualifier.json"
             )
  @external_resource @file_path
  @interchange_id_qualifier_1_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :interchange_id_qualifier_2 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/interchange_id_qualifier.json"
             )
  @external_resource @file_path
  @interchange_id_qualifier_2_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :interchange_control_version_number %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/interchange_control_version_number.json"
             )
  @external_resource @file_path
  @interchange_control_version_number_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :acknowledgment_requested %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/acknowledgment_requested.json"
             )
  @external_resource @file_path
  @acknowledgment_requested_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :interchange_usage_indicator %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/interchange_usage_indicator.json"
             )
  @external_resource @file_path
  @interchange_usage_indicator_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (I01 - Authorization Information Qualifier) and tag as: :authorization_information_qualifier
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@authorization_information_qualifier_values]}
      ),
      :authorization_information_qualifier
    )

    # Parse element (I02 - Authorization Information) and tag as: :authorization_information
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], 10), {Parser, :string, []}),
      :authorization_information
    )

    # Parse element (I03 - Security Information Qualifier) and tag as: :security_information_qualifier
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@security_information_qualifier_values]}
      ),
      :security_information_qualifier
    )

    # Parse element (I04 - Security Information) and tag as: :security_information
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], 10), {Parser, :string, []}),
      :security_information
    )

    # Parse element (I05 - Interchange ID Qualifier) and tag as: :interchange_id_qualifier_1
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@interchange_id_qualifier_1_values]}
      ),
      :interchange_id_qualifier_1
    )

    # Parse element (I06 - Interchange Sender ID) and tag as: :interchange_sender_id
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], 15), {Parser, :string, []}),
      :interchange_sender_id
    )

    # Parse element (I05 - Interchange ID Qualifier) and tag as: :interchange_id_qualifier_2
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@interchange_id_qualifier_2_values]}
      ),
      :interchange_id_qualifier_2
    )

    # Parse element (I07 - Interchange Receiver ID) and tag as: :interchange_receiver_id
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], 15), {Parser, :string, []}),
      :interchange_receiver_id
    )

    # Parse element (I08 - Interchange Date) and tag as: :interchange_date
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], 6), {Parser, :date, []}),
      :interchange_date
    )

    # Parse element (I09 - Interchange Time) and tag as: :interchange_time
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], 4), {Parser, :time, []}),
      :interchange_time
    )

    # Parse element (I65 - Repetition Separator) and tag as: :repetition_separator
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], 1), {Parser, :string, []}),
      :repetition_separator
    )

    # Parse element (I11 - Interchange Control Version Number) and tag as: :interchange_control_version_number
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 5),
        {Parser, :identifier, [@interchange_control_version_number_values]}
      ),
      :interchange_control_version_number
    )

    # Parse element (I12 - Interchange Control Number) and tag as: :interchange_control_number
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([?-, ?0..?9, ?., ?|], 9), {Parser, :number2, [0]}),
      :interchange_control_number
    )

    # Parse element (I13 - Acknowledgment Requested) and tag as: :acknowledgment_requested
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 1),
        {Parser, :identifier, [@acknowledgment_requested_values]}
      ),
      :acknowledgment_requested
    )

    # Parse element (I14 - Interchange Usage Indicator) and tag as: :interchange_usage_indicator
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 1),
        {Parser, :identifier, [@interchange_usage_indicator_values]}
      ),
      :interchange_usage_indicator
    )

    # Parse element (I15 - Component Element Separator) and tag as: :component_element_separator
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], 1), {Parser, :string, []}),
      :component_element_separator
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end