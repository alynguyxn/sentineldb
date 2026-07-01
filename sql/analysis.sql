/* * SentinelDB Analysis
 * Purpose: Identifying high-risk patterns in network security logs
 */

-- Problem 1: What are the most frequent types of attacks?
-- Soltuion: Group by attack_type to see which vectors are most common
SELECT 
    attack_type, 
    COUNT(*) AS total_incidents
FROM network_logs
GROUP BY attack_type
ORDER BY total_incidents DESC;


-- Problem 2: Which severity levels require the most attention?
-- Soltuion: Count events by severity to prioritize incident response
SELECT 
    severity_level, 
    COUNT(*) AS incident_count
FROM network_logs
GROUP BY severity_level
ORDER BY incident_count DESC;


-- Problem 3: Which IPs are the biggest risk?
-- Soltuion: Identify sources with the highest average anomaly scores
SELECT 
    source_ip, 
    ROUND(AVG(anomaly_score), 2) AS avg_anomaly_risk
FROM network_logs
GROUP BY source_ip
HAVING AVG(anomaly_score) > 75
ORDER BY avg_anomaly_risk DESC
LIMIT 10;


-- Problem 4: Are there unusually large data transfers?
-- Solution: Find logs where packet_length > average
SELECT 
    log_id, 
    source_ip, 
    packet_length
FROM network_logs
WHERE packet_length > (SELECT AVG(packet_length) FROM network_logs)
ORDER BY packet_length DESC
LIMIT 10;


-- Problem 5: During which hour do most attacks occur?
-- Solution: Extract the hour from the timestamp to identify peak activity windows
SELECT 
    EXTRACT(HOUR FROM log_timestamp) AS attack_hour, 
    COUNT(*) AS event_volume
FROM network_logs
GROUP BY attack_hour
ORDER BY event_volume DESC;