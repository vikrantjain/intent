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
time. It asks only what it needs for a draft, and puts the rest under Open questions. It
captures what and why, never how, so it stays readable in two minutes and later work can be
checked against it. It will not change the problem or success of an existing `intent.md`
until you agree.

Both are domain-agnostic. Nothing here assumes software. Tested on Opus and Sonnet at medium
effort.

## Install

### From this repo

This repo is its own plugin marketplace, so it installs with nothing set up on your side:

```
/plugin marketplace add vikrantjain/intent
/plugin install intent@intent
```

`intent@intent` is `<plugin>@<marketplace>`. You add the repo, which registers under the
marketplace name `intent`, and it holds the plugin of the same name.

### From your own marketplace

If you keep a marketplace of your own, add this entry to the `plugins` list in its
`.claude-plugin/marketplace.json`:

```json
{
  "name": "intent",
  "source": { "source": "github", "repo": "vikrantjain/intent" }
}
```

Push the change, then refresh the marketplace and install from it:

```
/plugin marketplace update <your-marketplace>
/plugin install intent@<your-marketplace>
```

## Usage

```
/intent:briefing-review
/intent:capture
```

`briefing-review` runs when you ask for it. It does not start on its own: in evals it never
triggered unasked.

## Layout

```
reference/briefing-distinctions.md   the four distinctions both skills work from
reference/intent-template.md         the fixed shape of intent.md
evals/                               eval suite for claude plugin eval (see evals/README.md)
```

The plugin is self-contained. It assumes no other plugin and depends on none.
