-- SentinelDB: Query

DROP INDEX idx_packet_length;

CREATE INDEX idx_packet_length ON network_logs(packet_length);

EXPLAIN ANALYZE
SELECT 
    EXTRACT(HOUR FROM log_timestamp) AS attack_hour, 
    COUNT(*) AS event_volume
FROM network_logs
GROUP BY attack_hour
ORDER BY event_volume DESC;