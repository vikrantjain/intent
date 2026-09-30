# intent

A Claude Code plugin for the step before the work: agreeing on what problem is being solved.

Most people brief an agent as an executor. They decide the approach and hand over directions.
That leaves the agent no room to offer a better approach. The usual symptom is a requirement that
is really a solution to a problem nobody stated. "Add a cron job" and "use Postgres" are typical.
The mismatch surfaces after the thing is built.

The argument behind it is in
[Your AI Agent Will Carry Out a Weak Plan Very Well](https://vikrantjain.dev/collaborate-with-your-ai-agent/).

## Skills

**`briefing-review`** reviews how you briefed the agent, not what you asked for. It reads
whether a problem was stated or only an approach, whether your constraints are real or
preferences, whether success is defined, and whether anything was left for the agent to decide.
If the work already has an `intent.md`, it also checks whether your request departs from it.
Naming an approach is not a fault in itself. A brief that gives its reasons gets credit for them.
It tells you plainly and politely what a different briefing would get you. Then it asks what it
needs to reach the actual goal. It writes no files.

**`capture`** writes or updates `intent.md`, in the project root or at a location you specify.
The file states the problem, why it matters, what success means, the real constraints, what is
out of scope and what is unresolved. It has the same six sections every time. It runs to about
400 words, so it reads in two minutes. It holds what and why, never how. Capture asks only what
it needs for a draft, and puts the rest under Open questions. It shows you the draft and asks you
to confirm it. It will not change the problem or success of an existing `intent.md` until you
agree.

The skills work together. You brief the agent, and the review shows what the brief left out. Once
the problem is settled, the review offers to capture it. Either skill also runs on its own.

The plugin does not check later work against `intent.md`. The file is there for you, and for any
tool you point at it. Within the plugin, only the review reads it, to spot a request that departs
from it.

Both skills are domain-agnostic. Nothing here assumes software.

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

If the commands do not appear after installing, run `/reload-plugins`.

## Usage

The review also starts on its own when a request names an approach but not the problem behind
it. The agent is asked to check at three points: the start of a session, a prompt sent in plan
mode, and the first file write after each prompt. At that first write, the plugin refuses the
write once and gives the check as the reason. You will see one refused write per prompt. If the
brief states its problem, the agent writes again and carries on. This is new and still being
tuned. In tests on Opus, the review started on a session's first message every time, and
mid-session in 2 of 6 runs. The check at session start is missed if you install or update the
plugin mid-session. Run `/clear` or start a new session to get it.

To ask for a review, pass the brief as the argument:

```
/intent:briefing-review Use Postgres for our event data and set up the schema.
```

A review opens along these lines:

> You have told me to use Postgres. I do not know what the data looks like or how it gets read,
> so I cannot tell you whether that is the right call. If you tell me what the data is and how it
> gets read, I can say whether Postgres fits or suggest something better. If you have already
> chosen it, tell me why.

Then it asks a few questions to get to the real goal. To end a review, say you have already
thought it through. The review will not raise it again that session.

Asking in plain words for feedback on how you framed a request can also start a review. The
command is the reliable route.

To write down the problem before starting work, describe it to capture:

```
/intent:capture Volunteers keep missing Saturday shifts, and the coordinator spends Friday evenings phoning round to fill them.
```

## Models

The plugin works best on Opus. It is also tested on Sonnet at medium effort. There the review
does not search your records for the reasoning behind a request. It may ask for a reason you
have already written down. Capture is also less reliable on Sonnet. It sometimes asks more
before writing, and sometimes comments on how you phrased the request.

## Developing

```
skills/briefing-review/SKILL.md      the review
skills/capture/SKILL.md              capture
reference/briefing-distinctions.md   the four distinctions both skills work from
reference/intent-template.md         the fixed shape of intent.md
hooks/trigger.md                     the instruction that starts the review unasked
hooks/hooks.json                     when it is given: session start, plan mode, first write
hooks/first-write.sh                 refuses the first writes after each prompt, once
docs/design-notes.md                 the problem the plugin solves, and the decisions behind it
evals/                               eval suite for claude plugin eval (see evals/README.md)
```

The plugin is self-contained. It assumes no other plugin and depends on none.

## License

MIT. See `LICENSE`.
