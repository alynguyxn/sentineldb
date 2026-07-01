/* 
SentinelDB Analysis
Purpose: Identifying high-risk patterns in network security logs
 */

---------------------------------------------------------------------------

-- Problem 1: What are the most frequent types of attacks?
-- Solution: Group by attack_type to see which vectors are most common. 

SELECT 
    attack_type, 
    COUNT(*) AS total_incidents
FROM network_logs
GROUP BY attack_type
ORDER BY total_incidents DESC;

---------------------------------------------------------------------------

-- Problem 2: Which severity levels require the most attention?
-- Solution: Count events by severity to prioritize incident response

SELECT 
    severity_level, 
    COUNT(*) AS incident_count
FROM network_logs
GROUP BY severity_level
ORDER BY incident_count DESC;

---------------------------------------------------------------------------

-- Problem 3: Are there unusually large data transfers?
-- Solution: Find logs where packet_length > average

SELECT 
    log_id, 
    source_ip, 
    packet_length
FROM network_logs
WHERE packet_length > (SELECT AVG(packet_length) FROM network_logs)
ORDER BY packet_length DESC
LIMIT 10;

---------------------------------------------------------------------------

-- Problem 4: During which hour do most attacks occur?
-- Solution: Extract the hour from the timestamp to identify peak activity 
-- windows

SELECT 
    EXTRACT(HOUR FROM log_timestamp) AS attack_hour, 
    COUNT(*) AS event_volume
FROM network_logs
GROUP BY attack_hour
ORDER BY event_volume DESC;

---------------------------------------------------------------------------

-- Problem 5: A user tries to insert a log that has a invalid severity_level.
-- Solution: Create a check constraint

INSERT INTO network_logs (log_id, severity_level) 
VALUES (1, 'Super-High');

---------------------------------------------------------------------------

-- Problem 6: A user tries to insert a log with a negative packet_length
-- Solution: Create a check constraint

INSERT INTO network_logs (
    log_timestamp, 
    source_ip, 
    attack_type, 
    severity_level, 
    packet_length
) 
VALUES (
    '2026-07-01 18:30:00', 
    '192.168.1.50', 
    'Malware', 
    'Medium', 
    -100
);

---------------------------------------------------------------------------

-- Problem 7: Find all follow-up attacks that occur within 1 hour of the 
-- inital attack.
-- Solution: Using a JOIN statement,search for all related events where 
-- the same source_ip generated subsequent log within 1 hour

SELECT 
    a.source_ip, 
    a.log_timestamp AS initial_event, 
    b.log_timestamp AS follow_up_event,
    a.attack_type AS initial_attack,
    b.attack_type AS follow_up_attack
FROM network_logs a
JOIN network_logs b ON a.source_ip = b.source_ip
WHERE a.log_timestamp < b.log_timestamp
  AND b.log_timestamp <= a.log_timestamp + INTERVAL '1 hour'
ORDER BY a.source_ip, a.log_timestamp;