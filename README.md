# openclaw-gha-smoke

Minimal GitHub Actions smoke test for installing OpenClaw with the **official installer script** on **macOS**, starting the Gateway, and checking health.

## What this does

- Runs on `macos-latest`
- Installs OpenClaw via the official installer script:
  - `curl -fsSL https://openclaw.ai/install.sh | bash -s -- --no-onboard`
- Verifies `openclaw --version`
- Starts `openclaw gateway`
- Runs `openclaw gateway status`
- Runs `openclaw health`
- Optionally checks whether `TELEGRAM_BOT_TOKEN` is present in GitHub Actions secrets

## Required GitHub secrets for Telegram

- `TELEGRAM_BOT_TOKEN`

## Notes

This repository verifies installation and basic Gateway startup/health in GitHub Actions. It does **not** provide a persistent Telegram bot runtime by itself, because GitHub Actions runners are ephemeral.
