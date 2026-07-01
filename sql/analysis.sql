/* SentinelDB Analysis
Purpose: Security log analytics, integrity enforcement, and lifecycle management
*/

---------------------------------------------------------------------------
-- PART 1: ANALYTICAL QUERIES (Threat Intelligence)
---------------------------------------------------------------------------

-- Q1: Most frequent attack vectors
SELECT attack_type, COUNT(*) AS total_incidents
FROM network_logs
GROUP BY attack_type
ORDER BY total_incidents DESC;

-- Q2: Severity prioritization
SELECT severity_level, COUNT(*) AS incident_count
FROM network_logs
GROUP BY severity_level
ORDER BY incident_count DESC;

-- Q3: Identifying large data transfers
-- Note: Subquery compares against the global average to flag outliers
SELECT log_id, source_ip, packet_length
FROM network_logs
WHERE packet_length > (SELECT AVG(packet_length) FROM network_logs)
ORDER BY packet_length DESC
LIMIT 10;

-- Q4: Identifying peak activity windows
-- Note: Using EXTRACT to map event frequency to hourly cycles
SELECT EXTRACT(HOUR FROM log_timestamp) AS attack_hour, 
       COUNT(*) AS event_volume
FROM network_logs
GROUP BY attack_hour
ORDER BY event_volume DESC;

-- Q5: Threat sequence analysis (Self-Join)
-- Note: Identifies potential activity from same source_ip within a 1-hour window
SELECT a.source_ip, 
       a.log_timestamp AS initial_event, 
       b.log_timestamp AS follow_up_event,
       a.attack_type AS initial_attack,
       b.attack_type AS follow_up_attack
FROM network_logs a
JOIN network_logs b ON a.source_ip = b.source_ip
WHERE a.log_timestamp < b.log_timestamp
  AND b.log_timestamp <= a.log_timestamp + INTERVAL '1 hour'
ORDER BY a.source_ip, a.log_timestamp;

---------------------------------------------------------------------------
-- PART 2: DATA INTEGRITY (Constraint Enforcement)
---------------------------------------------------------------------------

-- Note: These queries will trigger errors if constraints are properly applied.
-- They demonstrate defensive programming and data validation.

-- Test 1: Severity validation (Expected: Error)
INSERT INTO network_logs (log_id, severity_level) VALUES (1, 'Super-High');

-- Test 2: Negative value protection (Expected: Error)
INSERT INTO network_logs (log_timestamp, source_ip, attack_type, severity_level, packet_length) 
VALUES ('2026-07-01 18:30:00', '192.168.1.50', 'Malware', 'Medium', -100);

---------------------------------------------------------------------------
-- PART 3: DATA LIFECYCLE MANAGEMENT (Administrative)
---------------------------------------------------------------------------

-- Q6: Remove low-risk data
-- Note: Critical for maintaining database performance and saving storage
DELETE FROM network_logs 
WHERE severity_level = 'Low' 
AND log_timestamp < CURRENT_DATE - INTERVAL '90 days';