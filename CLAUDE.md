# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this
repository.

A Claude Code plugin of two skills. All content is prompt text: there is nothing to build, test
or lint, and no dependencies. `README.md` says what each skill does; `docs/design-notes.md` is
the author's record of the problem the plugin solves and why it is shaped this way. Read both
before changing a skill.

## Guidance stays at principle level

Both skills give the agent distinctions and the judgment to apply them. Neither enumerates
scenarios or prescribes a response per situation. Adding "if the user says X, do Y" is the
default failure here, and it fails silently: the skill still runs, but the agent pattern-matches
an unlisted case to the nearest listed one and gets it wrong. Full rationale is under Constraints
in `docs/design-notes.md`.

## Skills stay small

A skill's text and the `reference/` files it reads load into context every time it runs, and its
`description` loads in every session. Add a line only if it changes what the agent does. Cut
repetition and restatement, but never an instruction, a criterion or a calibrating example: the
skill would still run and simply work worse.

## The plugin is self-contained

Sibling directories under `../` are unrelated plugins. Do not reference them from anything in
this repo, and do not make a skill here depend on one. They may later be tuned to consume
`intent.md`; that is their side of the boundary, not this one's.

## Shared reference files

Both `skills/*/SKILL.md` load `reference/` files by `${CLAUDE_PLUGIN_ROOT}` path. A renamed or
moved file breaks nothing visibly. The skill still loads, and the agent simply never reads the
distinctions. Grep for the path before moving one.

`reference/intent-template.md` is the fixed shape of the `intent.md` the plugin produces.
Changing its sections changes the format other work is meant to check against.
