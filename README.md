# openclaw-gha-smoke

Minimal GitHub Actions smoke test for installing OpenClaw, checking the CLI, and preparing Telegram configuration via GitHub secrets.

## What this does

- Installs Node 22
- Installs OpenClaw globally with npm
- Verifies `openclaw --version`
- Runs a basic CLI probe (`openclaw --help`)
- Optionally injects `TELEGRAM_BOT_TOKEN` from GitHub Actions secrets for later channel setup

## Required GitHub secrets for Telegram

- `TELEGRAM_BOT_TOKEN`

## Notes

This workflow is only a smoke test scaffold. Actually connecting a Telegram bot also requires configuring channel settings and allowing the bot/account to message you.
