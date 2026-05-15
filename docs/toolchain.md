# R Toolchain

- State: Tranche C deterministic-first rewrite implemented locally.
- Toolchain source: `brew` locally, `r-lib/actions/setup-r` in CI, `rocker/r-ver` in Docker.

## Native commands
```bash
Rscript -e 'sessionInfo()'
Rscript bin/stakeholder.R --list-values
Rscript tests/test_cli.R
python3 scripts/validate_scaffold.py
```

## Docker commands
```bash
docker build -t r-stakeholder .
docker run --rm r-stakeholder --output-format json --seed 42 --focus-family code-analyzer
```
