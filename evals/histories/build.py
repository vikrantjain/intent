#!/usr/bin/env python3
"""Build each mid-session case's history.jsonl from turns.json.

A mid-session case resumes a prior conversation, and the eval runner takes that
conversation as a session transcript. Writing the transcripts from turns.json
keeps them free of local paths and personal settings.

A turn with a "skill" key is a slash-command invocation. Its transcript also
carries the skill's current SKILL.md body, as a real session would. Run this
again after changing a skill, so the histories carry the current text.
"""

import json
import re
import uuid
from pathlib import Path

HERE = Path(__file__).resolve().parent
EVALS = HERE.parent
PLUGIN = EVALS.parent
PLUGIN_ROOT = "/plugins/intent"
SESSION = "00000000-0000-4000-8000-000000000000"
TIMESTAMP = "2026-01-01T00:00:00.000Z"


def skill_body(name):
    text = (PLUGIN / "skills" / name / "SKILL.md").read_text()
    body = re.sub(r"\A---\n.*?\n---\n+", "", text, flags=re.S)
    body = body.replace("${CLAUDE_PLUGIN_ROOT}", PLUGIN_ROOT)
    return f"Base directory for this skill: {PLUGIN_ROOT}/skills/{name}\n\n{body}"


def record(kind, message, parent, **extra):
    return {
        "parentUuid": parent,
        "isSidechain": False,
        "type": kind,
        "uuid": str(uuid.uuid4()),
        "timestamp": TIMESTAMP,
        "userType": "external",
        "cwd": "/workspace",
        "sessionId": SESSION,
        "message": message,
        **extra,
    }


def transcript(turns):
    records, parent = [], None
    for turn in turns:
        if turn["role"] == "assistant":
            message = {
                "id": f"msg_history_{len(records)}",
                "type": "message",
                "role": "assistant",
                "model": "claude-sonnet-5",
                "content": [{"type": "text", "text": turn["text"]}],
                "stop_reason": "end_turn",
                "stop_sequence": None,
                "usage": {"input_tokens": 0, "output_tokens": 0},
            }
            records.append(record("assistant", message, parent))
        elif "skill" in turn:
            name = f"intent:{turn['skill']}"
            command = (
                f"<command-message>{name}</command-message>\n"
                f"<command-name>/{name}</command-name>\n"
                f"<command-args>{turn['args']}</command-args>"
            )
            records.append(record("user", {"role": "user", "content": command}, parent))
            parent = records[-1]["uuid"]
            meta = {"role": "user", "content": [{"type": "text", "text": skill_body(turn["skill"])}]}
            records.append(record("user", meta, parent, isMeta=True))
        else:
            records.append(record("user", {"role": "user", "content": turn["text"]}, parent))
        parent = records[-1]["uuid"]
    return records


def main():
    spec = json.loads((HERE / "turns.json").read_text())
    for case, history in spec["cases"].items():
        lines = [json.dumps(r, ensure_ascii=False) for r in transcript(spec["histories"][history])]
        (EVALS / case / "history.jsonl").write_text("\n".join(lines) + "\n")
        print(f"wrote {case}/history.jsonl")


if __name__ == "__main__":
    main()
