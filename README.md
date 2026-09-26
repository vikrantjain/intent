# intent

A Claude Code plugin for the step before the work: agreeing on what problem is being solved.

Most people brief an agent as an executor. They decide the approach and hand over directions,
which leaves the agent no room to offer a better one. The usual symptom is a requirement that is
really a solution to a problem nobody stated. "Add a cron job" and "use Postgres" are typical.
The mismatch surfaces after the thing is built.

## Skills

**`briefing-review`** reviews how you briefed the agent, not what you asked for. It reads
whether a problem was stated or only an approach, whether your constraints are real or
preferences, whether success is defined, and whether anything was left for the agent to decide.
If the work already has an `intent.md`, it also checks whether your request departs from it.
It tells you plainly and politely what a different briefing would get you. Then it asks what it
needs to reach the actual goal. It writes no files.

**`capture`** produces or updates `intent.md`: the problem, why it matters, what success means,
real constraints, what is out of scope, what is unresolved. About 400 words, same sections every
time. It captures what and why, never how, so it stays readable in two minutes and later work
can be checked against it. It will not change the problem or success of an existing `intent.md`
until you agree.

Both are domain-agnostic. Nothing here assumes software.

## Usage

```
/intent:briefing-review
/intent:capture
```

`briefing-review` may also start on its own when a long requirement arrives mid-session, or when
you change direction significantly and name an approach without stating the problem. When it
does, it offers a review in one sentence and carries on if you decline.

## Layout

```
reference/briefing-distinctions.md   the four distinctions both skills work from
reference/intent-template.md         the fixed shape of intent.md
evals/                               eval suite for claude plugin eval (see evals/README.md)
```

The plugin is self-contained. It assumes no other plugin and depends on none.
