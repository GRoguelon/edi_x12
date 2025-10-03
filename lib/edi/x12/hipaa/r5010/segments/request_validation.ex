defmodule Edi.X12.Hipaa.R5010.Segments.RequestValidation do
  @moduledoc """
  `AAA` - Request Validation

  To specify the validity of the request and indicate follow-up action authorized
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           optional: [:agency_qualifier_code, :reject_reason_code, :follow_up_action_code]}
  @enforce_keys [
    :yes_no_condition_or_response_code
  ]
  defstruct yes_no_condition_or_response_code: nil,
            agency_qualifier_code: nil,
            reject_reason_code: nil,
            follow_up_action_code: nil

  ## Typespecs

  @type t :: %__MODULE__{
          yes_no_condition_or_response_code: Identifier.t(),
          agency_qualifier_code: nil | Identifier.t(),
          reject_reason_code: nil | Identifier.t(),
          follow_up_action_code: nil | Identifier.t()
        }

  ## Module attributes

  @prefix "AAA"

  @element_seperator "*"

  @segment_terminator "~"

  # Load the values for the values for :yes_no_condition_or_response_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/yes_no_condition_or_response_code.json"
             )
  @external_resource @file_path
  @yes_no_condition_or_response_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :agency_qualifier_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/agency_qualifier_code.json"
             )
  @external_resource @file_path
  @agency_qualifier_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :reject_reason_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/reject_reason_code.json"
             )
  @external_resource @file_path
  @reject_reason_code_values @file_path |> File.read!() |> Jason.decode!()

  # Load the values for the values for :follow_up_action_code %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/follow_up_action_code.json"
             )
  @external_resource @file_path
  @follow_up_action_code_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (1073 - Yes/No Condition or Response Code) and tag as: :yes_no_condition_or_response_code
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 1),
        {Parser, :identifier, [@yes_no_condition_or_response_code_values]}
      ),
      :yes_no_condition_or_response_code
    )

    # Parse element (559 - Agency Qualifier Code) and tag as: :agency_qualifier_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@agency_qualifier_code_values]}
        ),
        :agency_qualifier_code
      )
    )

    # Parse element (901 - Reject Reason Code) and tag as: :reject_reason_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 2),
          {Parser, :identifier, [@reject_reason_code_values]}
        ),
        :reject_reason_code
      )
    )

    # Parse element (889 - Follow-up Action Code) and tag as: :follow_up_action_code
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(
          ascii_string([?0..?9, ?A..?Z, ?|], min: 0, max: 1),
          {Parser, :identifier, [@follow_up_action_code_values]}
        ),
        :follow_up_action_code
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end