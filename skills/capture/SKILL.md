---
name: capture
description: Creates or updates intent.md, a short statement of the problem being solved, why it matters and what success means. Use when the user wants the intent behind a piece of work written down before starting it, or agrees to record a problem statement the conversation has settled.
---

# Intent capture

The subject is **the problem**, not the user. Get to a statement of what is being solved and why,
and write it down. This is not a review. Ask your questions as part of the conversation, and
never critique how the user asked.

Read `${CLAUDE_PLUGIN_ROOT}/reference/briefing-distinctions.md` and use it silently to see what
is still missing.

## What to do

**Find out what you do not have.** Is there a problem behind the request, or only an approach?
Are the stated constraints real? Could anyone but the user tell whether this worked? Ask a few
questions at a time, in ordinary language, and skip what the user already gave you. A request
that is already problem-framed may need almost nothing. When the user asks for the document,
write it: what is still unresolved goes under Open questions, not into more questions first.

**Fill in `${CLAUDE_PLUGIN_ROOT}/reference/intent-template.md`** and write it as `intent.md` in
the project root, or to a path the user gives. The text under each heading is guidance: replace
it. Keep every section exactly as named, in order. Write "None." in an empty one rather than
inventing content.

**Show it and get the user's agreement.** Nothing downstream can be checked against a statement
they never accepted.

**If an `intent.md` already exists**, confirm it is the right one and update it in place.
Changing its Problem or Success changes what the work is for, and affects anything already
checked against the old version. Say so, and make that change only once the user agrees.

## What this document is

About 400 words, readable in two minutes. It is read before work starts and checked against
afterwards, which only works while it stays that short.

It holds **what and why, never how**: no architecture, task list, timeline or tools, except a
constraint the user has called fixed. It is not a spec or a plan. The pressure to grow it will
come from the user, and from you. Resist it. Whatever does not fit belongs in the next document.
