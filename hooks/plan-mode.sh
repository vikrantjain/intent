#!/bin/sh
# UserPromptSubmit: add the trigger when the user is in plan mode. Otherwise print nothing, so
# nothing enters the agent's context.
input=$(cat)
if printf '%s' "$input" | grep -q '"permission_mode" *: *"plan"'; then
  cat "$(dirname "$0")/trigger.md"
fi
