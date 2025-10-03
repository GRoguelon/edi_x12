defmodule EdiX12.MixProject do
  use Mix.Project

  @source_url "https://github.com/GRoguelon/edi_x12"
  @version "0.1.0"

  def project do
    [
      app: :edi_x12,
      version: @version,
      elixir: "~> 1.12",
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
      extras: ["README.md", "CHANGELOG.md"],
      source_ref: "v#{@version}",
      source_url: @source_url,
      skip_undefined_reference_warnings_on: ["CHANGELOG.md"]
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
