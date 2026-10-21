-- Pre-Allocation Plan: fixtures assigned to store resets in the 7-day planning window.
-- The window starts at the first planned reset so the sample data always returns rows;
-- swap plan_start for CURRENT_DATE when running against live data.
WITH plan AS (SELECT MIN(reset_date) AS plan_start FROM store_ops.pre_allocations)
SELECT pa.reset_date, l.location_name, c.item_name, c.fixture_family, c.size,
       pa.reset_lead, pa.reset_type, pa.quantity_needed, pa.priority, pa.status
FROM store_ops.pre_allocations pa
JOIN store_ops.catalog c   ON pa.item_id = c.item_id
JOIN store_ops.locations l ON pa.location_id = l.location_id
CROSS JOIN plan
WHERE c.item_type = 'Fixture'
  AND pa.reset_date BETWEEN plan.plan_start AND plan.plan_start + INTERVAL '7 days'
ORDER BY CASE pa.priority WHEN 'Rush' THEN 1 WHEN 'Priority' THEN 2 ELSE 3 END,
         pa.reset_date, l.location_name;
