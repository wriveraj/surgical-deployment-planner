# Case Study: Surgical Instrument Deployment Planner

> **Synthetic data.** All sites, surgeons, procedures, quantities, and cost figures in this project are fabricated for demonstration. Site and surgeon identifiers are coded and correspond to no real facility, practitioner, or organization. No proprietary or employer data is used.


**Tools:** PostgreSQL · Docker · DBeaver · Power BI · HTML/CSS  
**GitHub:** [github.com/wriveraj/surgical-deployment-planner](https://github.com/wriveraj/surgical-deployment-planner)

---

## The Problem

Advanced Allocation pre-assigns implants to surgeons at specific hospitals before surgery. Success depends on tracking field inventory, returns, inspection status, and restocking needs.

Most of that tracking happens by capturing live data on demand and usage with RFID coming soon, tracking location will hopefully help curb lost inventory. I wanted to build a database that organizes it properly, one that surfaces the right information at the right time.

---

## What I Built

A PostgreSQL relational database running in Docker, simulating a surgical implant deployment operation across six hospital sites. The schema has 8 tables covering the full implant lifecycle:

| Table | Purpose |
|---|---|
| catalog | 27 implants and instruments across Knee, Hip, Shoulder, Elbow, and Trauma |
| locations | 6 hospital sites + 1 central warehouse |
| deployments | Active field inventory, what is currently deployed and where |
| dvanced_allocations | Pre-planned implant assignments tied to upcoming cases |
| 
etrieval_schedule | When deployed items are being pulled back |
| integrity_inspections | Pass / Fail / Pending results per item post-retrieval |
| 
estock_flags | Items flagged as Active Restock Needed |
| deployment_calendar | 7-day planning window with 24-hour buffer gap enforcement |

---

## The Analytical Queries

I wrote four queries that mirror the actual decisions a field rep makes every day:

**1. Advanced Allocation View**  
Surfaces all implants pre-assigned to upcoming cases within a 7-day window, sorted by urgency. The query joins allocations to catalog, location, and inspection status so you can see at a glance whether an allocated item is ready to deploy or flagged.

**2. Deployment Readiness**  
Classifies every deployed item as one of four states: Ready, Needs Restock, Inspection Pending, or Not Yet Inspected. This is the single most important operational view, it tells you what you can actually put in front of a surgeon tomorrow.

**3. Active Restock Needed**  
Returns all items currently flagged for restock, with location, reason (consumed, damaged, or failed inspection), and the date flagged. Six items surfaced across four locations in the seed data.

**4. 7-Day Deployment Calendar**  
Shows every scheduled deployment in the planning window with buffer gap status, flagging any case where the 24-hour minimum gap between procedures has not been met. All 15 entries in the seed data cleared the buffer check.

---

## What the Data Surfaced

Even with simulated seed data, the queries produced real findings:

- **Tibial Baseplate at SITE-01** failed integrity inspection with a confirmed Advanced Allocation on April 15. Zero days to act.
- **Acetabular Cup at SITE-02** inspection result still pending for an April 15 case. Unknown readiness.
- **Radial Head at SITE-04** urgent April 16 case with no inspection record at all. Not even in the queue.

These are exactly the scenarios that get missed when tracking lives in a spreadsheet.

---

## The Dashboard

The Power BI dashboard visualizes the four query outputs in a single-screen operational view, deployment readiness by location, restock flags by reason, allocation timeline, and buffer gap status for the planning week.

I also built an interactive HTML dashboard as a standalone portfolio artifact, replicating the core views in a browser-renderable format without requiring Power BI to view it.

---

## Why I Built This

I have worked this territory. I know what it feels like to get a call the morning of a case asking where a specific implant is and to not have a fast, reliable answer. This project is me building the answer.

The database does not replace the judgment of a field rep. It gives that judgment better information to work with.
