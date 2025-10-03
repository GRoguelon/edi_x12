defmodule Edi.X12.Hipaa.R5010.Segments.TransactionSetHeaderTest do
  use ExUnit.Case, async: true

  import Edi.X12.Hipaa.R5010.Segments.TransactionSetHeader

  alias Edi.X12.Hipaa.R5010.Segments.TransactionSetHeader
  alias Edi.X12.Identifier

  ## Module attributes

  @struct %TransactionSetHeader{
    transaction_set_identifier_code: %Identifier{
      code: "271",
      value: "Eligibility, Coverage or Benefit Information"
    },
    transaction_set_control_number: "000000001",
    implementation_convention_reference: "005010X279A1"
  }

  @edi_x12 "ST*271*000000001*005010X279A1~"

  ## Tests

  describe "new/1" do
    test "returns a struct" do
      assert new(@edi_x12) == {:ok, @struct}
    end
  end
end
