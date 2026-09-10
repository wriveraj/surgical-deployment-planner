-- ============================================================
-- MEDICAL SUPPLY CHAIN AUDIT SIMULATOR
-- Schema: medical_supply
-- Author: William Rivera Jr
-- Description: Simulates hospital supply chain inventory,
--              purchase orders, shipments, and discrepancies
--              for audit and analytics purposes.
-- ============================================================

-- Drop and recreate schema for clean setup
DROP SCHEMA IF EXISTS medical_supply CASCADE;
CREATE SCHEMA medical_supply;
SET search_path TO medical_supply;


-- ------------------------------------------------------------
-- 1. PRODUCTS
-- Medical supplies tracked across locations
-- ------------------------------------------------------------
CREATE TABLE products (
    product_id      SERIAL PRIMARY KEY,
    product_name    VARCHAR(150)   NOT NULL,
    category        VARCHAR(100)   NOT NULL,  -- e.g. PPE, Medication, Equipment, Wound Care
    unit_cost       NUMERIC(10,2)  NOT NULL,
    par_level       INT            NOT NULL,  -- minimum stock threshold
    reorder_qty     INT            NOT NULL,  -- how many to order when below PAR
    unit_of_measure VARCHAR(50)    NOT NULL,  -- e.g. Each, Box, Case
    is_active       BOOLEAN        DEFAULT TRUE,
    created_at      TIMESTAMP      DEFAULT NOW()
);


-- ------------------------------------------------------------
-- 2. LOCATIONS
-- Hospitals, clinics, or supply rooms being tracked
-- ------------------------------------------------------------
CREATE TABLE locations (
    location_id     SERIAL PRIMARY KEY,
    location_name   VARCHAR(150)   NOT NULL,
    location_type   VARCHAR(100)   NOT NULL,  -- e.g. Hospital, Clinic, Warehouse
    city            VARCHAR(100)   NOT NULL,
    state           CHAR(2)        NOT NULL,
    is_active       BOOLEAN        DEFAULT TRUE,
    created_at      TIMESTAMP      DEFAULT NOW()
);


-- ------------------------------------------------------------
-- 3. INVENTORY
-- Current stock levels per product per location
-- ------------------------------------------------------------
CREATE TABLE inventory (
    inventory_id    SERIAL PRIMARY KEY,
    product_id      INT            NOT NULL REFERENCES products(product_id),
    location_id     INT            NOT NULL REFERENCES locations(location_id),
    quantity_on_hand INT           NOT NULL DEFAULT 0,
    last_counted_at TIMESTAMP      DEFAULT NOW(),
    updated_at      TIMESTAMP      DEFAULT NOW(),
    UNIQUE (product_id, location_id)
);


-- ------------------------------------------------------------
-- 4. PURCHASE ORDERS
-- Orders placed to restock inventory
-- ------------------------------------------------------------
CREATE TABLE purchase_orders (
    po_id           SERIAL PRIMARY KEY,
    product_id      INT            NOT NULL REFERENCES products(product_id),
    location_id     INT            NOT NULL REFERENCES locations(location_id),
    ordered_qty     INT            NOT NULL,
    order_date      DATE           NOT NULL,
    expected_date   DATE           NOT NULL,
    status          VARCHAR(50)    DEFAULT 'Pending',  -- Pending, Shipped, Received, Cancelled
    created_at      TIMESTAMP      DEFAULT NOW()
);


-- ------------------------------------------------------------
-- 5. SHIPMENTS
-- What actually arrived vs what was ordered
-- ------------------------------------------------------------
CREATE TABLE shipments (
    shipment_id     SERIAL PRIMARY KEY,
    po_id           INT            NOT NULL REFERENCES purchase_orders(po_id),
    received_qty    INT            NOT NULL,
    received_date   DATE           NOT NULL,
    received_by     VARCHAR(100),
    notes           TEXT,
    created_at      TIMESTAMP      DEFAULT NOW()
);


-- ------------------------------------------------------------
-- 6. DISCREPANCIES
-- Flagged mismatches between expected and actual
-- ------------------------------------------------------------
CREATE TABLE discrepancies (
    discrepancy_id  SERIAL PRIMARY KEY,
    po_id           INT            REFERENCES purchase_orders(po_id),
    inventory_id    INT            REFERENCES inventory(inventory_id),
    discrepancy_type VARCHAR(100)  NOT NULL,  -- Shipment Shortage, Overstock, Stockout, Count Mismatch
    expected_qty    INT,
    actual_qty      INT,
    variance        INT GENERATED ALWAYS AS (actual_qty - expected_qty) STORED,
    flagged_at      TIMESTAMP      DEFAULT NOW(),
    resolved        BOOLEAN        DEFAULT FALSE,
    resolution_notes TEXT
);


-- ------------------------------------------------------------
-- 7. AUDIT LOG
-- Tracks all inventory changes over time
-- ------------------------------------------------------------
CREATE TABLE audit_log (
    log_id          SERIAL PRIMARY KEY,
    inventory_id    INT            NOT NULL REFERENCES inventory(inventory_id),
    product_id      INT            NOT NULL REFERENCES products(product_id),
    location_id     INT            NOT NULL REFERENCES locations(location_id),
    previous_qty    INT,
    new_qty         INT,
    change_reason   VARCHAR(150),  -- e.g. Cycle Count, Shipment Received, Manual Adjustment
    changed_by      VARCHAR(100),
    changed_at      TIMESTAMP      DEFAULT NOW()
);


-- ------------------------------------------------------------
-- INDEXES for query performance
-- ------------------------------------------------------------
CREATE INDEX idx_inventory_product    ON inventory(product_id);
CREATE INDEX idx_inventory_location   ON inventory(location_id);
CREATE INDEX idx_po_product           ON purchase_orders(product_id);
CREATE INDEX idx_po_location          ON purchase_orders(location_id);
CREATE INDEX idx_po_status            ON purchase_orders(status);
CREATE INDEX idx_shipments_po         ON shipments(po_id);
CREATE INDEX idx_discrepancies_po     ON discrepancies(po_id);
CREATE INDEX idx_discrepancies_type   ON discrepancies(discrepancy_type);
CREATE INDEX idx_audit_log_inventory  ON audit_log(inventory_id);
CREATE INDEX idx_audit_log_changed_at ON audit_log(changed_at);
