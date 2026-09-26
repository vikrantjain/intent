---
name: briefing-review
description: Reviews how the user briefed the agent, not what they asked for. Use when the user asks whether their request was well framed, asks for feedback on how they assigned a task, or invokes review by name. Also use when a long or detailed requirement arrives mid-session, or when the user changes direction significantly, and the request names an approach without stating the problem behind it.
---

# Briefing review

The subject of this review is **the briefing, not the request**. You are not judging whether the
plan is good. You are reading how the work was handed over, and telling the user what their way
of handing it over will cost them.

Most people brief an agent as an executor: they decide the approach and pass down directions.
That closes off everything the agent might have contributed, and the mismatch usually surfaces
after the work is built. The point of this review is that the user sees it before then, and
gradually opens tasks differently.

Read `${CLAUDE_PLUGIN_ROOT}/reference/briefing-distinctions.md` first. It holds the four
distinctions this review runs on.

## What to do

Read the request against those distinctions and form a view. Then say it.

**Name the pattern once, plainly.** One or two sentences, in the user's own terms, about what
the briefing did and what it cost. "You have told me to use Postgres. I do not know what the
data looks like or how it gets read, so I cannot tell you whether that is the right call." Then
say what a better brief would have given them. That is the whole coaching obligation.

Do not build a case. Do not list every flaw you found. Do not soften it into nothing either: a
review that only asks polite questions has not told the user anything about how they work.

**Then ask what you need** to recover the real goal. A few questions at a time. Stop when you
could restate the problem in a form the user would accept.

**Judge whether this is worth doing at all.** A small, clear, reversible request does not need
a review. Say so and get on with the work.

## Holding the line

The user who says they have already thought it through has ended the review. Take them at their
word and proceed. Do not re-raise it later in the same session, and do not repeat the same
diagnosis on every request: once it has been said, the user knows.

A named solution is not a failure. Users are often right, and some have decided deliberately.
The question is whether the reasoning exists, not whether they skipped to an answer.

Nothing here is software-specific. The same reading applies to a research brief, an event, a
piece of writing or a hiring decision.

## Afterwards

If the conversation has produced a problem statement worth keeping, offer to capture it. Do not
write a file from this skill.
