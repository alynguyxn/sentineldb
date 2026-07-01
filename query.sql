-- SentinelDB: Query

DROP INDEX idx_packet_length;

CREATE INDEX idx_packet_length ON network_logs(packet_length);

EXPLAIN ANALYZE
SELECT 
    log_id, 
    source_ip, 
    packet_length
FROM network_logs
WHERE packet_length > (SELECT AVG(packet_length) FROM network_logs)
ORDER BY packet_length DESC
LIMIT 10;