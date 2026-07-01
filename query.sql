-- SentinelDB: Query

EXPLAIN ANALYZE 
SELECT * FROM network_logs WHERE attack_type = 'DDoS';

DROP INDEX idx_severity_level;

CREATE INDEX idx_severity_level ON network_logs(severity_level);

DROP TABLE network_logs;




EXPLAIN ANALYZE
SEELCT * FROM network_logs WHERE