defmodule Edi.X12.Hipaa.R5010.TransactionSets.HealthCareEligibilityBenefitResponse do
  @moduledoc """
  `271` - X279A1 - Health Care Eligibility Benefit Response

  This X12 Transaction Set contains the format and establishes the data contents of the Eligibility, Coverage or Benefit Information Transaction Set (271) for use within the context of an Electronic Data Interchange (EDI) environment. This transaction set can be used to communicate information about or changes to eligibility, coverage or benefits from information sources (such as - insurers, sponsors, payors) to information receivers (such as - physicians, hospitals, repair facilities, third party administrators, governmental agencies). This information includes but is not limited to: benefit status, explanation of benefits, coverages, dependent coverage level, effective dates, amounts for co-insurance, co-pays, deductibles, exclusions and limitations.
  """

  import NimbleParsec

  alias Edi.X12.Hipaa.R5010.Segments

  ## Typespecs

  @type t :: [struct() | t()]

  ## Nimble Parsec

  combinator =
    empty()
    # Parse
    |> map(
      wrap(parsec({Segments.InterchangeControlHeader, :segment})),
      {Segments.InterchangeControlHeader, :parse!, []}
    )
    |> ignore(optional(string("\n")))
    |> map(
      wrap(parsec({Segments.FunctionalGroupHeader, :segment})),
      {Segments.FunctionalGroupHeader, :parse!, []}
    )
    |> ignore(optional(string("\n")))
    # Parse the segment ST - Transaction Set Header
    |> map(
      wrap(parsec({Segments.TransactionSetHeader, :segment})),
      {Segments.TransactionSetHeader, :parse!, []}
    )
    |> ignore(optional(string("\n")))

    # Parse the segment BHT - Beginning of Hierarchical Transaction
    |> map(
      wrap(parsec({Segments.BeginningOfHierarchicalTransaction, :segment})),
      {Segments.BeginningOfHierarchicalTransaction, :parse!, []}
    )
    |> ignore(optional(string("\n")))

    # Loop 2000A
    |> times(
      wrap(
        # Parse the segment HL - Hierarchical Level
        map(
          wrap(parsec({Segments.HierarchicalLevel, :segment})),
          {Segments.HierarchicalLevel, :parse!, []}
        )
        |> ignore(optional(string("\n")))

        # Parse the segment AAA - Request Validation
        |> times(
          map(
            wrap(parsec({Segments.RequestValidation, :segment})),
            {Segments.RequestValidation, :parse!, []}
          )
          |> ignore(optional(string("\n"))),
          min: 0,
          max: 9
        )

        # Loop 2100A
        |> wrap(
          # Parse the segment NM1 - Individual or Organizational Name
          map(
            wrap(parsec({Segments.IndividualOrOrganizationalName, :segment})),
            {Segments.IndividualOrOrganizationalName, :parse!, []}
          )
          |> ignore(optional(string("\n")))

          # Parse the segment PER - Administrative Communications Contact
          |> times(
            map(
              wrap(parsec({Segments.AdministrativeCommunicationsContact, :segment})),
              {Segments.AdministrativeCommunicationsContact, :parse!, []}
            )
            |> ignore(optional(string("\n"))),
            min: 0,
            max: 3
          )

          # Parse the segment AAA - Request Validation
          |> times(
            map(
              wrap(parsec({Segments.RequestValidation, :segment})),
              {Segments.RequestValidation, :parse!, []}
            )
            |> ignore(optional(string("\n"))),
            min: 0,
            max: 9
          )
        )

        # Loop 2000B
        |> times(
          wrap(
            # Parse the segment HL - Hierarchical Level
            map(
              wrap(parsec({Segments.HierarchicalLevel, :segment})),
              {Segments.HierarchicalLevel, :parse!, []}
            )
            |> ignore(optional(string("\n")))

            # Loop 2100B
            |> wrap(
              # Parse the segment NM1 - Individual or Organizational Name
              map(
                wrap(parsec({Segments.IndividualOrOrganizationalName, :segment})),
                {Segments.IndividualOrOrganizationalName, :parse!, []}
              )
              |> ignore(optional(string("\n")))

              # Parse the segment REF - Reference Information
              |> times(
                map(
                  wrap(parsec({Segments.ReferenceInformation, :segment})),
                  {Segments.ReferenceInformation, :parse!, []}
                )
                |> ignore(optional(string("\n"))),
                min: 0,
                max: 9
              )

              # Parse the segment N3 - Party Location
              |> optional(
                map(
                  wrap(parsec({Segments.PartyLocation, :segment})),
                  {Segments.PartyLocation, :parse!, []}
                )
                |> ignore(optional(string("\n")))
              )

              # Parse the segment N4 - Geographic Location
              |> optional(
                map(
                  wrap(parsec({Segments.GeographicLocation, :segment})),
                  {Segments.GeographicLocation, :parse!, []}
                )
                |> ignore(optional(string("\n")))
              )

              # Parse the segment AAA - Request Validation
              |> times(
                map(
                  wrap(parsec({Segments.RequestValidation, :segment})),
                  {Segments.RequestValidation, :parse!, []}
                )
                |> ignore(optional(string("\n"))),
                min: 0,
                max: 9
              )

              # Parse the segment PRV - Provider Information
              |> optional(
                map(
                  wrap(parsec({Segments.ProviderInformation, :segment})),
                  {Segments.ProviderInformation, :parse!, []}
                )
                |> ignore(optional(string("\n")))
              )
            )

            # Loop 2000C
            |> times(
              wrap(
                # Parse the segment HL - Hierarchical Level
                map(
                  wrap(parsec({Segments.HierarchicalLevel, :segment})),
                  {Segments.HierarchicalLevel, :parse!, []}
                )
                |> ignore(optional(string("\n")))

                # Parse the segment TRN - Trace
                |> times(
                  map(
                    wrap(parsec({Segments.Trace, :segment})),
                    {Segments.Trace, :parse!, []}
                  )
                  |> ignore(optional(string("\n"))),
                  min: 0,
                  max: 3
                )

                # Loop 2100C
                |> wrap(
                  # Parse the segment NM1 - Individual or Organizational Name
                  map(
                    wrap(parsec({Segments.IndividualOrOrganizationalName, :segment})),
                    {Segments.IndividualOrOrganizationalName, :parse!, []}
                  )
                  |> ignore(optional(string("\n")))

                  # Parse the segment REF - Reference Information
                  |> times(
                    map(
                      wrap(parsec({Segments.ReferenceInformation, :segment})),
                      {Segments.ReferenceInformation, :parse!, []}
                    )
                    |> ignore(optional(string("\n"))),
                    min: 0,
                    max: 9
                  )

                  # Parse the segment N3 - Party Location
                  |> optional(
                    map(
                      wrap(parsec({Segments.PartyLocation, :segment})),
                      {Segments.PartyLocation, :parse!, []}
                    )
                    |> ignore(optional(string("\n")))
                  )

                  # Parse the segment N4 - Geographic Location
                  |> optional(
                    map(
                      wrap(parsec({Segments.GeographicLocation, :segment})),
                      {Segments.GeographicLocation, :parse!, []}
                    )
                    |> ignore(optional(string("\n")))
                  )

                  # Parse the segment AAA - Request Validation
                  |> times(
                    map(
                      wrap(parsec({Segments.RequestValidation, :segment})),
                      {Segments.RequestValidation, :parse!, []}
                    )
                    |> ignore(optional(string("\n"))),
                    min: 0,
                    max: 9
                  )

                  # Parse the segment PRV - Provider Information
                  |> optional(
                    map(
                      wrap(parsec({Segments.ProviderInformation, :segment})),
                      {Segments.ProviderInformation, :parse!, []}
                    )
                    |> ignore(optional(string("\n")))
                  )

                  # Parse the segment DMG - Demographic Information
                  |> optional(
                    map(
                      wrap(parsec({Segments.DemographicInformation, :segment})),
                      {Segments.DemographicInformation, :parse!, []}
                    )
                    |> ignore(optional(string("\n")))
                  )

                  # Parse the segment INS - Insured Benefit
                  |> optional(
                    map(
                      wrap(parsec({Segments.InsuredBenefit, :segment})),
                      {Segments.InsuredBenefit, :parse!, []}
                    )
                    |> ignore(optional(string("\n")))
                  )

                  # Parse the segment HI - Health Care Information Codes
                  |> optional(
                    map(
                      wrap(parsec({Segments.HealthCareInformationCodes, :segment})),
                      {Segments.HealthCareInformationCodes, :parse!, []}
                    )
                    |> ignore(optional(string("\n")))
                  )

                  # Parse the segment DTP - Date or Time or Period
                  |> times(
                    map(
                      wrap(parsec({Segments.DateOrTimeOrPeriod, :segment})),
                      {Segments.DateOrTimeOrPeriod, :parse!, []}
                    )
                    |> ignore(optional(string("\n"))),
                    min: 0,
                    max: 9
                  )

                  # Parse the segment MPI - Military Personnel Information
                  |> optional(
                    map(
                      wrap(parsec({Segments.MilitaryPersonnelInformation, :segment})),
                      {Segments.MilitaryPersonnelInformation, :parse!, []}
                    )
                    |> ignore(optional(string("\n")))
                  )

                  # Loop 2110C
                  |> times(
                    wrap(
                      # Parse the segment EB - Eligibility or Benefit Information
                      map(
                        wrap(parsec({Segments.EligibilityOrBenefitInformation, :segment})),
                        {Segments.EligibilityOrBenefitInformation, :parse!, []}
                      )
                      |> ignore(optional(string("\n")))

                      # Parse the segment HSD - Health Care Services Delivery
                      |> times(
                        map(
                          wrap(parsec({Segments.HealthCareServicesDelivery, :segment})),
                          {Segments.HealthCareServicesDelivery, :parse!, []}
                        )
                        |> ignore(optional(string("\n"))),
                        min: 0,
                        max: 9
                      )

                      # Parse the segment REF - Reference Information
                      |> times(
                        map(
                          wrap(parsec({Segments.ReferenceInformation, :segment})),
                          {Segments.ReferenceInformation, :parse!, []}
                        )
                        |> ignore(optional(string("\n"))),
                        min: 0,
                        max: 9
                      )

                      # Parse the segment DTP - Date or Time or Period
                      |> times(
                        map(
                          wrap(parsec({Segments.DateOrTimeOrPeriod, :segment})),
                          {Segments.DateOrTimeOrPeriod, :parse!, []}
                        )
                        |> ignore(optional(string("\n"))),
                        min: 0,
                        max: 20
                      )

                      # Parse the segment AAA - Request Validation
                      |> times(
                        map(
                          wrap(parsec({Segments.RequestValidation, :segment})),
                          {Segments.RequestValidation, :parse!, []}
                        )
                        |> ignore(optional(string("\n"))),
                        min: 0,
                        max: 9
                      )

                      # Parse the segment MSG - Message Text
                      |> times(
                        map(
                          wrap(parsec({Segments.MessageText, :segment})),
                          {Segments.MessageText, :parse!, []}
                        )
                        |> ignore(optional(string("\n"))),
                        min: 0,
                        max: 10
                      )

                      # Loop 2115C
                      |> times(
                        wrap(
                          # Parse the segment III - Information
                          map(
                            wrap(parsec({Segments.Information, :segment})),
                            {Segments.Information, :parse!, []}
                          )
                          |> ignore(optional(string("\n")))
                        ),
                        min: 0,
                        max: 10
                      )

                      # Parse the segment LS - Loop Header
                      |> optional(
                        map(
                          wrap(parsec({Segments.LoopHeader, :segment})),
                          {Segments.LoopHeader, :parse!, []}
                        )
                        |> ignore(optional(string("\n")))
                      )

                      # Loop 2120C
                      |> times(
                        wrap(
                          # Parse the segment NM1 - Individual or Organizational Name
                          map(
                            wrap(parsec({Segments.IndividualOrOrganizationalName, :segment})),
                            {Segments.IndividualOrOrganizationalName, :parse!, []}
                          )
                          |> ignore(optional(string("\n")))

                          # Parse the segment N3 - Party Location
                          |> optional(
                            map(
                              wrap(parsec({Segments.PartyLocation, :segment})),
                              {Segments.PartyLocation, :parse!, []}
                            )
                            |> ignore(optional(string("\n")))
                          )

                          # Parse the segment N4 - Geographic Location
                          |> optional(
                            map(
                              wrap(parsec({Segments.GeographicLocation, :segment})),
                              {Segments.GeographicLocation, :parse!, []}
                            )
                            |> ignore(optional(string("\n")))
                          )

                          # Parse the segment PER - Administrative Communications Contact
                          |> times(
                            map(
                              wrap(
                                parsec({Segments.AdministrativeCommunicationsContact, :segment})
                              ),
                              {Segments.AdministrativeCommunicationsContact, :parse!, []}
                            )
                            |> ignore(optional(string("\n"))),
                            min: 0,
                            max: 3
                          )

                          # Parse the segment PRV - Provider Information
                          |> optional(
                            map(
                              wrap(parsec({Segments.ProviderInformation, :segment})),
                              {Segments.ProviderInformation, :parse!, []}
                            )
                            |> ignore(optional(string("\n")))
                          )
                        ),
                        min: 0,
                        max: 23
                      )

                      # Parse the segment LE - Loop Trailer
                      |> optional(
                        map(
                          wrap(parsec({Segments.LoopTrailer, :segment})),
                          {Segments.LoopTrailer, :parse!, []}
                        )
                        |> ignore(optional(string("\n")))
                      )
                    ),
                    min: 0
                  )
                )

                # Loop 2000D
                |> times(
                  wrap(
                    # Parse the segment HL - Hierarchical Level
                    map(
                      wrap(parsec({Segments.HierarchicalLevel, :segment})),
                      {Segments.HierarchicalLevel, :parse!, []}
                    )
                    |> ignore(optional(string("\n")))

                    # Parse the segment TRN - Trace
                    |> times(
                      map(
                        wrap(parsec({Segments.Trace, :segment})),
                        {Segments.Trace, :parse!, []}
                      )
                      |> ignore(optional(string("\n"))),
                      min: 0,
                      max: 3
                    )

                    # Loop 2100D
                    |> wrap(
                      # Parse the segment NM1 - Individual or Organizational Name
                      map(
                        wrap(parsec({Segments.IndividualOrOrganizationalName, :segment})),
                        {Segments.IndividualOrOrganizationalName, :parse!, []}
                      )
                      |> ignore(optional(string("\n")))

                      # Parse the segment REF - Reference Information
                      |> times(
                        map(
                          wrap(parsec({Segments.ReferenceInformation, :segment})),
                          {Segments.ReferenceInformation, :parse!, []}
                        )
                        |> ignore(optional(string("\n"))),
                        min: 0,
                        max: 9
                      )

                      # Parse the segment N3 - Party Location
                      |> optional(
                        map(
                          wrap(parsec({Segments.PartyLocation, :segment})),
                          {Segments.PartyLocation, :parse!, []}
                        )
                        |> ignore(optional(string("\n")))
                      )

                      # Parse the segment N4 - Geographic Location
                      |> optional(
                        map(
                          wrap(parsec({Segments.GeographicLocation, :segment})),
                          {Segments.GeographicLocation, :parse!, []}
                        )
                        |> ignore(optional(string("\n")))
                      )

                      # Parse the segment AAA - Request Validation
                      |> times(
                        map(
                          wrap(parsec({Segments.RequestValidation, :segment})),
                          {Segments.RequestValidation, :parse!, []}
                        )
                        |> ignore(optional(string("\n"))),
                        min: 0,
                        max: 9
                      )

                      # Parse the segment PRV - Provider Information
                      |> optional(
                        map(
                          wrap(parsec({Segments.ProviderInformation, :segment})),
                          {Segments.ProviderInformation, :parse!, []}
                        )
                        |> ignore(optional(string("\n")))
                      )

                      # Parse the segment DMG - Demographic Information
                      |> optional(
                        map(
                          wrap(parsec({Segments.DemographicInformation, :segment})),
                          {Segments.DemographicInformation, :parse!, []}
                        )
                        |> ignore(optional(string("\n")))
                      )

                      # Parse the segment INS - Insured Benefit
                      |> optional(
                        map(
                          wrap(parsec({Segments.InsuredBenefit, :segment})),
                          {Segments.InsuredBenefit, :parse!, []}
                        )
                        |> ignore(optional(string("\n")))
                      )

                      # Parse the segment HI - Health Care Information Codes
                      |> optional(
                        map(
                          wrap(parsec({Segments.HealthCareInformationCodes, :segment})),
                          {Segments.HealthCareInformationCodes, :parse!, []}
                        )
                        |> ignore(optional(string("\n")))
                      )

                      # Parse the segment DTP - Date or Time or Period
                      |> times(
                        map(
                          wrap(parsec({Segments.DateOrTimeOrPeriod, :segment})),
                          {Segments.DateOrTimeOrPeriod, :parse!, []}
                        )
                        |> ignore(optional(string("\n"))),
                        min: 0,
                        max: 9
                      )

                      # Parse the segment MPI - Military Personnel Information
                      |> optional(
                        map(
                          wrap(parsec({Segments.MilitaryPersonnelInformation, :segment})),
                          {Segments.MilitaryPersonnelInformation, :parse!, []}
                        )
                        |> ignore(optional(string("\n")))
                      )

                      # Loop 2110D
                      |> times(
                        wrap(
                          # Parse the segment EB - Eligibility or Benefit Information
                          map(
                            wrap(parsec({Segments.EligibilityOrBenefitInformation, :segment})),
                            {Segments.EligibilityOrBenefitInformation, :parse!, []}
                          )
                          |> ignore(optional(string("\n")))

                          # Parse the segment HSD - Health Care Services Delivery
                          |> times(
                            map(
                              wrap(parsec({Segments.HealthCareServicesDelivery, :segment})),
                              {Segments.HealthCareServicesDelivery, :parse!, []}
                            )
                            |> ignore(optional(string("\n"))),
                            min: 0,
                            max: 9
                          )

                          # Parse the segment REF - Reference Information
                          |> times(
                            map(
                              wrap(parsec({Segments.ReferenceInformation, :segment})),
                              {Segments.ReferenceInformation, :parse!, []}
                            )
                            |> ignore(optional(string("\n"))),
                            min: 0,
                            max: 9
                          )

                          # Parse the segment DTP - Date or Time or Period
                          |> times(
                            map(
                              wrap(parsec({Segments.DateOrTimeOrPeriod, :segment})),
                              {Segments.DateOrTimeOrPeriod, :parse!, []}
                            )
                            |> ignore(optional(string("\n"))),
                            min: 0,
                            max: 20
                          )

                          # Parse the segment AAA - Request Validation
                          |> times(
                            map(
                              wrap(parsec({Segments.RequestValidation, :segment})),
                              {Segments.RequestValidation, :parse!, []}
                            )
                            |> ignore(optional(string("\n"))),
                            min: 0,
                            max: 9
                          )

                          # Parse the segment MSG - Message Text
                          |> times(
                            map(
                              wrap(parsec({Segments.MessageText, :segment})),
                              {Segments.MessageText, :parse!, []}
                            )
                            |> ignore(optional(string("\n"))),
                            min: 0,
                            max: 10
                          )

                          # Loop 2115D
                          |> times(
                            wrap(
                              # Parse the segment III - Information
                              map(
                                wrap(parsec({Segments.Information, :segment})),
                                {Segments.Information, :parse!, []}
                              )
                              |> ignore(optional(string("\n")))
                            ),
                            min: 0,
                            max: 10
                          )

                          # Parse the segment LS - Loop Header
                          |> optional(
                            map(
                              wrap(parsec({Segments.LoopHeader, :segment})),
                              {Segments.LoopHeader, :parse!, []}
                            )
                            |> ignore(optional(string("\n")))
                          )

                          # Loop 2120D
                          |> times(
                            wrap(
                              # Parse the segment NM1 - Individual or Organizational Name
                              map(
                                wrap(parsec({Segments.IndividualOrOrganizationalName, :segment})),
                                {Segments.IndividualOrOrganizationalName, :parse!, []}
                              )
                              |> ignore(optional(string("\n")))

                              # Parse the segment N3 - Party Location
                              |> optional(
                                map(
                                  wrap(parsec({Segments.PartyLocation, :segment})),
                                  {Segments.PartyLocation, :parse!, []}
                                )
                                |> ignore(optional(string("\n")))
                              )

                              # Parse the segment N4 - Geographic Location
                              |> optional(
                                map(
                                  wrap(parsec({Segments.GeographicLocation, :segment})),
                                  {Segments.GeographicLocation, :parse!, []}
                                )
                                |> ignore(optional(string("\n")))
                              )

                              # Parse the segment PER - Administrative Communications Contact
                              |> times(
                                map(
                                  wrap(
                                    parsec(
                                      {Segments.AdministrativeCommunicationsContact, :segment}
                                    )
                                  ),
                                  {Segments.AdministrativeCommunicationsContact, :parse!, []}
                                )
                                |> ignore(optional(string("\n"))),
                                min: 0,
                                max: 3
                              )

                              # Parse the segment PRV - Provider Information
                              |> optional(
                                map(
                                  wrap(parsec({Segments.ProviderInformation, :segment})),
                                  {Segments.ProviderInformation, :parse!, []}
                                )
                                |> ignore(optional(string("\n")))
                              )
                            ),
                            min: 0,
                            max: 23
                          )

                          # Parse the segment LE - Loop Trailer
                          |> optional(
                            map(
                              wrap(parsec({Segments.LoopTrailer, :segment})),
                              {Segments.LoopTrailer, :parse!, []}
                            )
                            |> ignore(optional(string("\n")))
                          )
                        ),
                        min: 0
                      )
                    )
                  ),
                  min: 0
                )
              ),
              min: 0
            )
          ),
          min: 0
        )
      ),
      min: 1
    )

    # Parse the segment SE - Transaction Set Trailer
    |> map(
      wrap(parsec({Segments.TransactionSetTrailer, :segment})),
      {Segments.TransactionSetTrailer, :parse!, []}
    )
    |> ignore(optional(string("\n")))
    |> map(
      wrap(parsec({Segments.FunctionalGroupTrailer, :segment})),
      {Segments.FunctionalGroupTrailer, :parse!, []}
    )
    |> ignore(optional(string("\n")))
    |> map(
      wrap(parsec({Segments.InterchangeControlTrailer, :segment})),
      {Segments.InterchangeControlTrailer, :parse!, []}
    )
    |> ignore(optional(string("\n")))

  @doc false
  defparsec(:transaction_set, combinator, export_combinator: false, inline: Mix.env() == :prod)

  ## Public functions

  @spec parse(binary()) :: {:ok, t()}
  def parse(value) when is_binary(value) do
    case transaction_set(value) do
      {:ok, result, _rest, _, _, _} ->
        {:ok, result}

      {:error, error, rest, _, _, _} ->
        {:error, error, rest}
    end
  end

  def parse_segment(<<"AAA", _::binary>> = segment) do
    Segments.RequestValidation.parse(segment)
  end

  def parse_segment(<<"BHT", _::binary>> = segment) do
    Segments.BeginningOfHierarchicalTransaction.parse(segment)
  end

  def parse_segment(<<"DMG", _::binary>> = segment) do
    Segments.DemographicInformation.parse(segment)
  end

  def parse_segment(<<"DTP", _::binary>> = segment) do
    Segments.DateOrTimeOrPeriod.parse(segment)
  end

  def parse_segment(<<"EB", _::binary>> = segment) do
    Segments.EligibilityOrBenefitInformation.parse(segment)
  end

  def parse_segment(<<"GE", _::binary>> = segment) do
    Segments.FunctionalGroupTrailer.parse(segment)
  end

  def parse_segment(<<"GS", _::binary>> = segment) do
    Segments.FunctionalGroupHeader.parse(segment)
  end

  def parse_segment(<<"HI", _::binary>> = segment) do
    Segments.HealthCareInformationCodes.parse(segment)
  end

  def parse_segment(<<"HL", _::binary>> = segment) do
    Segments.HierarchicalLevel.parse(segment)
  end

  def parse_segment(<<"HSD", _::binary>> = segment) do
    Segments.HealthCareServicesDelivery.parse(segment)
  end

  def parse_segment(<<"IEA", _::binary>> = segment) do
    Segments.InterchangeControlTrailer.parse(segment)
  end

  def parse_segment(<<"III", _::binary>> = segment) do
    Segments.Information.parse(segment)
  end

  def parse_segment(<<"INS", _::binary>> = segment) do
    Segments.InsuredBenefit.parse(segment)
  end

  def parse_segment(<<"ISA", _::binary>> = segment) do
    Segments.InterchangeControlHeader.parse(segment)
  end

  def parse_segment(<<"LE", _::binary>> = segment) do
    Segments.LoopTrailer.parse(segment)
  end

  def parse_segment(<<"LS", _::binary>> = segment) do
    Segments.LoopHeader.parse(segment)
  end

  def parse_segment(<<"MPI", _::binary>> = segment) do
    Segments.MilitaryPersonnelInformation.parse(segment)
  end

  def parse_segment(<<"MSG", _::binary>> = segment) do
    Segments.MessageText.parse(segment)
  end

  def parse_segment(<<"N3", _::binary>> = segment) do
    Segments.PartyLocation.parse(segment)
  end

  def parse_segment(<<"N4", _::binary>> = segment) do
    Segments.GeographicLocation.parse(segment)
  end

  def parse_segment(<<"NM1", _::binary>> = segment) do
    Segments.IndividualOrOrganizationalName.parse(segment)
  end

  def parse_segment(<<"PER", _::binary>> = segment) do
    Segments.AdministrativeCommunicationsContact.parse(segment)
  end

  def parse_segment(<<"PRV", _::binary>> = segment) do
    Segments.ProviderInformation.parse(segment)
  end

  def parse_segment(<<"REF", _::binary>> = segment) do
    Segments.ReferenceInformation.parse(segment)
  end

  def parse_segment(<<"SE", _::binary>> = segment) do
    Segments.TransactionSetTrailer.parse(segment)
  end

  def parse_segment(<<"ST", _::binary>> = segment) do
    Segments.TransactionSetHeader.parse(segment)
  end

  def parse_segment(<<"TRN", _::binary>> = segment) do
    Segments.Trace.parse(segment)
  end
end