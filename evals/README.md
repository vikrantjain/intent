# Evals

Cases for `claude plugin eval`. Each case directory holds a `case.yaml`. Some also hold a
`history.jsonl` or a `scaffold.sh`.

## What the suite checks

`review-explicit-*` and `review-intent-departure` invoke the review directly. They check that it
names what the brief did and what a different brief would get. They also check that it does not
judge the plan, and that it does not invent faults in a brief that is already problem-framed.

`review-reason-found` and `review-explicit-nonsoftware` give the same brief, a member survey, in a
folder of the user's notes. In `review-reason-found`, meeting minutes record what the survey is
for, and the review should find and credit that reason. In `review-explicit-nonsoftware`, the
notes give no reason. There the review should name the gap and not invent a reason to fill it.

Three cases dictate a solution and each tests a different distinction.
`review-explicit-agents-mandate` mandates department AI agents over A2A. Its only reasons are
that competitors are building agents and that answers should come quickly. The review should
treat these as reasons to act, not as the problem the agents would solve.
`review-explicit-architecture` fixes a whole architecture and asks only for the write-up. The
review should name the room it closes off. `review-explicit-stack` dictates DynamoDB and SNS for
a todos app and says nothing about what the app is for. The review should ask about its purpose
rather than assume one. `review-explicit-solution-reasoned` is their control. It names a solution
and states the problem and constraint behind it, so the review should credit the reasoning and
claim no gap that is not there.

`review-selfstart-*` never ask for a review. Each gives a request that names an approach but not
the problem behind it. The review should start on its own, name what the brief left out, and
write no files. `review-selfstart-first` is a session's first message. `review-selfstart-solution`
resumes a conversation already under way. The plugin's hook denies the first writes after each
prompt, and a denied Write still counts as a call. So these cases check that the working directory
is unchanged, not that Write was never called.

`review-quiet-*` and `review-declined` resume a conversation already under way, and never ask for
a review. They check that the review stays quiet for a small request, and for a long request that
states its problem. They also check that it stays quiet after the user has said they already
thought it through. `review-quiet-write` asks for a small file write. The hook denies the first
write, and the agent should write again without a review.

The hook's plan-mode trigger has no case, because a case cannot start in plan mode.

`capture-*` check that capture asks before writing when there is nothing to write, and that it
writes the fixed sections with no solution in them. They also check that it will not change the
Problem of an existing `intent.md` without agreement.

## Running

    CLAUDE_CODE_EFFORT_LEVEL=medium claude plugin eval . \
      --model sonnet --judge-model sonnet --scaffold --allow-tools Write Edit

Run it from the plugin root. Run it again with `--model opus` for the second target.

- **`CLAUDE_CODE_EFFORT_LEVEL=medium`**: the target is Sonnet at medium effort and above. A case
  file cannot set effort, so it comes from the shell.
- **`--judge-model sonnet`**: the default judge is Haiku. The eval authoring guide recommends a
  Sonnet-tier judge for criteria like these, and every recorded run used one.
- **`--scaffold`**: some cases start from files that their `scaffold.sh` writes: an existing
  `intent.md`, or the user's notes.
- **`--allow-tools Write Edit`**: capture writes `intent.md`.

Cases that invoke a skill directly also run without the plugin, and the report gives the
difference. Cases that resume a conversation run with the plugin only.

A full run at 3 runs per case cost about $6.50 on Sonnet and $10 on Opus. Both models together
have hit the account's usage limit mid-run, and runs past the limit fail with an error instead of
a score. Run the two models at different times, or filter with `--case` or `--tag`. `--case`
takes one glob, such as `'review-explicit-*'`. Given twice, it keeps only the last.

## Reading results

A grader's result gives the judge's votes, not its reasoning. To see why a case failed, rerun it
with `--keep-temp`. The results JSON then gives each run's `tracePath`, and the reply is in the
trace's assistant text.

The judge sees only the final reply. It does not see the brief or the user's files. A criterion
must state the facts it judges against, or the judge guesses them and can fail a correct reply.

## Histories

`histories/turns.json` holds the prior turns of the mid-session cases. `histories/build.py`
writes each case's `history.jsonl` from it. Run it after changing a skill, because the
`review-declined` history carries the text of `briefing-review` as it was loaded.
