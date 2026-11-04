#!/bin/sh
# PreToolUse on Write|Edit|Bash: stop the first writes after each prompt, with the trigger as the
# reason. The agent may send several writes at once, so each write is denied on its first attempt.
# A second attempt at any denied write is the agent's retry, and lets every later write through.
input=$(cat)

# First match only, as raw JSON text. A quoted key inside a string value is escaped, so it cannot
# match.
field() {
  printf '%s' "$input" | grep -oE "\"$1\" *: *\"([^\"\\\\]|\\\\.)*\"" | head -n 1 |
    sed 's/^"[^"]*" *: *"\(.*\)"$/\1/'
}

# A subagent was briefed by the agent, not the user, so its writes are not stopped.
[ -n "$(field agent_id)" ] && exit 0

id=$(field prompt_id)
[ -n "$id" ] || id=$(field session_id)
dir=$(field scratchpad_dir)
[ -d "$dir" ] || dir=${TMPDIR:-/tmp}
state="$dir/intent-first-write-$id"

# A shell command counts as a write only when it plainly writes files: a redirect into a file, a
# command that creates, copies, moves or deletes files, an in-place edit, a git command that
# changes the working tree, or an install or scaffolding command. Any other command runs as usual.
writes() {
  printf '%s' "$1" | sed -e 's#[0-9]*>>*[[:space:]]*/dev/null##g' -e 's#[0-9]*>&[0-9-]##g' | grep -qE \
    -e '(^|[^-=<>])>' \
    -e '(^|[;&|(]|\$\(|\\n)[[:space:]]*(sudo[[:space:]]+)?(mkdir|touch|cp|mv|rm|tee|ln|install|truncate|patch|dd|unzip|tar)([[:space:]]|$)' \
    -e '(sed|perl)[[:space:]]([^;&|]*[[:space:]])?-i' \
    -e 'git[[:space:]]+(apply|checkout|switch|restore|clone|init|mv|rm|stash|reset|merge|rebase|pull|am|cherry-pick|revert)([[:space:]]|$)' \
    -e '(npm|pnpm|yarn|bun|pip3?|uv|poetry|cargo|go)[[:space:]]+(init|create|install|add|new|get|mod[[:space:]]+init)([[:space:]]|$)' \
    -e 'npx[[:space:]]+create-|archetype:generate|startproject|(rails|dotnet)[[:space:]]+new'
}

if [ "$(field tool_name)" = Bash ]; then
  cmd=$(field command)
  writes "$cmd" || exit 0
  key=$(printf '%s' "$cmd" | cksum | cut -d ' ' -f 1)
else
  # Several edits to one file can be sent at once. The text each replaces tells them apart.
  key=$(printf '%s\n%s' "$(field file_path)" "$(field old_string)" | cksum | cut -d ' ' -f 1)
fi

[ -e "$state/released" ] && exit 0
if [ -e "$state/$key" ]; then
  : > "$state/released"
  exit 0
fi

deny() {
  reason=$(printf '%s' "$1" | sed 's/[\\"]/\\&/g')
  printf '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"%s"}}\n' "$reason"
}

# mkdir is atomic, so of several writes sent at once exactly one gets the full reason.
if mkdir "$state" 2>/dev/null; then
  : > "$state/$key"
  deny "$(tr '\n\t\r' '   ' < "$(dirname "$0")/trigger.md")If it does state its problem, or the user has declined a review this session, make these writes again, and do not comment on how the request was briefed. Only the first writes after each prompt are stopped."
else
  : > "$state/$key"
  deny "Stopped as one of the first writes after this prompt. The reason is on the first write that was stopped."
fi
