-- SentinelDB: Query
EXPLAIN ANALYZE
SELECT * FROM network_logs WHERE packet_length = '1500';

CREATE INDEX idx_packet_length ON network_logs(packet_length);