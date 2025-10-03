defmodule Edi.X12.Hipaa.R5010.Segments.MilitaryPersonnelInformation do
  @moduledoc """
  `MPI` - Military Personnel Information

  To report military service data
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [
             :description,
             :military_service_rank_code,
             :date_time_period_format_qualifier,
             :date_time_period
           ]}
  @enforce_keys [
    :information_status_code,
    :employment_status_code,
    :government_service_affiliation_code
  ]
  defstruct information_status_code: nil,
            employment_status_code: nil,
            government_service_affiliation_code: nil,
            description: nil,
            military_service_rank_code: nil,
            date_time_period_format_qualifier: nil,
            date_time_period: nil

  ## Typespecs

  @type t :: %__MODULE__{
          information_status_code: Identifier.t(),
          employment_status_code: Identifier.t(),
          government_service_affiliation_code: Identifier.t(),
          description: nil | binary(),
          military_service_rank_code: nil | Identifier.t(),
          date_time_period_format_qualifier: nil | Identifier.t(),
          date_time_period: nil | binary()
        }

  ## Module attributes

  @prefix "MPI"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :information_status_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/information_status_code.json"
             )
  @external_resource @file_path
  @information_status_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :employment_status_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/employment_status_code.json"
             )
  @external_resource @file_path
  @employment_status_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :government_service_affiliation_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/government_service_affiliation_code.json"
             )
  @external_resource @file_path
  @government_service_affiliation_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :military_service_rank_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/military_service_rank_code.json"
             )
  @external_resource @file_path
  @military_service_rank_code_values @file_path |> File.read!() |> Jason.decode!()

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

    # Parse element (1201 - Information Status Code) and tag as: :information_status_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 1),
        {Parser, :identifier, [@information_status_code_values]}
      ),
      :information_status_code
    )

    # Parse element (584 - Employment Status Code) and tag as: :employment_status_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@employment_status_code_values]}
      ),
      :employment_status_code
    )

    # Parse element (1595 - Government Service Affiliation Code) and tag as: :government_service_affiliation_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 1),
        {Parser, :identifier, [@government_service_affiliation_code_values]}
      ),
      :government_service_affiliation_code
    )

    # Parse element (352 - Description) and tag as: :description
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 80), {Parser, :string, []}),
        :description
      )
    )

    # Parse element (1596 - Military Service Rank Code) and tag as: :military_service_rank_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@military_service_rank_code_values]}
        ),
        :military_service_rank_code
      )
    )

    # Parse element (1250 - Date Time Period Format Qualifier) and tag as: :date_time_period_format_qualifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@date_time_period_format_qualifier_values]}
        ),
        :date_time_period_format_qualifier
      )
    )

    # Parse element (1251 - Date Time Period) and tag as: :date_time_period
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 35), {Parser, :string, []}),
        :date_time_period
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end