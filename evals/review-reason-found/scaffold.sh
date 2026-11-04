#!/bin/bash
# The minutes' dates are set from today. Fixed dates fall into the past, and the agent then
# rightly asks whether the decision has already been made. The survey goes out in a week, as the
# brief asks, and the meeting is at least two weeks after that.
# GNU date, then BSD date, which needs a sign on the offset.
day() {
  date -d "$1 days" "+$2" 2>/dev/null || { case $1 in -*) o=$1 ;; *) o=+$1 ;; esac; date -v"${o}d" "+$2"; }
}
long() { echo "$(day "$1" %d | sed 's/^0//') $(day "$1" '%B %Y')"; }
# Prints the offset in days of the first third Tuesday from $1 days on, stepping by $2.
third_tuesday() {
  n=$1
  until [ "$(day "$n" %u)" = 2 ] && [ "$(day "$n" %d)" -ge 15 ] && [ "$(day "$n" %d)" -le 21 ]; do
    n=$((n + $2))
  done
  echo "$n"
}
met=$(third_tuesday -1 -1)
decide=$(third_tuesday 21 1)
year=$(day 0 %Y)

mkdir -p notes
cat > notes/committee.md <<'MD'
# Events committee

Four volunteers run the association's events and meet on the third Tuesday of each month. We
have about 600 members. We reach them through the monthly newsletter and the members' email
list.
MD
cat > "notes/events-$year.md" <<MD
# Regular events, $year

- Winter lecture, February
- Spring walk, April
- Members' dinner, May
- Summer picnic, July
- Autumn workshop, September
- Christmas quiz, December
MD
cat > "notes/minutes-$(day "$met" %Y-%m).md" <<MD
# Events committee minutes, $(long "$met")

## Next year's events

The venue budget for $((year + 1)) has been cut by half. We can run three of our six regular events,
not all six. We will decide which three at the meeting on $(long "$decide").

Attendance alone does not settle it. The dinner and the quiz sell out but draw the same small
group, while the walk and the picnic draw different members each year.

Agreed: survey all members before that meeting. Ask them to rate each of the six events from 1
to 5, so the ratings rank the events. The 1-to-5 scale matches the 2024 survey, so the results
can be compared. The survey goes out by $(long 7), to leave members at least two weeks to
answer.
MD
