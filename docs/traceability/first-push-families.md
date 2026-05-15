# First-push families for r-stakeholder

| Source anchor | R target | Behavior | Parity |
| --- | --- | --- | --- |
| `src/types.rs` enum contract | `bin/stakeholder.R` value vectors | dev type, jargon, complexity, output format values | exact |
| `src/main.rs` CLI deterministic extensions | `bin/stakeholder.R::parse_args` | list-values, seed, output format, no-color, trace | normalized-equivalent |
| `src/activities.rs` list-values and event sequencing | `bin/stakeholder.R` planner/event functions | deterministic family selection and event envelopes | normalized-equivalent |
| `src/generators/common.rs` classic descriptors | `bin/stakeholder.R::DESCRIPTORS` | classic-six family messages/protocol/schema metadata | normalized-equivalent |
| `src/generators/common.rs` modern descriptors | `bin/stakeholder.R::DESCRIPTORS` | agent-workflows plus modern-core family messages/protocol/schema metadata | normalized-equivalent |
| post-modern family map | `bin/stakeholder.R::GROUPED_FALLBACK` | later families are explicit grouped fallbacks | intentional divergence |
| experimental provider docs | `bin/stakeholder.R::parse_args` | `--experimental-provider` fail-fast | exact |
