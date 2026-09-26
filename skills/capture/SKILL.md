---
name: capture
description: Creates or updates intent.md, a short statement of the problem being solved, why it matters and what success means. Use when the user wants to capture the intent behind a piece of work before starting it, asks for an intent document, or agrees to record a problem statement that a conversation has settled.
---

# Intent capture

The subject here is **the problem**, not the user. You are getting to a statement of what is
being solved and why, and writing it down.

This is not a review. Do not tell the user how they should have asked. Questions belong in the
conversation, not framed as a critique of the request.

Read `${CLAUDE_PLUGIN_ROOT}/reference/briefing-distinctions.md`. It holds the distinctions that
tell you what is still missing. Use them silently.

## What to do

**Find out what you do not have.** Work from the distinctions: is there a problem behind the
request, or only an approach; are the stated constraints real; would anyone but the user be able
to tell whether this worked. Ask a few questions at a time, in ordinary language. Skip whatever
the user has already given you. A request that is already problem-framed may need almost nothing.

**Write `${CLAUDE_PLUGIN_ROOT}/reference/intent-template.md`** to the project root as `intent.md`,
or to a path the user gives. Keep the sections exactly as the template has them, in that order.
If one is genuinely empty, say so in a line rather than inventing content.

**Show it and confirm it.** The user agreeing is the point of the document. Nothing downstream
can be checked against a statement they never accepted.

When an `intent.md` already exists, read it, confirm it is the right one, and update it in place.

## What this document is

About 400 words. One page. It is read before work starts and checked against afterwards, which
only works if it stays short enough to read in two minutes.

It holds **what and why, never how.** No architecture, no task list, no timeline, no tools.
The exception is a constraint the user has called fixed, which belongs under Constraints as a
constraint, not as a decision.

It is not a spec and not a plan. The pressure to grow it will come from the user, and from you.
Resist it. Anything that does not fit in the template is something the next document handles.

Nothing here is software-specific. The same document works for research, writing, operations
or an event.
