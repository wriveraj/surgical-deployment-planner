# Surgical Instrument Deployment Planner
### PostgreSQL · Advanced Allocation · Deployment Readiness · Restock Tracking

A relational database project simulating a surgical instrument and implant deployment operation across six Connecticut hospital sites. Built to demonstrate real-world field inventory planning, Advanced Allocation workflows, inspection-based readiness tracking, and restock flag management using PostgreSQL.

---

## Background

In my current role, I manage field inventory for a medical device division across a Connecticut territory. The core of that work is **Advanced Allocation** — a pre-planning process where implants are assigned to specific surgeons, procedures, and hospitals days before the case. A wrong move or missed allocation is high-risk when it involves a surgical procedure.

This project simulates that exact workflow. The database tracks every stage of the implant lifecycle: deployment to the field, retrieval, integrity inspection, and redeployment — with a 7-day planning window and mandatory 24-hour buffer gaps between cases.

---

## Stack

- **PostgreSQL 15** — relational schema with 8 tables
- **DBeaver** — schema management and query execution
- **Docker Desktop** — containerized database environment

---

## Schema — 8 Tables

| Table | Description |
|---|---|
| `catalog` | 27 items — implants and instruments across Knee, Hip, Shoulder, Elbow, Trauma systems with numeric sizing |
| `locations` | 6 CT hospitals + 1 central warehouse |
| `deployments` | All items currently deployed in the field with status (Active/Overdue) |
| `advanced_allocations` | Pre-planned implant assignments tied to upcoming cases — the core planning table |
| `retrieval_schedule` | When deployed items are being pulled back from the field |
| `integrity_inspections` | Pass / Fail / Pending inspection results per item post-retrieval |
| `restock_flags` | Active Restock Needed flags — consumed, damaged, or failed inspection items |
| `deployment_calendar` | 7-day deployment window with confirmed/planned status and 24-hour buffer gap tracking |

---

## Setup

### Run the database locally
```bash
docker run --name surgical_ops_db \
  -e POSTGRES_USER=william \
  -e POSTGRES_PASSWORD=surgery2026 \
  -e POSTGRES_DB=surgical_ops \
  -p 5433:5432 \
  -d postgres:15
```

### Connect in DBeaver
```
Host:     localhost
Port:     5433
Database: surgical_ops
Username: william
Password: surgery2026
```

### Build the schema and load data
Run in order in DBeaver:
1. `sql/01_schema.sql`
2. `sql/02_seed_data.sql`

---

## Analytical Queries

| File | Query | What It Answers |
|---|---|---|
| `01_advanced_allocation.sql` | Advanced Allocation Plan | Which implants are allocated for the next 7 days, sorted by priority? |
| `02_deployment_readiness.sql` | Deployment Readiness Check | Is each upcoming case Ready, Needs Restock, Inspection Pending, or Not Yet Inspected? |
| `03_active_restock_needed.sql` | Active Restock Needed | What items need to be reordered and why? |
| `04_deployment_calendar.sql` | 7-Day Calendar + Buffer Gap | Is there adequate buffer time between retrieval and the next deployment? |

---

## Key Findings

- **Tibial Baseplate at Hartford General** — failed inspection with a confirmed case on April 15. Highest priority restock.
- **Acetabular Cup at New Britain** — inspection still pending for an April 15 confirmed case. Risk of same-day scramble.
- **Radial Head at Bridgeport** — Urgent case on April 16 with no inspection completed yet.
- **6 items flagged Active Restock Needed** across 4 locations — 3 failed inspection, 2 consumed, 1 damaged.
- **All 15 deployment calendar entries** maintain adequate buffer gaps — no same-day redeployment risk detected.
- **3 Urgent cases and 1 Emergency case** in the 7-day window requiring priority attention.

---

## Data Summary

| Table | Records |
|---|---|
| catalog | 27 |
| locations | 7 |
| deployments | 18 |
| advanced_allocations | 15 |
| retrieval_schedule | 18 |
| integrity_inspections | 13 |
| restock_flags | 6 |
| deployment_calendar | 15 |

---

## Author

**William Rivera Jr**
Field Inventory Manager → Data Analyst
Portfolio: [williamriverajr.com](https://williamriverajr.com)
LinkedIn: [linkedin.com/in/william-rivera-966230309](https://linkedin.com/in/william-rivera-966230309)
GitHub: [github.com/wriveraj](https://github.com/wriveraj)
