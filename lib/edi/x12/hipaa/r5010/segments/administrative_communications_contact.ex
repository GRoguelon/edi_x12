defmodule Edi.X12.Hipaa.R5010.Segments.AdministrativeCommunicationsContact do
  @moduledoc """
  `PER` - Administrative Communications Contact

  To identify a person or office to whom administrative communications should be directed
  """

  use Edi.X12.Parser, parser: :segment

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [
             :name,
             :communication_number_qualifier_1,
             :communication_number_1,
             :communication_number_qualifier_2,
             :communication_number_2,
             :communication_number_qualifier_3,
             :communication_number_3,
             :contact_inquiry_reference
           ]}
  @enforce_keys [
    :contact_function_code
  ]
  defstruct contact_function_code: nil,
            name: nil,
            communication_number_qualifier_1: nil,
            communication_number_1: nil,
            communication_number_qualifier_2: nil,
            communication_number_2: nil,
            communication_number_qualifier_3: nil,
            communication_number_3: nil,
            contact_inquiry_reference: nil

  ## Typespecs

  @type t :: %__MODULE__{
          contact_function_code: Identifier.t(),
          name: nil | binary(),
          communication_number_qualifier_1: nil | Identifier.t(),
          communication_number_1: nil | binary(),
          communication_number_qualifier_2: nil | Identifier.t(),
          communication_number_2: nil | binary(),
          communication_number_qualifier_3: nil | Identifier.t(),
          communication_number_3: nil | binary(),
          contact_inquiry_reference: nil | binary()
        }

  ## Module attributes

  @prefix "PER"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :contact_function_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/contact_function_code.json"
             )
  @external_resource @file_path
  @contact_function_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :communication_number_qualifier_1 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/communication_number_qualifier.json"
             )
  @external_resource @file_path
  @communication_number_qualifier_1_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :communication_number_qualifier_2 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/communication_number_qualifier.json"
             )
  @external_resource @file_path
  @communication_number_qualifier_2_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :communication_number_qualifier_3 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/communication_number_qualifier.json"
             )
  @external_resource @file_path
  @communication_number_qualifier_3_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (366 - Contact Function Code) and tag as: :contact_function_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@contact_function_code_values]}
      ),
      :contact_function_code
    )

    # Parse element (93 - Name) and tag as: :name
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 60), {Parser, :string, []}),
        :name
      )
    )

    # Parse element (365 - Communication Number Qualifier) and tag as: :communication_number_qualifier_1
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@communication_number_qualifier_1_values]}
        ),
        :communication_number_qualifier_1
      )
    )

    # Parse element (364 - Communication Number) and tag as: :communication_number_1
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 256), {Parser, :string, []}),
        :communication_number_1
      )
    )

    # Parse element (365 - Communication Number Qualifier) and tag as: :communication_number_qualifier_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@communication_number_qualifier_2_values]}
        ),
        :communication_number_qualifier_2
      )
    )

    # Parse element (364 - Communication Number) and tag as: :communication_number_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 256), {Parser, :string, []}),
        :communication_number_2
      )
    )

    # Parse element (365 - Communication Number Qualifier) and tag as: :communication_number_qualifier_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@communication_number_qualifier_3_values]}
        ),
        :communication_number_qualifier_3
      )
    )

    # Parse element (364 - Communication Number) and tag as: :communication_number_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 256), {Parser, :string, []}),
        :communication_number_3
      )
    )

    # Parse element (443 - Contact Inquiry Reference) and tag as: :contact_inquiry_reference
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 20), {Parser, :string, []}),
        :contact_inquiry_reference
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:segment, combinator, export_combinator: true, inline: Mix.env() == :prod)
end