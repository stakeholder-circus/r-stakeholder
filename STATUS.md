# r-stakeholder Status

- Role: Tranche C deterministic-first R rewrite
- Parity class: full-parity target, deterministic tranche
- State: native-validated local deterministic tranche
- Rewrite completeness: 62%
- Functionality completeness: 58%
- Branch: `main`
- Origin: `git@github.com:stakeholder-circus/r-stakeholder.git`
- Upstream: `https://github.com/giacomo-b/rust-stakeholder`

## Implemented
- Base R CLI with no package-manager dependency.
- `--list-values`, `--focus-family`, `--output-format text|json`, `--seed`, `--trace`, `--no-color`, `--minimal`, `--alerts`, `--team`, and core Rust contract flags.
- Explicit `--experimental-provider` fail-fast.
- Dedicated classic-six families: code analyzer, data processing, jargon, metrics, network activity, system monitoring.
- Dedicated modern-core families: agent workflows, platform engineering, observability AI runtime, delivery preview ops, supply-chain security.
- Grouped fallback families: AI governance, security/blockchain, health/protocol, quantum overlay.
- Same-seed deterministic normalized JSON.

## Evidence
- `python3 scripts/validate_scaffold.py`
- `Rscript tests/test_cli.R`
- `Rscript bin/stakeholder.R --list-values`
- same-seed deterministic JSON diff for `platform-engineering`
- explicit `--experimental-provider local-demo` fail-fast smoke

## Blockers
- Full later-family dedicated ports remain deferred beyond grouped fallback.
- Live-provider/runtime support remains deferred to the provider rollout wave.
- Publication is blocked until governance and remote access are available.
