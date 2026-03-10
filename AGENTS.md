# AGENTS.md

## Repository Overview

This is the **private** source repository for the Rendered.ai Agent Studio CLI (`rai-ast`).
The public distribution repo is [renderedai/rai-agent-studio-cli](https://github.com/renderedai/rai-agent-studio-cli).

## Architecture

- **`src/`** — Rust source code for the `rai-ast` binary (private, not synced to public repo)
- **`Cargo.toml`** — Rust project manifest (private)
- **`skills/`** — Agent skills (synced to public repo)
- **`.claude-plugin/`** — Claude Code plugin manifest and marketplace config (synced)
- **`.claude/skills/`** — Claude Code skill copy (synced)
- **`hooks/`** — Plugin hooks for auto-installing the binary (synced)
- **`install.sh`** — Binary installer script (synced)
- **`install-skill.sh`**, **`install-gemini-skill.sh`**, **`install-codex-skill.sh`** — Skill installer scripts (synced)
- **`GEMINI.md`**, **`gemini-extension.json`** — Gemini CLI extension files (synced)
- **`README.md`** — Documentation (synced)

## CI/CD Workflows

### `sync-public.yml`
Triggers on push to `main`. Syncs only distribution files to the public repo.
Requires the `PUBLIC_REPO_PAT` secret (fine-grained PAT with contents write access to the public repo).

### `release.yml`
Triggers on version tags (`v*`). Builds cross-platform binaries, creates a release on **this** repo,
and also creates a matching release on the **public** repo so users can download binaries.
Requires the `PUBLIC_REPO_PAT` secret.

## Public Repo Sync

Only these files are synced to the public repo:

```
README.md
AGENTS.md
install.sh
install-skill.sh
install-gemini-skill.sh
install-codex-skill.sh
skills/
.claude-plugin/
.claude/skills/
hooks/
GEMINI.md
gemini-extension.json
```

Everything else (source code, internal docs, dev config) stays private.

## Secrets Required

Both workflows use a **GitHub App** for authentication (no personal tokens).

| Secret | Purpose |
|--------|---------|
| `SYNC_APP_ID` | GitHub App ID for the repo-sync app |
| `SYNC_APP_PRIVATE_KEY` | PEM private key for the repo-sync app |

The GitHub App must be installed on `renderedai/rai-agent-studio-cli` with permissions:
- **Contents**: Read and write (push files, create releases)
- **Metadata**: Read (required by default)

## Development Notes

- Binary name: `rai-ast` (defined in `Cargo.toml` `[[bin]]`)
- The `install.sh` downloads from GitHub Releases on the **public** repo
- Skills follow the [Agent Skills open standard](https://agentskills.io/specification)
- The plugin uses a `SessionStart` hook to auto-install the binary
