# R Experimental Surface

Live-provider work is intentionally outside the deterministic R Tranche C runtime. Passing `--experimental-provider NAME` fails fast and exits non-zero.

This keeps native, Docker, and CI validation provider-free while preserving an explicit CLI boundary for the future provider rollout wave.
