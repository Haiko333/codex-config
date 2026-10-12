#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════════════════
# Codex CLI Configuration Installer
# Installs custom skills, instructions, hooks, plugins, and config
# ═══════════════════════════════════════════════════════════════════════

set -euo pipefail

CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log()   { echo -e "${GREEN}[+]${NC} $1"; }
warn()  { echo -e "${YELLOW}[!]${NC} $1"; }
error() { echo -e "${RED}[x]${NC} $1"; exit 1; }
info()  { echo -e "${BLUE}[i]${NC} $1"; }

is_codex_available() {
  command -v codex &>/dev/null
}

install_marketplace() {
  local marketplace_name="$1"
  local marketplace_source="$2"

  if codex plugin marketplace add "$marketplace_source"; then
    log "Marketplace ready: $marketplace_name"
    return 0
  fi

  warn "Could not add marketplace: $marketplace_name"
}

install_plugin() {
  local plugin_id="$1"

  if codex plugin add "$plugin_id"; then
    log "Plugin ready: $plugin_id"
    return 0
  fi

  warn "Could not install plugin: $plugin_id"
}

install_codex_plugins() {
  if ! is_codex_available; then
    warn "Codex CLI not found; skipping plugin installation."
    return 0
  fi

  install_marketplace "ponytail" "DietrichGebert/ponytail"
  install_marketplace "aiblueprint" "melvynx/aiblueprint"
  install_marketplace "claude-plugins-official" "anthropics/claude-plugins-official"

  install_plugin "ponytail@ponytail"
  install_plugin "aibp-base@aiblueprint"
  install_plugin "clangd-lsp@claude-plugins-official"
}

echo ""
echo "═══════════════════════════════════════════════════════"
echo "  Codex CLI Configuration Installer"
echo "═══════════════════════════════════════════════════════"
echo ""

# ── Pre-flight checks ────────────────────────────────────────────────

if ! is_codex_available; then
  warn "Codex CLI not found. Install it first: npm i -g @openai/codex"
  warn "Continuing with file installation anyway..."
fi

if [ ! -d "$CODEX_HOME" ]; then
  error "Codex home directory not found at $CODEX_HOME. Run codex once first."
fi

# ── Backup existing config ───────────────────────────────────────────

if [ -f "$CODEX_HOME/config.toml" ]; then
  BACKUP="$CODEX_HOME/config.toml.backup.$(date +%Y%m%d%H%M%S)"
  cp "$CODEX_HOME/config.toml" "$BACKUP"
  log "Backed up existing config to $BACKUP"
fi

# ── Install config.toml ─────────────────────────────────────────────

if [ -f "$SCRIPT_DIR/config.toml" ]; then
  # Rewrite absolute paths to match current user's home.
  sed "s|/home/h41k0|$HOME|g" "$SCRIPT_DIR/config.toml" > "$CODEX_HOME/config.toml"
  log "Installed config.toml"
else
  warn "config.toml not found in $SCRIPT_DIR"
fi

# ── Install instructions.md ──────────────────────────────────────────

if [ -f "$SCRIPT_DIR/instructions.md" ]; then
  cp "$SCRIPT_DIR/instructions.md" "$CODEX_HOME/instructions.md"
  log "Installed instructions.md"
else
  warn "instructions.md not found in $SCRIPT_DIR"
fi

# ── Install custom skills ───────────────────────────────────────────

SKILLS_DIR="$CODEX_HOME/skills"
CUSTOM_SKILLS_SRC="$SCRIPT_DIR/skills"

if [ -d "$CUSTOM_SKILLS_SRC" ]; then
  mkdir -p "$SKILLS_DIR"
  SKILL_COUNT=0
  for skill_dir in "$CUSTOM_SKILLS_SRC"/*/; do
    skill_name=$(basename "$skill_dir")
    # Skip system skills.
    if [ "$skill_name" = ".system" ]; then
      continue
    fi
    cp -r "$skill_dir" "$SKILLS_DIR/$skill_name"
    SKILL_COUNT=$((SKILL_COUNT + 1))
  done
  log "Installed $SKILL_COUNT custom skills"
else
  warn "No skills directory found in $SCRIPT_DIR"
fi

# ── Install scripts (hooks) ─────────────────────────────────────────

SCRIPTS_SRC="$SCRIPT_DIR/scripts"
SCRIPTS_DST="$CODEX_HOME/scripts"

if [ -d "$SCRIPTS_SRC" ]; then
  mkdir -p "$SCRIPTS_DST"
  cp -r "$SCRIPTS_SRC"/* "$SCRIPTS_DST/"
  find "$SCRIPTS_DST" -name "*.sh" -exec chmod +x {} \;
  find "$SCRIPTS_DST" -name "*.py" -exec chmod +x {} \;
  find "$SCRIPTS_DST" -type f -name "*.sh" -exec sed -i "s|/home/h41k0|$HOME|g" {} \;
  log "Installed hook scripts"
else
  warn "No scripts directory found in $SCRIPT_DIR"
fi

# ── Install Codex plugins ───────────────────────────────────────────

install_codex_plugins

# ── Summary ──────────────────────────────────────────────────────────

echo ""
echo "═══════════════════════════════════════════════════════"
echo "  Installation Complete"
echo "═══════════════════════════════════════════════════════"
echo ""
info "Config:        $CODEX_HOME/config.toml"
info "Instructions:  $CODEX_HOME/instructions.md"
info "Skills:        $SKILLS_DIR/ ($(ls -d "$SKILLS_DIR"/*/ 2>/dev/null | grep -v .system | wc -l) custom)"
info "Scripts:       $SCRIPTS_DST/"
info "Plugins:       ponytail, aibp-base, clangd-lsp + configured OpenAI plugins"
echo ""
log "Run 'codex' to start using the new configuration."
echo ""
