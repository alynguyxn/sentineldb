-- SentinelDB: Query

DROP INDEX idx_packet_length;

CREATE INDEX idx_attack_type ON network_logs(attack_type);

EXPLAIN ANALYZE
SELECT 
    attack_type, 
    COUNT(*) AS total_incidents
FROM network_logs
GROUP BY attack_type
ORDER BY total_incidents DESC;