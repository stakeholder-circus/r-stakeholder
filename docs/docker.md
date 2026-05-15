# R Docker

## Build and smoke
```bash
docker build -t r-stakeholder .
docker run --rm r-stakeholder --list-values
docker run --rm r-stakeholder --output-format json --seed 42 --focus-family code-analyzer
```

The image uses `rocker/r-ver` and runs the base-R validation suite during build.
