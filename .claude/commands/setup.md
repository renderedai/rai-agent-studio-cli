---
description: Set up the Rendered.ai Agent Studio CLI — checks authentication, guides login or registration, and shows available actions.
---

# Setup — Rendered.ai Agent Studio CLI

Follow these steps in order.

## Step 0: Resolve the CLI Binary

Before running any command, determine which binary to use. Try each option in order:

```bash
if command -v rai-ast >/dev/null 2>&1; then
    CLI="rai-ast"
elif [ -f /workspace/repos/agent-studio-cli/target/release/rai-ast ]; then
    CLI="/workspace/repos/agent-studio-cli/target/release/rai-ast"
elif [ -f "$HOME/.local/bin/rai-ast" ]; then
    CLI="$HOME/.local/bin/rai-ast"
else
    echo "CLI_NOT_FOUND"
fi
echo "CLI=$CLI"
```

If `CLI_NOT_FOUND`, tell the user the CLI binary is not installed and offer to install it:
```bash
curl -fsSL https://raw.githubusercontent.com/renderedai/agent-studio-cli/main/install.sh | bash
```
After install, re-resolve the binary. If install fails, stop and report the error.

## Step 1: Check Authentication Status

Run this synchronously:

```bash
$CLI auth whoami 2>&1
```

**If the output contains a user identity** (e.g., a name and email) — the user is already logged in.
Skip to **Step 3**.

**If the output indicates the user is not authenticated** (e.g., `AUTH_REQUIRED`, error, or no user info) — continue to Step 2.

## Step 2: Log In or Register

**STOP and ask the user:**

> Do you already have a Rendered.ai account, or do you need to create one?

Wait for their response. Do NOT proceed until they answer.

- **If they have an account** → invoke the `rai-ast` skill with "login":
  Use the rai-ast skill to run the full two-phase login flow (`auth login` → `auth callback` in background → present URL → wait for completion).

- **If they need to sign up** → invoke the `rai-ast` skill with "register":
  Use the rai-ast skill to run the full two-phase registration flow (`auth register` → `auth callback` in background → present URL → wait for completion).

After authentication completes successfully, continue to Step 3.

## Step 3: Show Available Actions

First, greet the user (use their name from `auth whoami` if available).

Then present the following:

---

**You're all set!** Here's what you can do with the Rendered.ai Agent Studio:

### Organizations & Workspaces
Manage your organizations and workspaces.
- `"Show my organizations"`
- `"List my workspaces"`
- `"Create a new workspace called 'my-project'"`

### Services
Browse, run, and create containerized tools.
- `"What services are available?"`
- `"Run the <service-name> service"`
- `"Create a new service for <describe what you need>"`
- `"Deploy my service"`

### Volumes
Manage shared storage for your data and outputs.
- `"List my volumes"`
- `"Create a volume for storing training data"`
- `"Upload files to my volume"`

### Members & Access
Manage team members and permissions.
- `"Show members in my organization"`
- `"Add a new member to my org"`

### API Keys
Manage API keys for programmatic access.
- `"List my API keys"`
- `"Create a new API key"`

### MCP Servers
Configure Model Context Protocol servers.
- `"Show my MCP servers"`
- `"Create a new MCP server"`

### Account
- `"Show my account info"` — see who you're logged in as
- `"Switch organization"` — change your active organization
- `"Log out"` — sign out of the CLI

---

Ask the user what they'd like to do first.
