# Case Study: Store Fixture Deployment Planner

> **Synthetic data.** All stores, reset leads, fixtures, and quantities in this project are fabricated for demonstration. Store and reset lead identifiers are coded and correspond to no real retailer, location, or person. No proprietary or employer data is used.

**Tools:** PostgreSQL · Docker · DBeaver · Power BI · HTML/CSS
**GitHub:** [github.com/wriveraj/surgical-deployment-planner](https://github.com/wriveraj/surgical-deployment-planner)

---

## The Problem

Store resets run on a calendar. Each one needs specific fixtures at a specific store on a specific day, and most of those fixtures are reusable: they come back to the distribution center, get inspected, and go out again. When a fixture is still at another store, failed inspection, or was never checked, the reset crew shows up without what it needs.

That tracking usually lives in spreadsheets and email. I wanted a database that organizes it properly and surfaces the right problem before the reset date, not on it.

---

## What I Built

A PostgreSQL database running in Docker that simulates fixture deployment across six stores and one DC. The schema has 8 tables covering the full fixture lifecycle:

| Table | Purpose |
|---|---|
| catalog | 27 fixtures and install kits across Endcap, Gondola, Checkout, Seasonal, and Pallet families |
| locations | 6 stores + 1 central distribution center |
| deployments | What is currently out and where |
| pre_allocations | Fixtures assigned to upcoming resets |
| retrieval_schedule | When deployed fixtures come back |
| fixture_inspections | Pass / Fail / Pending results after retrieval |
| restock_flags | Items flagged Active Restock Needed |
| deployment_calendar | 7-day planning window with a 24-hour buffer check |

---

## The Analytical Queries

Four queries mirror the decisions a planner makes every day:

**1. Pre-Allocation Plan**
Every fixture assigned to a reset in the 7-day window, rush jobs first. It joins allocations to the catalog and stores so you can see at a glance what each reset depends on.

**2. Deployment Readiness**
Classifies every scheduled fixture as Ready, Needs Restock, Inspection Pending, or Not Yet Inspected. This is the most important view: it says what can actually go out tomorrow.

**3. Active Restock Needed**
All fixtures flagged for replacement, with store, reason (consumed, damaged, or failed inspection) and date flagged. Six items surfaced across four stores in the sample data.

**4. 7-Day Deployment Calendar**
Every scheduled deployment with its buffer status, flagging any fixture going back out less than 24 hours after it returns. All 15 entries cleared the check.

---

## What the Data Surfaced

Even with sample data, the queries produced the findings a planner needs:

- **Endcap Base Deck at STORE-01** failed inspection with a confirmed reset on April 15. No time left to wait on it.
- **Gondola Header Sign at STORE-02** is still pending inspection for an April 15 reset. Readiness unknown.
- **Seasonal Display Tower at STORE-04** has a priority reset on April 16 and no inspection record at all.

These are exactly the gaps that get missed when tracking lives in a spreadsheet.

---

## The Dashboard

The Power BI dashboard puts the four query outputs on one screen: readiness by store, restock flags by reason, the allocation timeline, and buffer status for the week.

I also built an interactive HTML dashboard as a standalone portfolio piece, so the core views open in any browser without Power BI.

---

## Why I Built This

I have spent years in distribution and field inventory, where the call always comes the morning of: where is the piece we need, and is it good to go? This project is my answer to that call, built so the answer is ready the day before.

The database does not replace a planner's judgment. It gives that judgment better information to work with.
