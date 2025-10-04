defmodule Edi.X12.Hipaa.R5010.Elements.CompositeMedicalProcedureIdentifier do
  @moduledoc """
  `C003` - Composite Medical Procedure Identifier

  To identify a medical procedure by its standardized codes and applicable modifiers
  """

  use Edi.X12.Parser, parser: :element

  import NimbleParsec

  alias Edi.X12.Parser
  alias Edi.X12.Identifier

  ## Strucuture

  @derive {Inspect,
           except: [:__key__],
           optional: [
             :procedure_modifier_1,
             :procedure_modifier_2,
             :procedure_modifier_3,
             :procedure_modifier_4,
             :description,
             :product_service_id_2
           ]}
  @enforce_keys [
    :product_service_id_qualifier,
    :product_service_id_1
  ]
  defstruct __key__: :composite_medical_procedure_identifier,
            product_service_id_qualifier: nil,
            product_service_id_1: nil,
            procedure_modifier_1: nil,
            procedure_modifier_2: nil,
            procedure_modifier_3: nil,
            procedure_modifier_4: nil,
            description: nil,
            product_service_id_2: nil

  ## Typespecs

  @type t :: %__MODULE__{
          __key__: :composite_medical_procedure_identifier,
          product_service_id_qualifier: Identifier.t(),
          product_service_id_1: binary(),
          procedure_modifier_1: nil | binary(),
          procedure_modifier_2: nil | binary(),
          procedure_modifier_3: nil | binary(),
          procedure_modifier_4: nil | binary(),
          description: nil | binary(),
          product_service_id_2: nil | binary()
        }

  ## Module attributes

  @element_seperator ":"

  # Load the values for the values for :product_service_id_qualifier %>
  @file_path Application.app_dir(
               :edi_x12,
               "priv/element_values/hipaa/r5010/product_service_id_qualifier.json"
             )
  @external_resource @file_path
  @product_service_id_qualifier_values @file_path |> File.read!() |> Jason.decode!()

  ## Nimble Parsec

  combinator =
    empty()

    # Parse element (235 - Product/Service ID Qualifier) and tag as: :product_service_id_qualifier
    |> unwrap_and_tag(
      map(
        ascii_string([?0..?9, ?A..?Z, ?|], 2),
        {Parser, :identifier, [@product_service_id_qualifier_values]}
      ),
      :product_service_id_qualifier
    )

    # Parse element (234 - Product/Service ID) and tag as: :product_service_id_1
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 1, max: 48), {Parser, :string, []}),
        :product_service_id_1
      )
    )

    # Parse element (1339 - Procedure Modifier) and tag as: :procedure_modifier_1
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 2), {Parser, :string, []}),
        :procedure_modifier_1
      )
    )

    # Parse element (1339 - Procedure Modifier) and tag as: :procedure_modifier_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 2), {Parser, :string, []}),
        :procedure_modifier_2
      )
    )

    # Parse element (1339 - Procedure Modifier) and tag as: :procedure_modifier_3
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 2), {Parser, :string, []}),
        :procedure_modifier_3
      )
    )

    # Parse element (1339 - Procedure Modifier) and tag as: :procedure_modifier_4
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 2), {Parser, :string, []}),
        :procedure_modifier_4
      )
    )

    # Parse element (352 - Description) and tag as: :description
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 80), {Parser, :string, []}),
        :description
      )
    )

    # Parse element (234 - Product/Service ID) and tag as: :product_service_id_2
    |> optional(
      ignore(string(@element_seperator))
      |> unwrap_and_tag(
        map(ascii_string([not: ?*, not: ?~], min: 0, max: 48), {Parser, :string, []}),
        :product_service_id_2
      )
    )

  @doc false
  defparsec(:element, combinator, export_combinator: true, inline: Mix.env() == :prod)
end