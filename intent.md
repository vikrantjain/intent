# Intent: Intent Plugin

## Problem
Many people treat an AI agent as an executor that follows orders rather than as a peer to think with. They decide the approach themselves and hand over directions, leaving no room for the agent's knowledge to suggest a better one. The visible symptom is a requirement that is really a solution ("add a cron job", "use Postgres", "build an agent to talk to project X over A2A") for a problem that was never stated. The agent builds what it was told. The result misses the real need, and the mismatch is usually found late.

## Desired outcome
Users brief the agent as a collaborator: they state the problem, the context and what success means, and they invite the agent's ideas and pushback. Two things get them there. They are shown, plainly and politely, when a request dictated a solution instead of stating a problem. And before significant work begins, they and the agent agree on a short, explicit statement of what problem is being solved, why it matters, and how success will be recognized.

## Who it is for
Anyone briefing an AI agent on non-trivial work, in any domain: software, writing, research, operations, events, learning. It is not specific to developers.

## What the plugin provides
1. **Requirement review.** Its subject is the briefing, not the request's content. It reads how the user handed the work over: whether a problem was stated or only an approach, whether the constraints are real or preferences presented as given, whether success is defined, whether any room was left for the agent to propose something different. It names what it finds, says what a better brief would have given them, and asks what is needed to reach the underlying goal.
2. **Intent capture.** Its subject is the problem. It asks what it needs, then writes or updates a single `intent.md`.

## Success looks like
- Later work, whether specs, plans, drafts or deliverables, can be checked against `intent.md`.
- A vague or solution-shaped request becomes a confirmed problem statement within a few minutes of conversation.
- `intent.md` reads in under two minutes and has the same structure every time.
- Users change how they open a task, because they were told what their briefing cost them.
- Users do not feel interrogated or lectured.

## Constraints
- **`intent.md` is fixed in length and structure.** Same sections every time, about 400 words. It must never grow into a spec or a plan.
- **It captures what and why, never how.** No architecture, task lists, timelines or implementation choices, except where the user states one as a hard constraint.
- **It is domain-agnostic.** Questions and wording must work equally well outside software.
- **The format is stable and documented.** Other work will read `intent.md`, so its structure must not drift.
- **The guidance stays at principle level.** The skills give the agent the distinctions that matter and the judgment to apply them. They do not enumerate scenarios or prescribe responses per situation, which would leave the agent stuck on anything unlisted.
- **Review names the pattern once, politely.** It states what the briefing did and what would work better, without building a case. A user who says they have already thought it through proceeds unchallenged.
- **Capture does not coach.** Its questions are woven into the conversation, never framed as a critique of the request.
- **The plugin is self-contained.** It assumes no other plugin and depends on none.

## Out of scope
- Writing specs, plans or task breakdowns.
- Any software-specific tooling or assumptions.

## Assumptions to confirm
- Review and capture are separate skills, sharing a set of distinctions rather than one invoking the other.
- Review is invoked by the user, and may also surface itself on a large or solution-shaped request that arrives mid-session. When it surfaces itself it opens with a brief offer, not an interview.
- The sections of this document are a reasonable starting template for `intent.md`.
- Capture may skip the review questions when the request is already problem-framed.
- `intent.md` is written to the project root, or to a path the user gives.
- Clarifying questions are asked a few at a time.
