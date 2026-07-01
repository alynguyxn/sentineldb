-- SentinelDB: Query

DROP INDEX idx_severity_level;

CREATE INDEX idx_severity_level ON network_logs(severity_level);

EXPLAIN ANALYZE
SELECT 
    severity_level, 
    COUNT(*) AS incident_count
FROM network_logs
GROUP BY severity_level
ORDER BY incident_count DESC;