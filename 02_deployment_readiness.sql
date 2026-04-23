-- ============================================================
-- QUERY 2: Deployment Readiness Check
-- For each upcoming deployment, shows whether the implant is:
-- Ready / Needs Restock / Inspection Pending / Not Yet Inspected
-- ============================================================

SELECT
    dc.deployment_date,
    l.location_name,
    c.item_name,
    c.system,
    c.size,
    aa.surgeon_name,
    aa.priority,
    CASE 
        WHEN ii.cleared_for_use = TRUE THEN 'Ready'
        WHEN ii.result = 'Fail' THEN 'Needs Restock'
        WHEN ii.result = 'Pending' THEN 'Inspection Pending'
        WHEN ii.inspection_id IS NULL THEN 'Not Yet Inspected'
        ELSE 'Unknown'
    END AS readiness_status
FROM surgical_ops.deployment_calendar dc
JOIN surgical_ops.catalog c ON dc.item_id = c.item_id
JOIN surgical_ops.locations l ON dc.location_id = l.location_id
LEFT JOIN surgical_ops.advanced_allocations aa ON dc.allocation_id = aa.allocation_id
LEFT JOIN surgical_ops.retrieval_schedule rs ON rs.deployment_id = dc.allocation_id
LEFT JOIN surgical_ops.integrity_inspections ii ON ii.retrieval_id = rs.retrieval_id AND ii.item_id = c.item_id
WHERE c.item_type = 'Implant'
ORDER BY dc.deployment_date, aa.priority DESC;
