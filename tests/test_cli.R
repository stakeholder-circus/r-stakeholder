#!/usr/bin/env Rscript
run <- function(args) system2("Rscript", c("bin/stakeholder.R", args), stdout=TRUE, stderr=TRUE)
fail <- function(msg) { cat("FAIL:", msg, "\n", file=stderr()); quit(status=1) }

lv <- run("--list-values")
if (!grepl("code-analyzer", paste(lv, collapse="\n"), fixed=TRUE)) fail("list-values missing code-analyzer")
if (!grepl("groupedFallbackFamilies", paste(lv, collapse="\n"), fixed=TRUE)) fail("list-values missing grouped fallback families")

a <- run(c("--output-format", "json", "--seed", "42", "--complexity", "extreme", "--project", "hospital-ocpp-quantum-control", "--framework", "mcp-grpc", "--trace"))
b <- run(c("--output-format", "json", "--seed", "42", "--complexity", "extreme", "--project", "hospital-ocpp-quantum-control", "--framework", "mcp-grpc", "--trace"))
if (!identical(a, b)) fail("same-seed JSON output is not stable")
if (!all(grepl('^\\{', a))) fail("json output must be normalized JSON lines")

focus <- run(c("--output-format", "json", "--focus-family", "platform-engineering", "--seed", "7"))
if (!grepl("platform-engineering", paste(focus, collapse="\n"), fixed=TRUE)) fail("focus-family did not emit requested family")

status <- system2("Rscript", c("bin/stakeholder.R", "--experimental-provider", "openai"), stdout=TRUE, stderr=TRUE)
if (!attr(status, "status") %in% 2L) fail("experimental provider must fail fast with status 2")

cat("R CLI tests passed\n")
