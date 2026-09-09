-- ============================================================
-- QUERY 3: Active Restock Needed
-- Returns all unresolved restock flags showing what needs
-- to be ordered and why — consumed, damaged, or failed inspection.
-- ============================================================

SELECT
    l.location_name,
    c.item_name,
    c.system,
    c.size,
    rf.flag_reason,
    rf.quantity_needed,
    rf.status,
    rf.flagged_at::DATE AS flagged_date
FROM surgical_ops.restock_flags rf
JOIN surgical_ops.catalog c ON rf.item_id = c.item_id
JOIN surgical_ops.locations l ON rf.location_id = l.location_id
WHERE rf.resolved = FALSE
ORDER BY c.system, l.location_name;
