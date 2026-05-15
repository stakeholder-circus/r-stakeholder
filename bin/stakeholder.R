#!/usr/bin/env Rscript
# MIT License notice preserved in LICENSE. This R rewrite ports the deterministic
# stakeholder-circus contract without package-manager dependencies.

DEV_TYPES <- c("backend", "frontend", "fullstack", "data_science", "dev_ops", "blockchain", "machine_learning", "systems_programming", "game_development", "security")
JARGON_LEVELS <- c("low", "medium", "high", "extreme")
COMPLEXITIES <- c("low", "medium", "high", "extreme")
OUTPUT_FORMATS <- c("text", "json")
CLASSIC_SIX <- c("code-analyzer", "data-processing", "jargon", "metrics", "network-activity", "system-monitoring")
MODERN_CORE <- c("agent-workflows", "platform-engineering", "observability-ai-runtime", "delivery-preview-ops", "supply-chain-security")
GROUPED_FALLBACK <- c("ai-governance", "security-blockchain", "health-protocol", "overlay-quantum")
DEDICATED_FAMILIES <- c(CLASSIC_SIX, MODERN_CORE)
ALL_FAMILIES <- c(DEDICATED_FAMILIES, GROUPED_FALLBACK)

DESCRIPTORS <- list(
  "code-analyzer"=list(title="Code analyzer", protocol=NULL, schema=NULL,
    low="reviewing typed interfaces and SDK drift across the active service graph",
    high="triaging monorepo dependency edges, generated patches, and schema compatibility before merge",
    extreme="replaying agent-authored patchsets against contract drift, ownership boundaries, and MCP tool assumptions"),
  "data-processing"=list(title="Data processing", protocol=NULL, schema=NULL,
    low="refreshing embedding corpora, batch transforms, and event windows for the current dataset",
    high="rebuilding hybrid retrieval indexes, semantic chunks, and NDJSON backfills for downstream consumers",
    extreme="reconciling multimodal pipelines, lakehouse batch cuts, and evaluation-ready data slices under deterministic ordering"),
  "jargon"=list(title="Jargon refresh", protocol=NULL, schema=NULL,
    low="keeping technical language current without drifting into fake-deep jargon",
    high="switching phrasing toward credible 2026 agent, platform, protocol, and security terminology",
    extreme="enforcing modern domain vocabulary so advanced output stays precise instead of sounding synthetic"),
  "metrics"=list(title="Metrics", protocol=NULL, schema=NULL,
    low="tracking queue depth, latency bands, and cost signals across the active workload",
    high="correlating token spend, SLO burn, GPU occupancy, and attestation coverage in one metrics lane",
    extreme="folding evaluation score movement, blob economics, and runner pressure into a single operations dashboard"),
  "network-activity"=list(title="Network activity", protocol="grpc", schema=NULL,
    low="observing RPC, event-stream, and adapter traffic across the current service boundary",
    high="mapping MCP calls, inference APIs, registry fetches, and cross-domain message flow under backpressure",
    extreme="profiling mixed gRPC, Kafka, MQTT, and bridge traffic while preserving replay semantics and retry windows"),
  "system-monitoring"=list(title="System monitoring", protocol=NULL, schema=NULL,
    low="watching collector pressure, runner health, and process saturation on the active stack",
    high="capturing GPU memory pressure, secret-scan spikes, sandbox failures, and scheduler queue churn",
    extreme="stitching host telemetry, proof queues, provisioning lag, and policy denials into one operational heartbeat"),
  "agent-workflows"=list(title="Agent workflows", protocol="mcp", schema=list(name="agent-workflow-envelope", version="2026-04"),
    low="routing coding-agent work through review queues and approval gates",
    high="coordinating delegated patch runs, blocked tool calls, and human checkpoints across multiple repos",
    extreme="orchestrating branch handoff envelopes, MCP leases, and merge-safe approval chains for background agents"),
  "platform-engineering"=list(title="Platform engineering", protocol=NULL, schema=NULL,
    low="maintaining golden paths, service templates, and workload identity for self-service delivery",
    high="resolving platform policy denials, tenant quotas, and template drift inside the internal developer portal",
    extreme="reconciling workload identity, cluster tenancy, policy bundles, and queue fairness across platform control planes"),
  "observability-ai-runtime"=list(title="Observability AI runtime", protocol=NULL, schema=list(name="otel-runtime-event", version="2026-04"),
    low="recording traces, token spend, and latency bands for the active runtime",
    high="tracking OTel collector saturation, span cardinality, and GPU telemetry alongside tool-call traces",
    extreme="driving burn-rate analysis across inference queues, cost attribution, and distributed reasoning spans"),
  "delivery-preview-ops"=list(title="Delivery preview ops", protocol=NULL, schema=NULL,
    low="managing preview environments, feature flags, and canary promotions for current changes",
    high="holding rollout gates on runner saturation, preview drift, and canary health regression signals",
    extreme="sequencing flag freezes, rollback windows, and staged promotion rules across agent-authored delivery pipelines"),
  "supply-chain-security"=list(title="Supply-chain security", protocol=NULL, schema=list(name="provenance-check", version="2026-04"),
    low="checking artifact trust, secret exposure, and dependency health before release",
    high="verifying provenance attestations, AIBOM coverage, revocation posture, and tamper signals across build lanes",
    extreme="gating release promotion on signed artifacts, dependency substitution checks, and cross-tool trust evidence"),
  "ai-governance"=list(title="AI governance fallback", protocol="responses_api", schema=list(name="grouped-ai-governance", version="2026-04"),
    low="routing evaluation, retrieval, identity, provenance, and governance work through a grouped deterministic fallback",
    high="grouping inference ops, guardrails, retrieval, AIBOM, identity, and governance signals until dedicated ports land",
    extreme="preserving fail-visible grouped AI governance semantics without pretending later-family dedicated parity exists"),
  "security-blockchain"=list(title="Security and blockchain fallback", protocol="mcp", schema=list(name="grouped-security-blockchain", version="2026-04"),
    low="tracking trust, boundary security, supply-chain, and blockchain operations as one deferred family group",
    high="grouping agent-boundary, cross-chain, sequencer, and trust-fabric work behind one deterministic fallback",
    extreme="keeping advanced security and blockchain scenarios explicit while dedicated later-family rewrites remain deferred"),
  "health-protocol"=list(title="Health and protocol fallback", protocol="fhir_r4", schema=list(name="grouped-health-protocol", version="2026-04"),
    low="handling healthcare, EV charging, streaming, and RPC protocol scenarios through grouped deterministic routing",
    high="grouping FHIR, SMART, HL7, DICOMweb, OCPP, OCPI, streaming, and service-mesh signals for later expansion",
    extreme="preserving clinical and protocol semantics as grouped fallback events with explicit traceability gaps"),
  "overlay-quantum"=list(title="Quantum overlay fallback", protocol="open_qasm3", schema=list(name="grouped-quantum-overlay", version="2026-04"),
    low="tracking hybrid runtime, batch, compiler, interop, capacity, and simulator concerns as a grouped quantum overlay",
    high="grouping quantum runtime and compiler-adapter work until a dedicated post-modern-core tranche opens",
    extreme="surfacing scarce-capacity quantum orchestration as a deterministic grouped fallback, not a fake full port")
)

usage <- function(code=0) {
  cat("Usage: Rscript bin/stakeholder.R [--list-values] [--focus-family FAMILY] [--output-format text|json] [--seed N] [options]\n")
  cat("Options: --dev-type VALUE --jargon VALUE --complexity VALUE --duration N --alerts --project NAME --minimal --team --framework VALUE --no-color --trace --experimental-provider NAME\n")
  quit(status=code)
}

fail <- function(msg) { cat(paste0("error: ", msg, "\n"), file=stderr()); quit(status=2) }

parse_args <- function(argv) {
  cfg <- list(dev_type="backend", jargon="medium", complexity="medium", duration=1L, alerts=FALSE,
              project="distributed-cluster", minimal=FALSE, team=FALSE, framework="", seed=NULL,
              output_format="text", no_color=!is.na(Sys.getenv("NO_COLOR", unset=NA)), trace=FALSE,
              list_values=FALSE, focus_family=NULL, experimental_provider=NULL)
  i <- 1L
  while (i <= length(argv)) {
    arg <- argv[[i]]
    need <- function(name) { if (i + 1L > length(argv)) fail(paste(name, "requires a value")); argv[[i + 1L]] }
    if (arg %in% c("-h", "--help")) usage(0)
    else if (arg == "--list-values") cfg$list_values <- TRUE
    else if (arg == "--alerts") cfg$alerts <- TRUE
    else if (arg == "--minimal") cfg$minimal <- TRUE
    else if (arg == "--team") cfg$team <- TRUE
    else if (arg == "--no-color") cfg$no_color <- TRUE
    else if (arg == "--trace") cfg$trace <- TRUE
    else if (arg == "--dev-type") { cfg$dev_type <- need(arg); i <- i + 1L }
    else if (arg == "--jargon") { cfg$jargon <- need(arg); i <- i + 1L }
    else if (arg == "--complexity") { cfg$complexity <- need(arg); i <- i + 1L }
    else if (arg == "--duration") { cfg$duration <- suppressWarnings(as.integer(need(arg))); i <- i + 1L }
    else if (arg == "--project") { cfg$project <- need(arg); i <- i + 1L }
    else if (arg == "--framework") { cfg$framework <- need(arg); i <- i + 1L }
    else if (arg == "--seed") { cfg$seed <- suppressWarnings(as.integer(need(arg))); i <- i + 1L }
    else if (arg == "--output-format") { cfg$output_format <- need(arg); i <- i + 1L }
    else if (arg == "--focus-family") { cfg$focus_family <- need(arg); i <- i + 1L }
    else if (arg == "--experimental-provider") { cfg$experimental_provider <- need(arg); i <- i + 1L }
    else fail(paste("unknown argument", arg))
    i <- i + 1L
  }
  if (!(cfg$dev_type %in% DEV_TYPES)) fail(paste("invalid --dev-type", cfg$dev_type))
  if (!(cfg$jargon %in% JARGON_LEVELS)) fail(paste("invalid --jargon", cfg$jargon))
  if (!(cfg$complexity %in% COMPLEXITIES)) fail(paste("invalid --complexity", cfg$complexity))
  if (!(cfg$output_format %in% OUTPUT_FORMATS)) fail(paste("invalid --output-format", cfg$output_format))
  if (!is.null(cfg$focus_family) && !(cfg$focus_family %in% ALL_FAMILIES)) fail(paste("invalid --focus-family", cfg$focus_family))
  if (is.na(cfg$duration) || cfg$duration < 0L) fail("--duration must be a non-negative integer")
  if (!is.null(cfg$seed) && is.na(cfg$seed)) fail("--seed must be an integer")
  if (!is.null(cfg$experimental_provider)) fail("--experimental-provider is intentionally fail-fast in deterministic R Tranche C; live providers are out-of-band")
  cfg
}

json_escape <- function(x) {
  x <- gsub("\\\\", "\\\\\\\\", x)
  x <- gsub('"', '\\\\"', x)
  x <- gsub("\n", "\\\\n", x)
  x
}

json_value <- function(x) {
  if (is.null(x)) return("null")
  if (is.logical(x)) return(ifelse(x, "true", "false"))
  if (is.numeric(x)) return(as.character(x))
  if (is.character(x)) {
    if (length(x) == 1L) return(paste0('"', json_escape(x), '"'))
    return(paste0("[", paste(vapply(x, json_value, character(1)), collapse=","), "]"))
  }
  if (is.list(x) && is.null(names(x))) return(paste0("[", paste(vapply(x, json_value, character(1)), collapse=","), "]"))
  if (is.list(x)) {
    parts <- character(0)
    for (nm in names(x)) parts <- c(parts, paste0('"', json_escape(nm), '":', json_value(x[[nm]])))
    return(paste0("{", paste(parts, collapse=","), "}"))
  }
  paste0('"', json_escape(as.character(x)), '"')
}

rng_new <- function(seed) list(state=ifelse(is.null(seed), 246813579L, as.integer(seed) %% 2147483647L))
rng_next <- function(rng, n) {
  rng$state <- (1103515245 * rng$state + 12345) %% 2147483647
  list(rng=rng, value=as.integer(rng$state %% n) + 1L)
}
choose_one <- function(pool, rng) { r <- rng_next(rng, length(pool)); list(value=pool[[r$value]], rng=r$rng) }

activity_count <- function(complexity) switch(complexity, low=1L, medium=2L, high=3L, extreme=4L)
message_for <- function(desc, jargon) if (jargon %in% c("low", "medium")) desc$low else if (jargon == "high") desc$high else desc$extreme

eligible_families <- function(cfg) {
  families <- DEDICATED_FAMILIES
  context <- tolower(paste(cfg$project, cfg$framework))
  if (cfg$dev_type %in% c("blockchain", "security") || grepl("chain|wallet|rollup|security|trust", context)) families <- c(families, "security-blockchain")
  if (grepl("ehr|emr|fhir|hl7|openehr|dicom|clinical|patient|hospital|charge|charger|charging|ocpp|ocpi|mcp|a2a|mqtt|nats|kafka|grpc|graphql|webtransport", context)) families <- c(families, "health-protocol")
  if (grepl("quantum|qir|qasm|braket|qiskit|cudaq|ionq", context)) families <- c(families, "overlay-quantum")
  if (grepl("experimental|openai|anthropic|claude|responses|llm|eval|retrieval", context) || cfg$dev_type %in% c("machine_learning", "data_science")) families <- c(families, "ai-governance")
  unique(families)
}

pick_plan <- function(cfg, rng) {
  if (!is.null(cfg$focus_family)) return(list(families=cfg$focus_family, rng=rng))
  eligible <- eligible_families(cfg)
  count <- activity_count(cfg$complexity)
  selected <- character(0)
  pools <- list(CLASSIC_SIX, MODERN_CORE, c("supply-chain-security", "observability-ai-runtime", GROUPED_FALLBACK), eligible)
  for (pool in pools) {
    pool <- intersect(pool, eligible)
    pool <- setdiff(pool, selected)
    if (length(selected) < count && length(pool) > 0L) { c <- choose_one(pool, rng); selected <- c(selected, c$value); rng <- c$rng }
  }
  while (length(selected) < count) { pool <- setdiff(eligible, selected); if (!length(pool)) break; c <- choose_one(pool, rng); selected <- c(selected, c$value); rng <- c$rng }
  if (cfg$alerts) selected <- unique(c(selected, "supply-chain-security"))
  if (cfg$team) selected <- unique(c(selected, "agent-workflows"))
  list(families=selected, rng=rng)
}

schema_or_null <- function(schema) if (is.null(schema)) NULL else list(name=schema$name, version=schema$version)
provenance <- function(adapter="static-catalog") list(sourceRepo="rust-stakeholder", targetRepo="r-stakeholder", baseline="2026-plus-source-evolution", experimental=FALSE, adapterType=adapter, promptVersion=NULL)

event <- function(type, seq, msg, family=NULL, cfg=NULL, adapter="static-catalog") {
  desc <- if (is.null(family)) NULL else DESCRIPTORS[[family]]
  ctx <- list()
  if (!is.null(cfg)) {
    ctx <- list(project=cfg$project, devType=cfg$dev_type, complexity=as.character(activity_count(cfg$complexity)), outputFormat=cfg$output_format)
    if (!is.null(cfg$seed)) ctx$seed <- as.character(cfg$seed)
    if (nzchar(cfg$framework)) ctx$framework <- cfg$framework
  }
  if (!is.null(family)) ctx$family <- family
  list(eventType=type, sequence=seq, timestamp=sprintf("T+%06dms", seq * 137L), message=msg,
       family=family, protocol=if (is.null(desc)) NULL else desc$protocol, schemaRef=if (is.null(desc)) NULL else schema_or_null(desc$schema),
       flavors=list(), generationProvenance=provenance(adapter), context=ctx)
}

print_event <- function(ev, cfg) {
  if (cfg$output_format == "json") cat(json_value(ev), "\n", sep="")
  else {
    prefix <- if (is.null(ev$family)) "" else paste0("[", DESCRIPTORS[[ev$family]]$title, "] ")
    cat(prefix, ev$message, "\n", sep="")
  }
}

list_values <- function() {
  list(devTypes=DEV_TYPES, jargonLevels=JARGON_LEVELS, complexities=COMPLEXITIES, outputFormats=OUTPUT_FORMATS,
       flags=c("alerts", "project", "minimal", "team", "framework", "seed", "output-format", "no-color", "trace", "list-values", "focus-family", "experimental-provider"),
       dedicatedFamilies=DEDICATED_FAMILIES, groupedFallbackFamilies=GROUPED_FALLBACK, generatorFamilies=ALL_FAMILIES)
}

main <- function() {
  cfg <- parse_args(commandArgs(trailingOnly=TRUE))
  if (cfg$list_values) { cat(json_value(list_values()), "\n", sep=""); return(invisible(0)) }
  rng <- rng_new(cfg$seed)
  seq <- 1L
  print_event(event("session.start", seq, paste("starting 2026+ source-evolution session for", cfg$project), cfg=cfg), cfg)
  plan <- pick_plan(cfg, rng); rng <- plan$rng
  for (family in plan$families) {
    seq <- seq + 1L
    desc <- DESCRIPTORS[[family]]
    print_event(event("activity", seq, message_for(desc, cfg$jargon), family, cfg), cfg)
    if (cfg$trace) { seq <- seq + 1L; print_event(event("trace", seq, paste("scheduled", family, "through R deterministic planner"), family, cfg, "trace"), cfg) }
  }
  seq <- seq + 1L
  reason <- if (cfg$duration == 0L) "duration-zero-single-deterministic-cycle" else "duration-elapsed"
  print_event(event("session.end", seq, paste0("session terminated (", reason, ")"), cfg=cfg), cfg)
}

main()
