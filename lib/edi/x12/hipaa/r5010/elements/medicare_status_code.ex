defmodule Edi.X12.Hipaa.R5010.Elements.MedicareStatusCode do
  @moduledoc """
  `C052` - Medicare Status Code

  To provide Medicare coverage and associated reason for Medicare eligibility
  """

  use Edi.X12.Parser, parser: :element

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           except: [:__key__],
           optional: [
             :eligibility_reason_code_1,
             :eligibility_reason_code_2,
             :eligibility_reason_code_3
           ]}
  @enforce_keys [
    :medicare_plan_code
  ]
  defstruct __key__: :medicare_status_code,
            medicare_plan_code: nil,
            eligibility_reason_code_1: nil,
            eligibility_reason_code_2: nil,
            eligibility_reason_code_3: nil

  ## Typespecs

  @type t :: %__MODULE__{
          __key__: :medicare_status_code,
          medicare_plan_code: Identifier.t(),
          eligibility_reason_code_1: nil | Identifier.t(),
          eligibility_reason_code_2: nil | Identifier.t(),
          eligibility_reason_code_3: nil | Identifier.t()
        }

  ## Module attributes

  @element_seperator ":"

  # Load the values for the values for :medicare_plan_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/medicare_plan_code.json"
             )
  @external_resource @file_path
  @medicare_plan_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :eligibility_reason_code_1 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/eligibility_reason_code_1.json"
             )
  @external_resource @file_path
  @eligibility_reason_code_1_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :eligibility_reason_code_2 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/eligibility_reason_code_2.json"
             )
  @external_resource @file_path
  @eligibility_reason_code_2_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :eligibility_reason_code_3 %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/eligibility_reason_code_3.json"
             )
  @external_resource @file_path
  @eligibility_reason_code_3_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()

    # Parse element (1218 - Medicare Plan Code) and tag as: :medicare_plan_code
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 1),
        {Parser, :identifier, [@medicare_plan_code_values]}
      ),
      :medicare_plan_code
    )

    # Parse element (1701 - Eligibility Reason Code) and tag as: :eligibility_reason_code_1
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@eligibility_reason_code_1_values]}
        ),
        :eligibility_reason_code_1
      )
    )

    # Parse element (1701 - Eligibility Reason Code) and tag as: :eligibility_reason_code_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@eligibility_reason_code_2_values]}
        ),
        :eligibility_reason_code_2
      )
    )

    # Parse element (1701 - Eligibility Reason Code) and tag as: :eligibility_reason_code_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@eligibility_reason_code_3_values]}
        ),
        :eligibility_reason_code_3
      )
    )

  @doc false
  defparsec(:element, combinator, export_combinator: true, inline: Mix.env() == :prod)
end