-- SentinelDB: Query

DROP INDEX idx_source_ip;

CREATE INDEX idx_source_ip ON network_logs(source_ip);

EXPLAIN ANALYZE
SELECT 
    source_ip, 
    ROUND(AVG(anomaly_score), 2) AS avg_anomaly_risk
FROM network_logs
GROUP BY source_ip
HAVING AVG(anomaly_score) > 75
ORDER BY avg_anomaly_risk DESC
LIMIT 10;