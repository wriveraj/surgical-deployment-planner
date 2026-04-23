DROP SCHEMA IF EXISTS surgical_ops CASCADE;
CREATE SCHEMA surgical_ops;

CREATE TABLE surgical_ops.catalog (
    item_id         SERIAL PRIMARY KEY,
    item_name       VARCHAR(150)   NOT NULL,
    item_type       VARCHAR(20)    NOT NULL CHECK (item_type IN ('Implant', 'Instrument')),
    system          VARCHAR(50)    NOT NULL CHECK (system IN ('Knee', 'Hip', 'Shoulder', 'Elbow', 'Trauma')),
    size            INT            NOT NULL,
    is_active       BOOLEAN        DEFAULT TRUE,
    created_at      TIMESTAMP      DEFAULT NOW()
);

CREATE TABLE surgical_ops.locations (
    location_id     SERIAL PRIMARY KEY,
    location_name   VARCHAR(150)   NOT NULL,
    location_type   VARCHAR(100)   NOT NULL,
    city            VARCHAR(100)   NOT NULL,
    state           CHAR(2)        NOT NULL,
    is_active       BOOLEAN        DEFAULT TRUE,
    created_at      TIMESTAMP      DEFAULT NOW()
);

CREATE TABLE surgical_ops.deployments (
    deployment_id   SERIAL PRIMARY KEY,
    item_id         INT            NOT NULL REFERENCES surgical_ops.catalog(item_id),
    location_id     INT            NOT NULL REFERENCES surgical_ops.locations(location_id),
    quantity        INT            NOT NULL DEFAULT 1,
    deployed_date   DATE           NOT NULL,
    expected_return DATE,
    status          VARCHAR(50)    DEFAULT 'Active',
    notes           TEXT,
    created_at      TIMESTAMP      DEFAULT NOW()
);

CREATE TABLE surgical_ops.advanced_allocations (
    allocation_id    SERIAL PRIMARY KEY,
    item_id          INT            NOT NULL REFERENCES surgical_ops.catalog(item_id),
    location_id      INT            NOT NULL REFERENCES surgical_ops.locations(location_id),
    case_date        DATE           NOT NULL,
    surgeon_name     VARCHAR(100),
    procedure_type   VARCHAR(100),
    quantity_needed  INT            NOT NULL DEFAULT 1,
    status           VARCHAR(50)    DEFAULT 'Planned',
    priority         VARCHAR(20)    DEFAULT 'Standard' CHECK (priority IN ('Standard', 'Urgent', 'Emergency')),
    notes            TEXT,
    created_at       TIMESTAMP      DEFAULT NOW()
);

CREATE TABLE surgical_ops.retrieval_schedule (
    retrieval_id     SERIAL PRIMARY KEY,
    deployment_id    INT            NOT NULL REFERENCES surgical_ops.deployments(deployment_id),
    scheduled_date   DATE           NOT NULL,
    actual_date      DATE,
    retrieved_by     VARCHAR(100),
    status           VARCHAR(50)    DEFAULT 'Scheduled',
    notes            TEXT,
    created_at       TIMESTAMP      DEFAULT NOW()
);

CREATE TABLE surgical_ops.integrity_inspections (
    inspection_id    SERIAL PRIMARY KEY,
    retrieval_id     INT            NOT NULL REFERENCES surgical_ops.retrieval_schedule(retrieval_id),
    item_id          INT            NOT NULL REFERENCES surgical_ops.catalog(item_id),
    inspected_by     VARCHAR(100),
    inspection_date  DATE           NOT NULL,
    result           VARCHAR(20)    NOT NULL CHECK (result IN ('Pass', 'Fail', 'Pending')),
    condition_notes  TEXT,
    cleared_for_use  BOOLEAN        DEFAULT FALSE,
    created_at       TIMESTAMP      DEFAULT NOW()
);

CREATE TABLE surgical_ops.restock_flags (
    flag_id          SERIAL PRIMARY KEY,
    item_id          INT            NOT NULL REFERENCES surgical_ops.catalog(item_id),
    location_id      INT            NOT NULL REFERENCES surgical_ops.locations(location_id),
    flag_reason      VARCHAR(100)   NOT NULL CHECK (flag_reason IN ('Consumed', 'Damaged', 'Failed Inspection', 'Lost')),
    quantity_needed  INT            NOT NULL DEFAULT 1,
    status           VARCHAR(50)    DEFAULT 'Active Restock Needed',
    flagged_at       TIMESTAMP      DEFAULT NOW(),
    resolved         BOOLEAN        DEFAULT FALSE,
    resolved_at      TIMESTAMP
);

CREATE TABLE surgical_ops.deployment_calendar (
    calendar_id      SERIAL PRIMARY KEY,
    deployment_date  DATE           NOT NULL,
    location_id      INT            NOT NULL REFERENCES surgical_ops.locations(location_id),
    item_id          INT            NOT NULL REFERENCES surgical_ops.catalog(item_id),
    allocation_id    INT            REFERENCES surgical_ops.advanced_allocations(allocation_id),
    buffer_gap_hrs   INT            NOT NULL DEFAULT 24,
    is_confirmed     BOOLEAN        DEFAULT FALSE,
    is_highlighted   BOOLEAN        DEFAULT TRUE,
    notes            TEXT,
    created_at       TIMESTAMP      DEFAULT NOW()
);
