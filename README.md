# Rendered.ai Agent Studio CLI

A fast, minimal-dependency CLI for managing services, workspaces, volumes, and more on the Rendered.ai Agent Studio platform.

[Claude Code](#claude-code) | [Gemini CLI](#google-gemini-cli) | [Codex](#openai-codex) | [CLI Only](#cli-only-linuxmacos) | [CLI Usage](#quick-start)

## AI Agent Integration

The `rai-ast` skill uses the [Agent Skills open standard](https://agentskills.io/specification)
and works across Claude Code, Google Gemini CLI, and OpenAI Codex.

### Claude Code

**Plugin** (recommended — auto-installs binary + skill):

```bash
# 1. Add the marketplace (one time)
/plugin marketplace add https://github.com/renderedai/rai-agent-studio-cli

# 2. Install the plugin
/plugin install rai-ast
```

Or use `/plugin` and follow the interactive menu.

This installs the `rai-ast` plugin, which:
- Adds the `/rai-ast:rai-ast` skill to Claude Code
- Adds the `/rai-ast:setup` command for guided onboarding

After installing, reload plugins to activate the new commands (no restart needed):

```
/reload-plugins
```

Then run `/setup` to get started:

```
/rai-ast:setup
```

This will check if you're logged in, walk you through authentication (or registration), and help you create your first workspace and server.

**Standalone skill** (skill only):

```bash
curl -fsSL https://raw.githubusercontent.com/renderedai/rai-agent-studio-cli/main/install-claude-skill.sh | bash
```

Installs the binary and skill to `~/.claude/skills/rai-ast/`.
Run `/reload-plugins` to activate `/rai-ast` without restarting.

---

### Google Gemini CLI

**Extension** (recommended — includes context file + skill):

```bash
gemini extensions install https://github.com/renderedai/rai-agent-studio-cli
```

**Standalone skill** (skill only):

```bash
curl -fsSL https://raw.githubusercontent.com/renderedai/rai-agent-studio-cli/main/install-gemini-skill.sh | bash
```

Installs the binary and skill to `~/.gemini/skills/rai-ast/`.
Restart Gemini CLI to activate.

---

### OpenAI Codex

```bash
curl -fsSL https://raw.githubusercontent.com/renderedai/rai-agent-studio-cli/main/install-codex-skill.sh | bash
```

Installs the binary and skill to `~/.codex/skills/rai-ast/`.
Restart Codex to activate.

---

## CLI Only (Linux/macOS)

For terminal users who want the `rai-ast` binary without AI agent integration.

### One-liner (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/renderedai/rai-agent-studio-cli/main/install.sh | bash
```

This downloads the pre-built binary for your platform, verifies its checksum, and installs it to `~/.local/bin/rai-ast`.

To install to a custom location:

```bash
RENDEREDAI_INSTALL_DIR=/usr/local/bin curl -fsSL https://raw.githubusercontent.com/renderedai/rai-agent-studio-cli/main/install.sh | bash
```

### Build from source

If the one-liner doesn't work (e.g., restricted network, unsupported platform), you can build from source.

**Dependencies:**
- [git](https://git-scm.com/downloads)
- [Rust/cargo](https://rustup.rs) — install with: `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

```bash
git clone https://github.com/renderedai/rai-agent-studio-cli.git
cd rai-agent-studio-cli
cargo build --release
cp target/release/rai-ast ~/.local/bin/
```

## Quick Start

### 1. Authenticate

Log in via browser (OAuth2 PKCE flow):

```bash
rai-ast auth login
```

This opens your browser to the Keycloak login page, captures the auth token, and stores it securely in your OS keychain.

To target a specific environment:

```bash
rai-ast auth login --env dev
rai-ast auth login --env test
```

### 2. Verify Your Identity

```bash
rai-ast auth whoami
```

### 3. List Workspaces

```bash
# JSON output (default)
rai-ast workspaces get

# Table output
rai-ast workspaces get --format table

# Filter by organization
rai-ast workspaces get --organization-id <ORG_ID>
```

### 4. Log Out

```bash
rai-ast auth logout
```

## Authentication Methods

The CLI supports multiple auth methods, resolved in this priority order:

| Priority | Method | Usage |
|----------|--------|-------|
| 1 | Bearer token | `--bearer-token <TOKEN>` or `RENDEREDAI_BEARER_TOKEN` env var |
| 2 | API key (CLI) | `--api-key <KEY>` or `RENDEREDAI_API_KEY` env var |
| 3 | API key (config) | Stored in `~/.rai-ast/config.yaml` |
| 4 | Keychain token | Stored automatically after `auth login` |

### Using an API Key

```bash
# Via flag
rai-ast workspaces get --api-key <YOUR_KEY>

# Via environment variable
export RENDEREDAI_API_KEY=<YOUR_KEY>
rai-ast workspaces get
```

## Environments

| Name | Flag | API |
|------|------|-----|
| Production (default) | `--env prod` | `api.rendered.ai` |
| Test | `--env test` | `api.test.rendered.ai` |
| Dev | `--env dev` | `api.dev.rendered.ai` |

## Commands

```
rai-ast auth login       Log in via browser (OAuth2 PKCE)
rai-ast auth logout      Clear stored credentials
rai-ast auth whoami      Show current user info
rai-ast workspaces get   List workspaces
rai-ast status           Check platform status
```

Additional commands (`organizations`, `members`, `volumes`, `services`, `api-keys`, `rules`, `schema`) are defined but not yet implemented.

## Global Options

| Flag | Description | Default |
|------|-------------|---------|
| `--format <json\|table>` | Output format | `json` |
| `--env <ENV>` | Target environment | `prod` |
| `--api-key <KEY>` | API key | — |
| `--bearer-token <TOKEN>` | Bearer token | — |
| `-v, --verbose` | Enable verbose logging | off |

## Configuration

Config is stored at `~/.rai-ast/config.yaml`:

```yaml
apikey: <your-api-key>
environment: <last-used-auth-url>
```

## License

MIT
