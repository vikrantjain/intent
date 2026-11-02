#!/bin/bash
mkdir -p notes
cat > notes/status.md <<'MD'
# Saturday shift project: status, 2 November

## Background

Volunteers sign up for food bank shifts through a shared spreadsheet. About a third of Saturday
shifts were ending up short-staffed, because people forget or drop out without telling anyone.
Weekday shifts have the same problem, less often. Diane, the coordinator, was spending Friday
evenings phoning round to fill gaps, and said in August she would step down if it carried on.
Short shifts mean we serve fewer families on our busiest day.

Goal agreed with the board: shifts fully staffed at least 90% of the time, and Diane's Friday
calls down to under 30 minutes.

There is no budget for paid software this year.

## Done

- Text reminders go out 48 hours and 4 hours before each Saturday shift, sent from the spreadsheet.
- Volunteers can reply DROP to free their slot, and Diane gets an alert.
- Since launch, 81% of Saturday shifts have been fully staffed.

## Open issues

- Some volunteers get each reminder twice. Fix is next.
- After the clock change last week, the 4-hour reminder went out an hour late.
- Diane's alert list does not update until she reloads the page.

## Out of scope for now

- Weekday shifts. Phase 2, after Christmas.
- Shift swapping by text. Deferred to v2.
- Recruiting new volunteers. The board runs that separately.
MD
