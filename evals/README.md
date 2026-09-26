# Evals

Cases for `claude plugin eval`. Each case directory holds a `case.yaml`. Some also hold a
`history.jsonl` or a `scaffold.sh`.

## What the suite checks

`review-explicit-*` and `review-intent-departure` invoke the review directly. They check that it
names what the brief did and what a different brief would get. They also check that it does not
judge the plan, and that it does not invent faults in a brief that is already problem-framed.

`review-quiet-*` and `review-declined` resume a conversation already under way, and never ask for
a review. They check that the review stays quiet for a small request, and for a long request that
states its problem. They also check that it stays quiet after the user has said they already
thought it through.

`capture-*` check that capture asks before writing when there is nothing to write, and that it
writes the fixed sections with no solution in them. They also check that it will not change the
Problem of an existing `intent.md` without agreement.

## Running

    CLAUDE_CODE_EFFORT_LEVEL=medium claude plugin eval . \
      --model sonnet --judge-model sonnet --scaffold --allow-tools Write Edit

Run it from the plugin root. Run it again with `--model opus` for the second target.

- **`CLAUDE_CODE_EFFORT_LEVEL=medium`**: the target is Sonnet at medium effort and above. A case
  file cannot set effort, so it comes from the shell.
- **`--judge-model sonnet`**: the default Haiku judge is too loose on criteria about tone and
  framing.
- **`--scaffold`**: two cases start from an existing `intent.md`, which their `scaffold.sh` writes.
- **`--allow-tools Write Edit`**: capture writes `intent.md`.

Cases that invoke a skill directly also run without the plugin, and the report gives the
difference. Cases that resume a conversation run with the plugin only.

## Histories

`histories/turns.json` holds the prior turns of the mid-session cases. `histories/build.py`
writes each case's `history.jsonl` from it. Run it after changing a skill, because the
`review-declined` history carries the text of `briefing-review` as it was loaded.
