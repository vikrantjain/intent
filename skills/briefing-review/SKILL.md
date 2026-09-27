---
name: briefing-review
description: Reviews how the user briefed the agent, not what they asked for. Use when the user asks for feedback on how they framed a request or assigned a task.
---

# Briefing review

The subject is **the briefing, not the request**. You are not judging whether the plan is good.
You are reading how the work was handed over, and showing the user how a different way of
handing it over would get them a better result.

Most people brief an agent as an executor: they decide the approach and pass down directions.
That closes off everything the agent might have contributed, and the mismatch usually surfaces
after the work is built. The aim is that the user sees it before then, and gradually opens tasks
differently.

**Before you respond**, read `${CLAUDE_PLUGIN_ROOT}/reference/briefing-distinctions.md` and read
the request against it. Then look for `intent.md` in the project root, or at the location the
user specified for it, and read it if it exists. A request that departs from its Problem or
Success is a change of intent, and that comes first in whatever you say. Last, search the user's
own records, wherever you can reach them, for the reasoning behind any approach the request
names. Reasoning you find there counts as given.

The user asked for this review, so give it, however small the request and however often they
ask. They want to know how they briefed.

## The review

**Say what the briefing did, once, plainly and politely.** A named solution is not itself a
fault. Users are often right. What matters is whether the reasoning exists. In a sentence or two,
in the user's own terms, say what the briefing did. Then say what a different brief would get
them. Frame it as what they gain, not what they did wrong. All of it fits in a few sentences, as
in this example:

> You have told me to use Postgres. I do not know what the data looks like or how it gets read,
> so I cannot tell you whether that is the right call. If you tell me what the data is and how
> it gets read, I can say whether Postgres fits or suggest something better. If you have already
> chosen it, tell me why. The reason helps me fit the rest of the solution around it.

A better brief states the problem, gives the context around it, and leaves room for the agent to
propose alternatives and push back. Point the user toward whichever of those theirs lacked.

Do not build a case or list every flaw. Do not soften it into nothing either: a review that only
asks questions has told the user nothing about how they work.

**Then ask what you need** to recover the real goal, a few questions at a time. When you could
restate the problem in a form the user would accept, restate it and let them correct it.

## Afterwards

A user who says they have already thought it through has ended the review. Take them at their
word, and do not raise it again this session. Do not repeat a diagnosis on later requests unless
they ask: once said, the user knows.

If the conversation settled a problem statement worth keeping, offer to capture it, or to update
an existing `intent.md`. This skill writes no files.
