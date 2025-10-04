# EDI X12

A robust Elixir parser for EDI X12 (Electronic Data Interchange) documents, with built-in support for HIPAA 5010 transaction sets.

## Overview

EDI X12 is the standard format for electronic business documents in North America, widely used in healthcare, finance, logistics, and other industries. This library provides a native Elixir implementation for parsing and working with X12 documents, starting with HIPAA-compliant healthcare transactions.

### Features

- 🏥 **HIPAA 5010 Support** - Parse healthcare transaction sets including eligibility, claims, and remittance
- 🔍 **Flexible Parsing** - Parse complete transaction sets, individual segments, or custom combinations
- 🎯 **Type-Safe** - Structured data types for segments and transaction sets
- ⚡ **Elixir Native** - Built from the ground up in Elixir for performance and reliability

> [!WARNING]
> This library is **not production-ready** yet. Use at your own risk.

> [!CAUTION]
> **Do not submit pull request.** Open a [new issue](https://github.com/GRoguelon/edi_x12/issues/new/choose) for any related issues.

## Installation

```elixir
def deps do
  [
    {:edi_x12, "~> 0.1.4"}
  ]
end
```

## Parse EDI X12

### Transaction Set

To parse a transaction set, you need to pass the EDI X12 string to the `parse/1` function.

```elixir
# Alias the EDI X12 Transaction Set
alias Edi.X12.Hipaa.R5010.TransactionSets.HealthCareEligibilityBenefitResponse

"""
ISA*00*          *00*          *ZZ*1234567890ABC  *ZZ*987654321      *123456*4321*|*12345*123456789*0*P*:~GS*HB*1234567890ABC*987654321*20251003*0410*0*X*0987654321AB~...~SE*0000*000000000~GE*1*1~IEA*1*987654321~
"""
|> HealthCareEligibilityBenefitResponse.parse()
```

### Segment

To parse a segment, you have 2 options:

#### Transaction Set

```elixir
# Alias the EDI X12 Transaction Set
alias Edi.X12.Hipaa.R5010.TransactionSets.HealthCareEligibilityBenefitResponse

[
  %InterchangeControlHeader{},
  %FunctionalGroupHeader{},
  ...
  %FunctionalGroupTrailer{},
  %InterchangeControlTrailer{},
] =
  "GS*HB*1234567890ABC*987654321*20251003*0410*0*X*0987654321AB~"
  |> HealthCareEligibilityBenefitResponse.parse_segment()
```

### Segment

```elixir
# Alias the EDI X12 Segment
alias Edi.X12.Hipaa.R5010.Segments.FunctionalGroupHeader

{:ok, %FunctionalGroupHeader{}} =
  "GS*HB*1234567890ABC*987654321*20251003*0410*0*X*0987654321AB~"
  |> FunctionalGroupHeader.parse()
```
