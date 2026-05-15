# R Parity

Rust remains the source-of-truth and `stakeholder-core` remains the behavioral contract. This repo now implements the deterministic Tranche C subset in base R.

## Exact / normalized-equivalent
- CLI values and validation match the deterministic contract surface.
- Normalized JSON events use stable keys, deterministic `T+...ms` timestamps, sequence numbers, provenance, family, protocol, schema, and context fields.
- Same seed and same args produce byte-identical JSON lines.

## Dedicated families
- Classic-six: `code-analyzer`, `data-processing`, `jargon`, `metrics`, `network-activity`, `system-monitoring`.
- Modern-core: `agent-workflows`, `platform-engineering`, `observability-ai-runtime`, `delivery-preview-ops`, `supply-chain-security`.

## Deferred grouped fallback
- `ai-governance`
- `security-blockchain`
- `health-protocol`
- `overlay-quantum`

These are intentional grouped fallbacks, not claims of full dedicated later-family parity.
