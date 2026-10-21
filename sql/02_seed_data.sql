-- ============================================================
-- SEED DATA: Store Fixture Deployment Planner
-- Run this file after 01_schema.sql
-- Populates all 8 tables with realistic sample data
-- ============================================================

-- ------------------------------------------------------------
-- CATALOG: Display fixtures and install kits
-- ------------------------------------------------------------
INSERT INTO store_ops.catalog (item_name, item_type, fixture_family, size) VALUES
('Endcap Header Panel', 'Fixture', 'Endcap', 1),
('Endcap Header Panel', 'Fixture', 'Endcap', 2),
('Endcap Header Panel', 'Fixture', 'Endcap', 3),
('Endcap Header Panel', 'Fixture', 'Endcap', 4),
('Endcap Base Deck', 'Fixture', 'Endcap', 1),
('Endcap Base Deck', 'Fixture', 'Endcap', 2),
('Endcap Base Deck', 'Fixture', 'Endcap', 3),
('Gondola Shelf Set', 'Fixture', 'Gondola', 1),
('Gondola Shelf Set', 'Fixture', 'Gondola', 2),
('Gondola Shelf Set', 'Fixture', 'Gondola', 3),
('Gondola Header Sign', 'Fixture', 'Gondola', 1),
('Gondola Header Sign', 'Fixture', 'Gondola', 2),
('Checkout Impulse Rack', 'Fixture', 'Checkout', 1),
('Checkout Impulse Rack', 'Fixture', 'Checkout', 2),
('Checkout Sign Frame', 'Fixture', 'Checkout', 1),
('Checkout Sign Frame', 'Fixture', 'Checkout', 2),
('Seasonal Display Tower', 'Fixture', 'Seasonal', 1),
('Seasonal Display Tower', 'Fixture', 'Seasonal', 2),
('Seasonal Topper Sign', 'Fixture', 'Seasonal', 1),
('Pallet Skirt 40in', 'Fixture', 'Pallet', 1),
('Pallet Skirt 48in', 'Fixture', 'Pallet', 2),
('Pallet Display Frame', 'Fixture', 'Pallet', 1),
('Endcap Install Kit', 'Install Kit', 'Endcap', 1),
('Gondola Install Kit', 'Install Kit', 'Gondola', 1),
('Checkout Install Kit', 'Install Kit', 'Checkout', 1),
('Seasonal Install Kit', 'Install Kit', 'Seasonal', 1),
('Pallet Install Kit', 'Install Kit', 'Pallet', 1);

-- ------------------------------------------------------------
-- LOCATIONS
-- ------------------------------------------------------------
INSERT INTO store_ops.locations (location_name, location_type, city, state) VALUES
('STORE-01', 'Store', 'Zone A', 'ST'),
('STORE-02', 'Store', 'Zone B', 'ST'),
('STORE-03', 'Store', 'Zone C', 'ST'),
('STORE-04', 'Store', 'Zone D', 'ST'),
('STORE-05', 'Store', 'Zone E', 'ST'),
('STORE-06', 'Store', 'Zone F', 'ST'),
('DC-CENTRAL', 'Warehouse', 'Zone B', 'ST');

-- ------------------------------------------------------------
-- DEPLOYMENTS: What is currently out in the field
-- ------------------------------------------------------------
INSERT INTO store_ops.deployments (item_id, location_id, quantity, deployed_date, expected_return, status) VALUES
(1, 1, 2, '2026-04-01', '2026-04-08', 'Active'),
(2, 1, 2, '2026-04-01', '2026-04-08', 'Active'),
(5, 1, 1, '2026-04-02', '2026-04-09', 'Active'),
(8, 2, 2, '2026-04-03', '2026-04-10', 'Active'),
(11, 2, 1, '2026-04-03', '2026-04-10', 'Active'),
(13, 3, 2, '2026-04-04', '2026-04-11', 'Active'),
(15, 3, 1, '2026-04-04', '2026-04-11', 'Active'),
(17, 4, 2, '2026-04-05', '2026-04-12', 'Active'),
(19, 4, 1, '2026-04-05', '2026-04-12', 'Active'),
(20, 5, 3, '2026-04-06', '2026-04-13', 'Active'),
(22, 5, 2, '2026-04-06', '2026-04-13', 'Active'),
(3, 6, 2, '2026-04-07', '2026-04-14', 'Active'),
(6, 6, 1, '2026-04-07', '2026-04-14', 'Active'),
(9, 1, 1, '2026-03-28', '2026-04-04', 'Overdue'),
(12, 2, 1, '2026-03-29', '2026-04-05', 'Overdue'),
(23, 3, 1, '2026-04-01', '2026-04-08', 'Active'),
(24, 4, 1, '2026-04-02', '2026-04-09', 'Active'),
(25, 5, 1, '2026-04-03', '2026-04-10', 'Active');

-- ------------------------------------------------------------
-- PRE-ALLOCATIONS: 7-day fixture deployment plan
-- ------------------------------------------------------------
INSERT INTO store_ops.pre_allocations (item_id, location_id, reset_date, reset_lead, reset_type, quantity_needed, status, priority) VALUES
(1, 1, '2026-04-15', 'Reset Lead A', 'Spring Endcap Reset', 2, 'Confirmed', 'Standard'),
(2, 1, '2026-04-15', 'Reset Lead A', 'Spring Endcap Reset', 2, 'Confirmed', 'Standard'),
(5, 1, '2026-04-15', 'Reset Lead A', 'Spring Endcap Reset', 1, 'Confirmed', 'Standard'),
(8, 2, '2026-04-15', 'Reset Lead B', 'Aisle Gondola Reset', 2, 'Confirmed', 'Standard'),
(11, 2, '2026-04-15', 'Reset Lead B', 'Aisle Gondola Reset', 1, 'Confirmed', 'Standard'),
(13, 3, '2026-04-16', 'Reset Lead C', 'Checkout Lane Reset', 2, 'Planned', 'Standard'),
(17, 4, '2026-04-16', 'Reset Lead D', 'Seasonal Changeover', 2, 'Planned', 'Priority'),
(20, 5, '2026-04-17', 'Reset Lead E', 'Promo Pallet Drop', 3, 'Planned', 'Rush'),
(1, 6, '2026-04-17', 'Reset Lead F', 'Spring Endcap Reset', 2, 'Planned', 'Standard'),
(8, 1, '2026-04-18', 'Reset Lead A', 'Gondola Remerchandise', 2, 'Planned', 'Priority'),
(22, 2, '2026-04-18', 'Reset Lead B', 'Promo Pallet Drop', 2, 'Planned', 'Standard'),
(3, 3, '2026-04-19', 'Reset Lead C', 'Spring Endcap Reset', 2, 'Planned', 'Standard'),
(13, 4, '2026-04-19', 'Reset Lead D', 'Checkout Lane Reset', 2, 'Planned', 'Standard'),
(9, 5, '2026-04-20', 'Reset Lead E', 'Aisle Gondola Reset', 1, 'Planned', 'Standard'),
(20, 6, '2026-04-21', 'Reset Lead F', 'Promo Pallet Drop', 3, 'Planned', 'Priority');

-- ------------------------------------------------------------
-- RETRIEVAL SCHEDULE
-- ------------------------------------------------------------
INSERT INTO store_ops.retrieval_schedule (deployment_id, scheduled_date, status) VALUES
(1, '2026-04-08', 'Scheduled'),
(2, '2026-04-08', 'Scheduled'),
(3, '2026-04-09', 'Scheduled'),
(4, '2026-04-10', 'Scheduled'),
(5, '2026-04-10', 'Scheduled'),
(6, '2026-04-11', 'Scheduled'),
(7, '2026-04-11', 'Scheduled'),
(8, '2026-04-12', 'Scheduled'),
(9, '2026-04-12', 'Scheduled'),
(10, '2026-04-13', 'Scheduled'),
(11, '2026-04-13', 'Scheduled'),
(12, '2026-04-14', 'Scheduled'),
(13, '2026-04-14', 'Scheduled'),
(14, '2026-04-08', 'Overdue'),
(15, '2026-04-08', 'Overdue'),
(16, '2026-04-08', 'Scheduled'),
(17, '2026-04-09', 'Scheduled'),
(18, '2026-04-10', 'Scheduled');

-- ------------------------------------------------------------
-- FIXTURE INSPECTIONS
-- ------------------------------------------------------------
INSERT INTO store_ops.fixture_inspections (retrieval_id, item_id, inspected_by, inspection_date, result, condition_notes, cleared_for_use) VALUES
(1, 1, 'DC Tech A', '2026-04-09', 'Pass', 'No damage found', TRUE),
(2, 2, 'DC Tech A', '2026-04-09', 'Pass', 'Minor surface wear, acceptable', TRUE),
(3, 5, 'DC Tech A', '2026-04-10', 'Fail', 'Deck cracked, remove from service', FALSE),
(4, 8, 'DC Tech A', '2026-04-11', 'Pass', 'Clean, ready for redeployment', TRUE),
(5, 11, 'DC Tech A', '2026-04-11', 'Pending', 'Awaiting full inspection', FALSE),
(6, 13, 'DC Tech A', '2026-04-12', 'Pass', 'No issues found', TRUE),
(7, 15, 'DC Tech A', '2026-04-12', 'Fail', 'Frame scratched, failed QC', FALSE),
(8, 17, 'DC Tech A', '2026-04-13', 'Pass', 'Ready for redeployment', TRUE),
(9, 19, 'DC Tech A', '2026-04-13', 'Pending', 'Awaiting inspection', FALSE),
(10, 20, 'DC Tech A', '2026-04-14', 'Pass', 'Good condition', TRUE),
(11, 22, 'DC Tech A', '2026-04-14', 'Fail', 'Frame bent, unusable', FALSE),
(12, 3, 'DC Tech A', '2026-04-15', 'Pass', 'Cleared', TRUE),
(13, 6, 'DC Tech A', '2026-04-15', 'Pass', 'Cleared', TRUE);

-- ------------------------------------------------------------
-- RESTOCK FLAGS: Active Restock Needed
-- ------------------------------------------------------------
INSERT INTO store_ops.restock_flags (item_id, location_id, flag_reason, quantity_needed, status) VALUES
(5, 1, 'Failed Inspection', 1, 'Active Restock Needed'),
(15, 3, 'Failed Inspection', 1, 'Active Restock Needed'),
(22, 2, 'Failed Inspection', 2, 'Active Restock Needed'),
(9, 1, 'Consumed', 1, 'Active Restock Needed'),
(12, 2, 'Consumed', 1, 'Active Restock Needed'),
(19, 4, 'Damaged', 1, 'Active Restock Needed');

-- ------------------------------------------------------------
-- DEPLOYMENT CALENDAR: 7-day window with highlighted dates
-- ------------------------------------------------------------
INSERT INTO store_ops.deployment_calendar (deployment_date, location_id, item_id, allocation_id, buffer_gap_hrs, is_confirmed, is_highlighted) VALUES
('2026-04-15', 1, 1, 1, 24, TRUE, TRUE),
('2026-04-15', 1, 2, 2, 24, TRUE, TRUE),
('2026-04-15', 1, 5, 3, 24, TRUE, TRUE),
('2026-04-15', 2, 8, 4, 24, TRUE, TRUE),
('2026-04-15', 2, 11, 5, 24, TRUE, TRUE),
('2026-04-16', 3, 13, 6, 24, FALSE, TRUE),
('2026-04-16', 4, 17, 7, 24, FALSE, TRUE),
('2026-04-17', 5, 20, 8, 24, FALSE, TRUE),
('2026-04-17', 6, 1, 9, 24, FALSE, TRUE),
('2026-04-18', 1, 8, 10, 24, FALSE, TRUE),
('2026-04-18', 2, 22, 11, 24, FALSE, TRUE),
('2026-04-19', 3, 3, 12, 24, FALSE, TRUE),
('2026-04-19', 4, 13, 13, 24, FALSE, TRUE),
('2026-04-20', 5, 9, 14, 24, FALSE, TRUE),
('2026-04-21', 6, 20, 15, 24, FALSE, TRUE);
