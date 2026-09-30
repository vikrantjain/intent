#!/bin/sh
# PreToolUse on Write|Edit: stop the first writes after each prompt, with the trigger as the
# reason. The agent may send several writes at once, so each path is denied on its first attempt.
# A second attempt at any denied path is the agent's retry, and lets every later write through.
input=$(cat)

# First match only. A quoted key inside the tool input is escaped, so it cannot match.
field() {
  printf '%s' "$input" | grep -o "\"$1\" *: *\"[^\"]*\"" | head -n 1 | sed 's/.*"\([^"]*\)"$/\1/'
}

id=$(field prompt_id)
[ -n "$id" ] || id=$(field session_id)
dir=$(field scratchpad_dir)
[ -d "$dir" ] || dir=${TMPDIR:-/tmp}
state="$dir/intent-first-write-$id"
key=$(field file_path | cksum | cut -d ' ' -f 1)

[ -e "$state/released" ] && exit 0
if [ -e "$state/$key" ]; then
  : > "$state/released"
  exit 0
fi

deny() {
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$1"
}

# mkdir is atomic, so of several writes sent at once exactly one gets the full reason.
if mkdir "$state" 2>/dev/null; then
  : > "$state/$key"
  # trigger.md holds no double quotes or backslashes, so it goes into the JSON string as it is.
  deny "$(tr '\n' ' ' < "$(dirname "$0")/trigger.md")If it does state its problem, make these writes again. Only the first writes after each prompt are stopped."
else
  : > "$state/$key"
  deny "Stopped with the other writes sent at the same time. The reason is on the first one."
fi
