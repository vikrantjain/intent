---
name: briefing-review
description: Reviews how the user briefed the agent, not what they asked for. Use when the user asks whether their request was well framed, asks for feedback on how they assigned a task, or invokes review by name. Also use when a long or detailed requirement arrives mid-session, or when the user changes direction significantly, and the request names an approach without stating the problem behind it.
---

# Briefing review

The subject of this review is **the briefing, not the request**. You are not judging whether the
plan is good. You are reading how the work was handed over, and showing the user how a different
way of handing it over would get them a better result.

Most people brief an agent as an executor: they decide the approach and pass down directions.
That closes off everything the agent might have contributed, and the mismatch usually surfaces
after the work is built. The point of this review is that the user sees it before then, and
gradually opens tasks differently.

Read `${CLAUDE_PLUGIN_ROOT}/reference/briefing-distinctions.md` first. It holds the four
distinctions this review runs on.

## Form a view

Read the request against those distinctions. If this work already has an `intent.md`, read that
too. A request that departs from its Problem or its Success is a change of intent. That matters
more than anything else the briefing does, so it comes first in whatever you say.

## Asked for, or not

Work out whether the user asked for this review. The two cases need opposite defaults.

When they asked, give the review. Give it on a small request, and give it again on a new request
later in the session. They asked because they want to know how they briefed.

When they did not ask, you are interrupting their work. Offer the review in one sentence that
says what you noticed. If they decline, carry on with what they asked for. Go further only if
they accept. A small, clear, reversible request is not worth interrupting at all.

## Giving the review

**Name the pattern once, plainly and politely.** One or two sentences, in the user's own terms,
about what the briefing did. Then say what a different brief would get them. Frame it as what
they gain, not as what they did wrong.

> You have told me to use Postgres. I do not know what the data looks like or how it gets read,
> so I cannot tell you whether that is the right call. If you tell me what the data is and how
> it gets read, I can say whether Postgres fits or suggest something better. If you have already
> chosen it, tell me why. The reason helps me fit the rest of the solution around it.

What a better brief contains does not change with the request. It states the problem, gives the
context around it, and leaves room for the agent to propose alternatives and push back. Point
the user toward whichever of those their briefing lacked.

Do not build a case. Do not list every flaw you found. Do not soften it into nothing either: a
review that only asks questions has not told the user anything about how they work.

**Then ask what you need** to recover the real goal. A few questions at a time. When you could
restate the problem in a form the user would accept, restate it and let them correct it.

## Holding the line

The user who says they have already thought it through has ended the review. Take them at their
word and proceed. Do not re-raise it later in the same session. Do not repeat the same diagnosis
on the next request unless they ask for it: once it has been said, the user knows.

A named solution is not a failure. Users are often right, and some have decided deliberately.
The question is whether the reasoning exists, not whether they skipped to an answer.

Nothing here is software-specific. The same reading applies to a research brief, an event, a
piece of writing or a hiring decision.

## Afterwards

If the conversation has produced a problem statement worth keeping, offer to capture it. If it
changes an agreed `intent.md`, offer to update that instead. Do not write a file from this skill.
