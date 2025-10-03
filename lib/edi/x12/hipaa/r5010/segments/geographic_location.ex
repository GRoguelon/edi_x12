defmodule Edi.X12.Hipaa.R5010.Segments.GeographicLocation do
  @moduledoc """
  `N4` - Geographic Location

  To specify the geographic place of the named party
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [
             :city_name,
             :state_or_province_code,
             :postal_code,
             :country_code,
             :location_qualifier,
             :location_identifier,
             :country_subdivision_code
           ]}
  @enforce_keys []
  defstruct city_name: nil,
            state_or_province_code: nil,
            postal_code: nil,
            country_code: nil,
            location_qualifier: nil,
            location_identifier: nil,
            country_subdivision_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          city_name: nil | binary(),
          state_or_province_code: nil | Identifier.t(),
          postal_code: nil | Identifier.t(),
          country_code: nil | Identifier.t(),
          location_qualifier: nil | Identifier.t(),
          location_identifier: nil | binary(),
          country_subdivision_code: nil | Identifier.t()
        }

  ## Module attributes

  @prefix "N4"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :state_or_province_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/state_or_province_code.json"
             )
  @external_resource @file_path
  @state_or_province_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :postal_code %>
  @file_path Application.app_dir(:edi_x12, "priv/element_values/hipaa/r5010/postal_code.json")
  @external_resource @file_path
  @postal_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :country_code %>
  @file_path Application.app_dir(:edi_x12, "priv/element_values/hipaa/r5010/country_code.json")
  @external_resource @file_path
  @country_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :location_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/location_qualifier.json"
             )
  @external_resource @file_path
  @location_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :country_subdivision_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/country_subdivision_code.json"
             )
  @external_resource @file_path
  @country_subdivision_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (19 - City Name) and tag as: :city_name
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 30), {Parser, :string, []}),
        :city_name
      )
    )

    # Parse element (156 - State or Province Code) and tag as: :state_or_province_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@state_or_province_code_values]}
        ),
        :state_or_province_code
      )
    )

    # Parse element (116 - Postal Code) and tag as: :postal_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 15),
          {Parser, :identifier, [@postal_code_values]}
        ),
        :postal_code
      )
    )

    # Parse element (26 - Country Code) and tag as: :country_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@country_code_values]}
        ),
        :country_code
      )
    )

    # Parse element (309 - Location Qualifier) and tag as: :location_qualifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@location_qualifier_values]}
        ),
        :location_qualifier
      )
    )

    # Parse element (310 - Location Identifier) and tag as: :location_identifier
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 30), {Parser, :string, []}),
        :location_identifier
      )
    )

    # Parse element (1715 - Country Subdivision Code) and tag as: :country_subdivision_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 3),
          {Parser, :identifier, [@country_subdivision_code_values]}
        ),
        :country_subdivision_code
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end