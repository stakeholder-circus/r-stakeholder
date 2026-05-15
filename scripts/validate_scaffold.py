from pathlib import Path
import subprocess
import sys

required = [
    'README.md', 'AI_DISCLOSURE.md', 'PARITY.md', 'GAPS.md', 'AGENTS.md',
    'bin/stakeholder.R', 'tests/test_cli.R', 'docs/remotes.md', 'docs/provenance.md',
    'docs/toolchain.md', 'docs/tooling.md', 'docs/traceability/first-push-families.md',
    '.githooks/commit-msg', '.githooks/pre-push', '.github/CODEOWNERS',
    '.github/PULL_REQUEST_TEMPLATE.md', '.github/dependabot.yml',
    '.github/workflows/actionlint.yml', '.github/workflows/dependency-review.yml',
    '.github/workflows/ci.yml', '.github/workflows/ci-native.yml',
    '.github/workflows/docker-smoke.yml', 'flake.nix', 'Dockerfile', 'flake.lock', 'LICENSE'
]
missing = [p for p in required if not Path(p).exists()]
if missing:
    raise SystemExit('missing R rewrite files: ' + ', '.join(missing))
for forbidden in ['Cargo.toml', 'rust-toolchain.toml', 'src/main.rs']:
    if Path(forbidden).exists():
        raise SystemExit('Rust scaffold file still present: ' + forbidden)
commands = [
    ['Rscript', 'bin/stakeholder.R', '--list-values'],
    ['Rscript', 'tests/test_cli.R'],
]
for cmd in commands:
    completed = subprocess.run(cmd, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if completed.returncode != 0:
        sys.stdout.write(completed.stdout)
        raise SystemExit('validation command failed: ' + ' '.join(cmd))
print('R deterministic rewrite validated')
