-- ============================================================
-- STORE FIXTURE DEPLOYMENT PLANNER
-- Schema: store_ops
-- Author: William Rivera Jr
-- Description: Tracks reusable display fixtures and install kits
--              deployed from a distribution center to stores for
--              planned resets: pre-allocation, retrieval,
--              inspection, restock flags, and a 7-day calendar.
-- ============================================================

DROP SCHEMA IF EXISTS store_ops CASCADE;
CREATE SCHEMA store_ops;

-- 1. CATALOG: display fixtures and the install kits that set them
CREATE TABLE store_ops.catalog (
    item_id         SERIAL PRIMARY KEY,
    item_name       VARCHAR(150) NOT NULL,
    item_type       VARCHAR(50)  NOT NULL,   -- Fixture, Install Kit
    fixture_family  VARCHAR(50)  NOT NULL,   -- Endcap, Gondola, Checkout, Seasonal, Pallet
    size            INT          NOT NULL    -- size class within the family
);

-- 2. LOCATIONS: stores and the central distribution center
CREATE TABLE store_ops.locations (
    location_id     SERIAL PRIMARY KEY,
    location_name   VARCHAR(50)  NOT NULL,
    location_type   VARCHAR(50)  NOT NULL,   -- Store, Warehouse
    city            VARCHAR(100) NOT NULL,
    state           CHAR(2)      NOT NULL
);

-- 3. DEPLOYMENTS: fixtures currently out at stores
CREATE TABLE store_ops.deployments (
    deployment_id   SERIAL PRIMARY KEY,
    item_id         INT  NOT NULL REFERENCES store_ops.catalog(item_id),
    location_id     INT  NOT NULL REFERENCES store_ops.locations(location_id),
    quantity        INT  NOT NULL,
    deployed_date   DATE NOT NULL,
    expected_return DATE NOT NULL,
    status          VARCHAR(30) NOT NULL     -- Active, Overdue
);

-- 4. PRE-ALLOCATIONS: fixtures assigned to upcoming store resets
CREATE TABLE store_ops.pre_allocations (
    allocation_id   SERIAL PRIMARY KEY,
    item_id         INT  NOT NULL REFERENCES store_ops.catalog(item_id),
    location_id     INT  NOT NULL REFERENCES store_ops.locations(location_id),
    reset_date      DATE NOT NULL,
    reset_lead      VARCHAR(100),
    reset_type      VARCHAR(100),
    quantity_needed INT  NOT NULL,
    status          VARCHAR(30) NOT NULL,    -- Confirmed, Planned
    priority        VARCHAR(30) NOT NULL     -- Standard, Priority, Rush
);

-- 5. RETRIEVAL SCHEDULE: when deployed fixtures come back to the DC
CREATE TABLE store_ops.retrieval_schedule (
    retrieval_id    SERIAL PRIMARY KEY,
    deployment_id   INT  NOT NULL REFERENCES store_ops.deployments(deployment_id),
    scheduled_date  DATE NOT NULL,
    status          VARCHAR(30) NOT NULL     -- Scheduled, Overdue, Complete
);

-- 6. FIXTURE INSPECTIONS: condition check after retrieval
CREATE TABLE store_ops.fixture_inspections (
    inspection_id   SERIAL PRIMARY KEY,
    retrieval_id    INT  NOT NULL REFERENCES store_ops.retrieval_schedule(retrieval_id),
    item_id         INT  NOT NULL REFERENCES store_ops.catalog(item_id),
    inspected_by    VARCHAR(100),
    inspection_date DATE,
    result          VARCHAR(20) NOT NULL,    -- Pass, Fail, Pending
    condition_notes TEXT,
    cleared_for_use BOOLEAN DEFAULT FALSE
);

-- 7. RESTOCK FLAGS: Active Restock Needed
CREATE TABLE store_ops.restock_flags (
    flag_id         SERIAL PRIMARY KEY,
    item_id         INT  NOT NULL REFERENCES store_ops.catalog(item_id),
    location_id     INT  NOT NULL REFERENCES store_ops.locations(location_id),
    flag_reason     VARCHAR(50) NOT NULL,    -- Failed Inspection, Consumed, Damaged
    quantity_needed INT  NOT NULL,
    status          VARCHAR(50) NOT NULL,
    flagged_at      TIMESTAMP DEFAULT NOW(),
    resolved        BOOLEAN DEFAULT FALSE
);

-- 8. DEPLOYMENT CALENDAR: 7-day window with 24-hour buffer gaps
CREATE TABLE store_ops.deployment_calendar (
    calendar_id     SERIAL PRIMARY KEY,
    deployment_date DATE NOT NULL,
    location_id     INT  NOT NULL REFERENCES store_ops.locations(location_id),
    item_id         INT  NOT NULL REFERENCES store_ops.catalog(item_id),
    allocation_id   INT  REFERENCES store_ops.pre_allocations(allocation_id),
    buffer_gap_hrs  INT  DEFAULT 24,
    is_confirmed    BOOLEAN DEFAULT FALSE,
    is_highlighted  BOOLEAN DEFAULT FALSE
);

CREATE INDEX idx_alloc_date     ON store_ops.pre_allocations(reset_date);
CREATE INDEX idx_deploy_loc     ON store_ops.deployments(location_id);
CREATE INDEX idx_restock_open   ON store_ops.restock_flags(resolved);
CREATE INDEX idx_calendar_date  ON store_ops.deployment_calendar(deployment_date);
