# R Edge Cases

- Seeded JSON runs are byte-stable for the same arguments.
- `--focus-family` restricts output to one listed dedicated or grouped fallback family.
- `--experimental-provider` exits non-zero with a clear deterministic-boundary message.
- `--duration 0` emits one deterministic cycle in R so validation never blocks indefinitely.
- Empty `--framework ""` is allowed.
- Invalid enum values fail with status 2.
