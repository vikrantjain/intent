# intent

A Claude Code plugin for the step before the work: agreeing on what problem is being solved.

Most people brief an agent as an executor. They decide the approach and hand over directions,
which leaves the agent no room to offer a better one. The usual symptom is a requirement that is
really a solution — "add a cron job", "use Postgres" — for a problem that was never stated. The
mismatch surfaces after the thing is built.

## Skills

**`requirement-review`** reviews how you briefed the agent, not what you asked for. It reads
whether a problem was stated or only an approach, whether your constraints are real or
preferences, whether success is defined, and whether anything was left for the agent to decide.
It tells you plainly what your briefing cost you and what would have worked better, then asks
what it needs to reach the actual goal. It writes no files.

**`intent-capture`** produces `intent.md`: the problem, why it matters, what success means, real
constraints, what is out of scope, what is unresolved. About 400 words, same sections every time.
It captures what and why, never how, so it stays readable in two minutes and later work can be
checked against it.

Both are domain-agnostic. Nothing here assumes software.

## Usage

```
/intent:requirement-review
/intent:intent-capture
```

`requirement-review` may also surface itself when a long requirement arrives mid-session, or when
you change direction significantly and name an approach without stating the problem.

## Layout

```
reference/briefing-distinctions.md   the four distinctions both skills work from
reference/intent-template.md         the fixed shape of intent.md
```

The plugin is self-contained. It assumes no other plugin and depends on none.
