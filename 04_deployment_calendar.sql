-- ============================================================
-- QUERY 4: 7-Day Deployment Calendar with Buffer Gap Status
-- Shows every upcoming deployment with retrieval date and
-- whether the 24-hour buffer gap is met before redeployment.
-- Buffer Gap Risk = less than 1 day between retrieval and deploy.
-- ============================================================

SELECT
    dc.deployment_date,
    l.location_name,
    c.item_name,
    c.system,
    aa.surgeon_name,
    aa.priority,
    dc.buffer_gap_hrs,
    CASE WHEN dc.is_confirmed THEN 'Confirmed' ELSE 'Planned' END AS deployment_status,
    rs.scheduled_date AS retrieval_date,
    CASE 
        WHEN rs.scheduled_date IS NULL THEN 'No Retrieval Scheduled'
        WHEN dc.deployment_date - rs.scheduled_date < 1 THEN 'Buffer Gap Risk'
        ELSE 'Buffer OK'
    END AS buffer_status
FROM surgical_ops.deployment_calendar dc
JOIN surgical_ops.catalog c ON dc.item_id = c.item_id
JOIN surgical_ops.locations l ON dc.location_id = l.location_id
LEFT JOIN surgical_ops.advanced_allocations aa ON dc.allocation_id = aa.allocation_id
LEFT JOIN surgical_ops.retrieval_schedule rs ON rs.deployment_id = dc.allocation_id
WHERE c.item_type = 'Implant'
ORDER BY dc.deployment_date, aa.priority DESC;
