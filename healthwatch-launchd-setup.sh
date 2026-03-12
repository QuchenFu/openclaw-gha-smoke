OPENCLAW_BIN="$(command -v openclaw || which openclaw)"
echo "$OPENCLAW_BIN"

pkill -f "ai.openclaw.healthwatch" 2>/dev/null || true
launchctl bootout gui/$(id -u)/ai.openclaw.healthwatch 2>/dev/null || true
rm -f "$HOME/.openclaw/logs/health-watchdog.log" "$HOME/.openclaw/logs/healthwatch.launchd.err.log" "$HOME/.openclaw/logs/healthwatch.launchd.out.log"

mkdir -p "$HOME/.openclaw/bin" "$HOME/.openclaw/logs" "$HOME/Library/LaunchAgents"

cat > "$HOME/.openclaw/bin/openclaw-health-watchdog.sh" <<EOF
#!/bin/bash
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export HOME="$HOME"

LOG="\$HOME/.openclaw/logs/health-watchdog.log"
TS="\$(date '+%F %T')"
OPENCLAW_BIN="$OPENCLAW_BIN"
EXPECT_BIN="\$(command -v expect || true)"

if [ -z "\$OPENCLAW_BIN" ] || [ ! -x "\$OPENCLAW_BIN" ]; then
 echo "[\$TS] ERROR openclaw_not_found bin=\$OPENCLAW_BIN PATH=\$PATH" >> "\$LOG"
 exit 0
fi

OUT="\$("\$OPENCLAW_BIN" health --json 2>&1 || true)"

if ! printf '%s\n' "\$OUT" | grep -q '"ok"[[:space:]]*:[[:space:]]*true'; then
 echo "[\$TS] health_fail out=\$OUT" >> "\$LOG"
 if [ -n "\$EXPECT_BIN" ] && [ -x "\$EXPECT_BIN" ]; then
 "\$EXPECT_BIN" <<EOT >> "\$LOG" 2>&1
log_user 0
set timeout 1
spawn $OPENCLAW_BIN doctor --fix
while {1} {
 expect {
 eof { break }
 timeout { send "\\r" }
 }
}
EOT
 else
 echo "[\$TS] ERROR expect_not_found PATH=\$PATH" >> "\$LOG"
 fi
fi

exit 0
EOF

chmod +x "$HOME/.openclaw/bin/openclaw-health-watchdog.sh"

cat > "$HOME/Library/LaunchAgents/ai.openclaw.healthwatch.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
 <key>Label</key>
 <string>ai.openclaw.healthwatch</string>
 <key>ProgramArguments</key>
 <array>
 <string>/bin/bash</string>
 <string>$HOME/.openclaw/bin/openclaw-health-watchdog.sh</string>
 </array>
 <key>EnvironmentVariables</key>
 <dict>
 <key>PATH</key>
 <string>/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin</string>
 <key>HOME</key>
 <string>$HOME</string>
 </dict>
 <key>StartInterval</key>
 <integer>10</integer>
 <key>RunAtLoad</key>
 <true/>
 <key>StandardOutPath</key>
 <string>$HOME/.openclaw/logs/healthwatch.launchd.out.log</string>
 <key>StandardErrorPath</key>
 <string>$HOME/.openclaw/logs/healthwatch.launchd.err.log</string>
</dict>
</plist>
EOF

launchctl bootstrap gui/$(id -u) "$HOME/Library/LaunchAgents/ai.openclaw.healthwatch.plist"
launchctl enable gui/$(id -u)/ai.openclaw.healthwatch
launchctl kickstart -k gui/$(id -u)/ai.openclaw.healthwatch

sleep 2
launchctl print gui/$(id -u)/ai.openclaw.healthwatch | sed -n '1,80p'
echo "-----"
tail -20 "$HOME/.openclaw/logs/health-watchdog.log" 2>/dev/null
