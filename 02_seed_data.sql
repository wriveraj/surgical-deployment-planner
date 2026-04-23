-- ============================================================
-- SEED DATA: Surgical Instrument Deployment Planner
-- Run this file after 01_schema.sql
-- Populates all 8 tables with realistic sample data
-- ============================================================

-- ------------------------------------------------------------
-- CATALOG: Implants and Instruments
-- ------------------------------------------------------------
INSERT INTO surgical_ops.catalog (item_name, item_type, system, size) VALUES
('Femoral Component', 'Implant', 'Knee', 1),
('Femoral Component', 'Implant', 'Knee', 2),
('Femoral Component', 'Implant', 'Knee', 3),
('Femoral Component', 'Implant', 'Knee', 4),
('Tibial Baseplate', 'Implant', 'Knee', 1),
('Tibial Baseplate', 'Implant', 'Knee', 2),
('Tibial Baseplate', 'Implant', 'Knee', 3),
('Femoral Head', 'Implant', 'Hip', 1),
('Femoral Head', 'Implant', 'Hip', 2),
('Femoral Head', 'Implant', 'Hip', 3),
('Acetabular Cup', 'Implant', 'Hip', 1),
('Acetabular Cup', 'Implant', 'Hip', 2),
('Humeral Stem', 'Implant', 'Shoulder', 1),
('Humeral Stem', 'Implant', 'Shoulder', 2),
('Glenoid Component', 'Implant', 'Shoulder', 1),
('Glenoid Component', 'Implant', 'Shoulder', 2),
('Radial Head', 'Implant', 'Elbow', 1),
('Radial Head', 'Implant', 'Elbow', 2),
('Ulnar Component', 'Implant', 'Elbow', 1),
('Trauma Plate 3.5mm', 'Implant', 'Trauma', 1),
('Trauma Plate 4.5mm', 'Implant', 'Trauma', 2),
('Intramedullary Nail', 'Implant', 'Trauma', 1),
('Knee Instrument Set', 'Instrument', 'Knee', 1),
('Hip Instrument Set', 'Instrument', 'Hip', 1),
('Shoulder Instrument Set', 'Instrument', 'Shoulder', 1),
('Elbow Instrument Set', 'Instrument', 'Elbow', 1),
('Trauma Instrument Set', 'Instrument', 'Trauma', 1);

-- ------------------------------------------------------------
-- LOCATIONS
-- ------------------------------------------------------------
INSERT INTO surgical_ops.locations (location_name, location_type, city, state) VALUES
('Hartford General Hospital', 'Hospital', 'Hartford', 'CT'),
('New Britain Medical Center', 'Hospital', 'New Britain', 'CT'),
('Yale New Haven Hospital', 'Hospital', 'New Haven', 'CT'),
('Bridgeport Hospital', 'Hospital', 'Bridgeport', 'CT'),
('Waterbury Hospital', 'Hospital', 'Waterbury', 'CT'),
('Manchester Memorial Hospital', 'Hospital', 'Manchester', 'CT'),
('Central CT Warehouse', 'Warehouse', 'New Britain', 'CT');

-- ------------------------------------------------------------
-- DEPLOYMENTS: What is currently out in the field
-- ------------------------------------------------------------
INSERT INTO surgical_ops.deployments (item_id, location_id, quantity, deployed_date, expected_return, status) VALUES
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
-- ADVANCED ALLOCATIONS: 7-day implant deployment plan
-- ------------------------------------------------------------
INSERT INTO surgical_ops.advanced_allocations (item_id, location_id, case_date, surgeon_name, procedure_type, quantity_needed, status, priority) VALUES
(1, 1, '2026-04-15', 'Dr. Martinez', 'Total Knee Replacement', 2, 'Confirmed', 'Standard'),
(2, 1, '2026-04-15', 'Dr. Martinez', 'Total Knee Replacement', 2, 'Confirmed', 'Standard'),
(5, 1, '2026-04-15', 'Dr. Martinez', 'Total Knee Replacement', 1, 'Confirmed', 'Standard'),
(8, 2, '2026-04-15', 'Dr. Thompson', 'Total Hip Replacement', 2, 'Confirmed', 'Standard'),
(11, 2, '2026-04-15', 'Dr. Thompson', 'Total Hip Replacement', 1, 'Confirmed', 'Standard'),
(13, 3, '2026-04-16', 'Dr. Patel', 'Shoulder Arthroplasty', 2, 'Planned', 'Standard'),
(17, 4, '2026-04-16', 'Dr. Kim', 'Elbow Replacement', 2, 'Planned', 'Urgent'),
(20, 5, '2026-04-17', 'Dr. Rivera', 'Trauma Repair', 3, 'Planned', 'Emergency'),
(1, 6, '2026-04-17', 'Dr. Chen', 'Total Knee Replacement', 2, 'Planned', 'Standard'),
(8, 1, '2026-04-18', 'Dr. Martinez', 'Hip Revision', 2, 'Planned', 'Urgent'),
(22, 2, '2026-04-18', 'Dr. Thompson', 'Trauma Nail Fixation', 2, 'Planned', 'Standard'),
(3, 3, '2026-04-19', 'Dr. Patel', 'Total Knee Replacement', 2, 'Planned', 'Standard'),
(13, 4, '2026-04-19', 'Dr. Kim', 'Shoulder Replacement', 2, 'Planned', 'Standard'),
(9, 5, '2026-04-20', 'Dr. Rivera', 'Total Hip Replacement', 1, 'Planned', 'Standard'),
(20, 6, '2026-04-21', 'Dr. Chen', 'Trauma Plating', 3, 'Planned', 'Urgent');

-- ------------------------------------------------------------
-- RETRIEVAL SCHEDULE
-- ------------------------------------------------------------
INSERT INTO surgical_ops.retrieval_schedule (deployment_id, scheduled_date, status) VALUES
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
-- INTEGRITY INSPECTIONS
-- ------------------------------------------------------------
INSERT INTO surgical_ops.integrity_inspections (retrieval_id, item_id, inspected_by, inspection_date, result, condition_notes, cleared_for_use) VALUES
(1, 1, 'William Rivera', '2026-04-09', 'Pass', 'No damage found', TRUE),
(2, 2, 'William Rivera', '2026-04-09', 'Pass', 'Minor surface wear, acceptable', TRUE),
(3, 5, 'William Rivera', '2026-04-10', 'Fail', 'Component cracked — remove from service', FALSE),
(4, 8, 'William Rivera', '2026-04-11', 'Pass', 'Clean, ready for redeployment', TRUE),
(5, 11, 'William Rivera', '2026-04-11', 'Pending', 'Awaiting full inspection', FALSE),
(6, 13, 'William Rivera', '2026-04-12', 'Pass', 'No issues found', TRUE),
(7, 15, 'William Rivera', '2026-04-12', 'Fail', 'Glenoid component scratched — failed QC', FALSE),
(8, 17, 'William Rivera', '2026-04-13', 'Pass', 'Ready for redeployment', TRUE),
(9, 19, 'William Rivera', '2026-04-13', 'Pending', 'Awaiting inspection', FALSE),
(10, 20, 'William Rivera', '2026-04-14', 'Pass', 'Good condition', TRUE),
(11, 22, 'William Rivera', '2026-04-14', 'Fail', 'Nail bent — unusable', FALSE),
(12, 3, 'William Rivera', '2026-04-15', 'Pass', 'Cleared', TRUE),
(13, 6, 'William Rivera', '2026-04-15', 'Pass', 'Cleared', TRUE);

-- ------------------------------------------------------------
-- RESTOCK FLAGS: Active Restock Needed
-- ------------------------------------------------------------
INSERT INTO surgical_ops.restock_flags (item_id, location_id, flag_reason, quantity_needed, status) VALUES
(5, 1, 'Failed Inspection', 1, 'Active Restock Needed'),
(15, 3, 'Failed Inspection', 1, 'Active Restock Needed'),
(22, 2, 'Failed Inspection', 2, 'Active Restock Needed'),
(9, 1, 'Consumed', 1, 'Active Restock Needed'),
(12, 2, 'Consumed', 1, 'Active Restock Needed'),
(19, 4, 'Damaged', 1, 'Active Restock Needed');

-- ------------------------------------------------------------
-- DEPLOYMENT CALENDAR: 7-day window with highlighted dates
-- ------------------------------------------------------------
INSERT INTO surgical_ops.deployment_calendar (deployment_date, location_id, item_id, allocation_id, buffer_gap_hrs, is_confirmed, is_highlighted) VALUES
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
