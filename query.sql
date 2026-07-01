-- SentinelDB: Query

EXPLAIN ANALYZE 
SELECT * FROM network_logs WHERE attack_type = 'DDoS';

DROP INDEX idx_severity_level;

CREATE INDEX idx_severity_level ON network_logs(severity_level);

DROP TABLE network_logs;




EXPLAIN ANALYZE
SELECT * FROM network_logs WHERE source_ip = '70.238.33.5';

CREATE INDEX idx_source_ip ON network_logs(source_ip);