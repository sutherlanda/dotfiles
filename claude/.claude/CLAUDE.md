# Global preferences

These apply in every project (loaded at the start of every session, regardless of which repo Claude is launched from). Project-specific context lives in each repo's own `CLAUDE.md` and auto-memory.

## Git commits

- Make **one commit per logical change** — e.g. one commit per ticket item, bug fix, or independent concern. Do **not** squash unrelated changes into a single commit. When in doubt, split.
- Commit in the order the items were listed/requested.

## Branches & PRs

- **No slashes (`/`) in branch names or PR titles** — the CI/CD pipeline breaks on them. Use hyphens (e.g. `eng-1234-short-description`).

## Memory & context

- Be **proactive about saving to memory**: checkpoint durable decisions, their rationale, non-obvious constraints, the state of ongoing multi-session work, and dead-ends ("tried X, didn't work because Y") at natural breakpoints — don't wait to be asked.
- Keep it signal, not noise: don't memorialize what the repo, git history, or a `CLAUDE.md` already records.
- Note: auto-memory is scoped per git repo, so it does **not** carry across repos — these global preferences live here in user-level `CLAUDE.md` so they apply everywhere.

## Cross-repo work

- The repos under `~/projects/zesty/` (z-view, caribou, zauth-customer) are mutually granted file access via `additionalDirectories` in each repo's `.claude/settings.local.json`.
- For git operations against another repo, use `git -C <path> …` rather than `cd` — avoids the shell cwd carrying over between commands and targeting the wrong repo.
