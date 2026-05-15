> [!WARNING]
> This repository is AI-assisted and manually reviewed. It is currently local-only and must not be pushed until publication governance allows it.

# r-stakeholder

Deterministic Rscript rewrite for the stakeholder-circus Tranche C lane.

## Status
- Runtime: base R CLI at `bin/stakeholder.R`.
- Scope: full dedicated `classic-six + modern-core`; grouped fallback for later families.
- Provider stance: `--experimental-provider` fails fast by design.
- Remote stance: local-only, no upstream tracking, no push.

## Run
```bash
Rscript bin/stakeholder.R --list-values
Rscript bin/stakeholder.R --output-format json --seed 42 --complexity extreme --project hospital-ocpp-quantum-control --framework "mcp grpc" --trace
Rscript bin/stakeholder.R --focus-family platform-engineering --output-format text --seed 7
```

## Validate
```bash
Rscript tests/test_cli.R
python3 scripts/validate_scaffold.py
docker build -t r-stakeholder .
docker run --rm r-stakeholder --output-format json --seed 42 --focus-family code-analyzer
```

## Contract
Supported flags include `--list-values`, `--focus-family`, `--output-format text|json`, `--seed`, and explicit `--experimental-provider` fail-fast. JSON output is normalized line-delimited event JSON with deterministic timestamps and same-seed stability.

The MIT license notice from the imported Rust project is preserved in `LICENSE`.
