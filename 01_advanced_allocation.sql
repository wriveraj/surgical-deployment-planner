-- ============================================================
-- QUERY 1: Advanced Allocation — Implants Planned Next 7 Days
-- Returns all implant allocations for the next 7 days
-- sorted by priority (Emergency > Urgent > Standard)
-- then by case date and location.
-- ============================================================

SELECT
    aa.case_date,
    l.location_name,
    c.item_name,
    c.system,
    c.size,
    aa.surgeon_name,
    aa.procedure_type,
    aa.quantity_needed,
    aa.priority,
    aa.status
FROM surgical_ops.advanced_allocations aa
JOIN surgical_ops.catalog c ON aa.item_id = c.item_id
JOIN surgical_ops.locations l ON aa.location_id = l.location_id
WHERE c.item_type = 'Implant'
AND aa.case_date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days'
ORDER BY aa.priority DESC, aa.case_date, l.location_name;
