defmodule Edi.X12.Hipaa.R5010.Segments.HealthCareInformationCodes do
  @moduledoc """
  `HI` - Health Care Information Codes

  To supply information related to the delivery of health care
  """

  use Edi.X12.Parser

  import NimbleParsec

  alias Edi.X12.Parser

  ## Strucuture

  @derive {Inspect,
           optional: [
             :health_care_code_information_2,
             :health_care_code_information_3,
             :health_care_code_information_4,
             :health_care_code_information_5,
             :health_care_code_information_6,
             :health_care_code_information_7,
             :health_care_code_information_8,
             :health_care_code_information_9,
             :health_care_code_information_10,
             :health_care_code_information_11,
             :health_care_code_information_12
           ]}
  @enforce_keys [
    :health_care_code_information_1
  ]
  defstruct health_care_code_information_1: nil,
            health_care_code_information_2: nil,
            health_care_code_information_3: nil,
            health_care_code_information_4: nil,
            health_care_code_information_5: nil,
            health_care_code_information_6: nil,
            health_care_code_information_7: nil,
            health_care_code_information_8: nil,
            health_care_code_information_9: nil,
            health_care_code_information_10: nil,
            health_care_code_information_11: nil,
            health_care_code_information_12: nil

  ## Typespecs

  @type t :: %__MODULE__{
          health_care_code_information_1: any(),
          health_care_code_information_2: nil | any(),
          health_care_code_information_3: nil | any(),
          health_care_code_information_4: nil | any(),
          health_care_code_information_5: nil | any(),
          health_care_code_information_6: nil | any(),
          health_care_code_information_7: nil | any(),
          health_care_code_information_8: nil | any(),
          health_care_code_information_9: nil | any(),
          health_care_code_information_10: nil | any(),
          health_care_code_information_11: nil | any(),
          health_care_code_information_12: nil | any()
        }

  ## Module attributes

  @prefix "HI"

  @element_seperator "*"

  @segment_terminator "~"

  ## Nimble Parsec

  combinator =
    empty()
    # Parse and ignore the segment prefix
    |> ignore(string(@prefix))

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_1
    |> ignore(string(@element_seperator))
    |> unwrap_and_tag(
      map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
      :health_care_code_information_1
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_2
      )
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_3
      )
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_4
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_4
      )
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_5
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_5
      )
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_6
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_6
      )
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_7
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_7
      )
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_8
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_8
      )
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_9
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_9
      )
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_10
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_10
      )
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_11
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_11
      )
    )

    # Parse element (C022 - Health Care Code Information) and tag as: :health_care_code_information_12
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1), {Parser, :composite, []}),
        :health_care_code_information_12
      )
    )

    # Parse and ignore segment terminator
    |> ignore(string(@segment_terminator))

  @doc false
  defparsec(:parse, combinator, export_combinator: false, inline: Mix.env() == :prod)
end