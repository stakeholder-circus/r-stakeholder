# R Language Specialties

- Base R only: no CRAN dependency, lockfile, renv, or system package manager friction.
- Deterministic JSON is emitted by a small local serializer to keep ordering stable.
- A tiny LCG is used instead of R's global RNG so same-seed behavior is independent of R's sampling implementation.
