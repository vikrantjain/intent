#!/bin/bash
mkdir -p issues

cat > README.md <<'MD'
# renewals

Sends membership renewal reminders from the monthly membership export, and builds the board's
lapse report.

    python send_reminders.py export.csv
    python lapse_report.py export.csv

Needs SMTP settings in `.env`. Open work is in `issues/`.
MD

cat > send_reminders.py <<'PY'
"""Send renewal reminders from the membership export."""
import csv
import datetime
import sys

from mailer import send

REMINDER_DAYS = (30, 7)  # second reminder added in 0.2
RENEW_URL = "https://members.example.org/renew?token={token}"  # skips login, see #14


def due(row, today):
    if row["category"] == "honorary":  # honorary members never expire
        return None
    expires = datetime.date.fromisoformat(row["expires"])
    days = (expires - today).days
    return days if days in REMINDER_DAYS else None


def main(path):
    today = datetime.date.today()
    with open(path) as f:
        for row in csv.DictReader(f):
            days = due(row, today)
            if days is None:
                continue
            # TODO #21: cheque renewals are not in the export until banked
            send(row["email"], "renewal", days=days, link=RENEW_URL.format(token=row["token"]))


if __name__ == "__main__":
    main(sys.argv[1])
PY

cat > lapse_report.py <<'PY'
"""Monthly count of members who did not renew, for the board (#23)."""
import csv
import sys
from collections import Counter

with open(sys.argv[1]) as f:
    lapsed = Counter(r["expires"][:7] for r in csv.DictReader(f) if r["status"] == "lapsed")
for month, count in sorted(lapsed.items()):
    print(month, count)
PY

cat > CHANGELOG.md <<'MD'
# Changelog

## 0.4 (September)
- Monthly lapse report for the board (#23).

## 0.3 (July)
- Renew link goes straight to payment, without logging in (#14).

## 0.2 (May)
- Second reminder, 7 days before expiry. Priya: most lapses are people who simply forget.

## 0.1 (April)
- Email each member 30 days before their membership expires.
MD

cat > issues/014-renew-link-skips-login.md <<'MD'
# #14 Renew link should skip the login page
Status: closed (0.3)

Priya (membership secretary): about half the people who click the renew link never get past the
login screen. Most don't remember their password, give up, and their membership lapses anyway.
MD

cat > issues/019-referral-codes.md <<'MD'
# #19 Referral codes in the reminder email
Status: closed, won't do

Idea: add a "bring a friend" referral code to each reminder. Closed: recruiting new members is
the outreach committee's job, and this project is not taking it on.
MD

cat > issues/021-cheque-renewals-reminded.md <<'MD'
# #21 Members who renewed by cheque still get the 7-day reminder
Status: open, bug

Cheque renewals don't show in the export until they're banked, so these members get a reminder
they don't need. Three complaints in October.
MD

cat > issues/023-monthly-lapse-report.md <<'MD'
# #23 Monthly lapse report
Status: closed (0.4)

The board wants a monthly count of members who didn't renew. Treasurer: we lost about £18k in
dues last year to members not renewing, roughly one in five at renewal time.
MD

cat > issues/025-sms-reminders.md <<'MD'
# #25 SMS reminders
Status: deferred to v2
MD

cat > issues/026-chase-recently-lapsed.md <<'MD'
# #26 Chase members who lapsed in the last six months?
Status: open, needs a decision

Priya thinks we should email recently lapsed members too. The board hasn't decided whether that
is part of this.
MD
