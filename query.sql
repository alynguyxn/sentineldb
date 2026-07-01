-- SentinelDB: Query



CREATE INDEX idx_attack_hour ON network_logs ((EXTRACT(HOUR FROM log_timestamp)));

EXPLAIN ANALYZE
SELECT 
    EXTRACT(HOUR FROM log_timestamp) AS attack_hour, 
    COUNT(*) AS event_volume
FROM network_logs
GROUP BY attack_hour
ORDER BY event_volume DESC;