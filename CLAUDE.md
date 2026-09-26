# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this
repository.

A Claude Code plugin of two skills. All content is prompt text: there is nothing to build, test
or lint, and no dependencies. `README.md` says what each skill does; `intent.md` states the
problem the plugin solves and the constraints it holds itself to. Read both before changing a
skill.

## Guidance stays at principle level

Both skills give the agent distinctions and the judgment to apply them. Neither enumerates
scenarios or prescribes a response per situation. Adding "if the user says X, do Y" is the
default failure here, and it fails silently: the skill still runs, but the agent pattern-matches
an unlisted case to the nearest listed one and gets it wrong. Full rationale is under Constraints
in `intent.md`.

## The plugin is self-contained

Sibling directories under `../` are unrelated plugins. Do not reference them from anything in
this repo, and do not make a skill here depend on one. They may later be tuned to consume
`intent.md`; that is their side of the boundary, not this one's.

## Shared reference files

Both `skills/*/SKILL.md` load `reference/` files by `${CLAUDE_PLUGIN_ROOT}` path. A renamed or
moved file breaks nothing visibly — the skill loads and the agent simply never reads the
distinctions — so grep for the path before moving one.

`reference/intent-template.md` is the fixed shape of the `intent.md` the plugin produces.
Changing its sections changes the format other work is meant to check against.

## intent.md

The `intent.md` in this repo is the author's working notes on the plugin, not output of
`intent-capture` and not a spec. It runs longer than the 400 words the plugin enforces on the
documents it writes.
