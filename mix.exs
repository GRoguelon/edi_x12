defmodule EdiX12.MixProject do
  use Mix.Project

  @source_url "https://github.com/GRoguelon/edi_x12"
  @version "0.1.2"

  def project do
    [
      app: :edi_x12,
      version: @version,
      elixir: "~> 1.15",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "EDI X12",
      description: "A parser for EDI X12",
      docs: docs(),
      source_url: @source_url,
      dialyzer: dialyzer()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      name: :edi_x12,
      files: ["lib", "mix.exs"],
      maintainers: ["Geoffrey Roguelon"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "Changelog" => "https://hexdocs.pm/edi_x12/changelog.html"
      }
    ]
  end

  defp docs do
    [
      formatters: ["html"],
      main: "readme",
      extras: ["README.md", "CHANGELOG.md", "LICENSE"],
      source_ref: "v#{@version}",
      source_url: @source_url,
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"],
      nest_modules_by_prefix: [Edi.X12.Hipaa.R5010],
      groups_for_modules: [
        Elements: [
          Edi.X12.Hipaa.R5010.Elements.CompositeDiagnosisCodePointer,
          Edi.X12.Hipaa.R5010.Elements.CompositeMedicalProcedureIdentifier,
          Edi.X12.Hipaa.R5010.Elements.CompositeRaceOrEthnicityInformation,
          Edi.X12.Hipaa.R5010.Elements.CompositeUnitOfMeasure,
          Edi.X12.Hipaa.R5010.Elements.HealthCareCodeInformation,
          Edi.X12.Hipaa.R5010.Elements.MedicareStatusCode,
          Edi.X12.Hipaa.R5010.Elements.ProviderSpecialtyInformation,
          Edi.X12.Hipaa.R5010.Elements.ReferenceIdentifier
        ],
        Segments: [
          Edi.X12.Hipaa.R5010.Segments.AdministrativeCommunicationsContact,
          Edi.X12.Hipaa.R5010.Segments.BeginningOfHierarchicalTransaction,
          Edi.X12.Hipaa.R5010.Segments.DateOrTimeOrPeriod,
          Edi.X12.Hipaa.R5010.Segments.DemographicInformation,
          Edi.X12.Hipaa.R5010.Segments.EligibilityOrBenefitInformation,
          Edi.X12.Hipaa.R5010.Segments.GeographicLocation,
          Edi.X12.Hipaa.R5010.Segments.HealthCareInformationCodes,
          Edi.X12.Hipaa.R5010.Segments.HealthCareServicesDelivery,
          Edi.X12.Hipaa.R5010.Segments.HierarchicalLevel,
          Edi.X12.Hipaa.R5010.Segments.IndividualOrOrganizationalName,
          Edi.X12.Hipaa.R5010.Segments.Information,
          Edi.X12.Hipaa.R5010.Segments.InsuredBenefit,
          Edi.X12.Hipaa.R5010.Segments.LoopHeader,
          Edi.X12.Hipaa.R5010.Segments.LoopTrailer,
          Edi.X12.Hipaa.R5010.Segments.MessageText,
          Edi.X12.Hipaa.R5010.Segments.MilitaryPersonnelInformation,
          Edi.X12.Hipaa.R5010.Segments.PartyLocation,
          Edi.X12.Hipaa.R5010.Segments.ProviderInformation,
          Edi.X12.Hipaa.R5010.Segments.ReferenceInformation,
          Edi.X12.Hipaa.R5010.Segments.RequestValidation,
          Edi.X12.Hipaa.R5010.Segments.Trace,
          Edi.X12.Hipaa.R5010.Segments.TransactionSetHeader,
          Edi.X12.Hipaa.R5010.Segments.TransactionSetTrailer
        ],
        "Transaction Sets": [
          Edi.X12.Hipaa.R5010.TransactionSets.HealthCareEligibilityBenefitResponse
        ]
      ]
    ]
  end

  defp dialyzer do
    [
      list_unused_filters: true
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.4"},
      {:nimble_parsec, "~> 1.4"},

      ## Dev dependencies
      {:ex_doc, "~> 0.38", only: :dev, runtime: false},
      {:mix_test_interactive, "~> 5.0", only: :dev, runtime: false},

      ## Dev & Test dependencies
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end
end
