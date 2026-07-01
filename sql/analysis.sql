/* * SentinelDB Analysis
 * Purpose: Identifying high-risk patterns in network security logs.
 */

-- 1. Data Overview
SELECT COUNT(*) AS total_records FROM network_logs;

-- 2. Trend Analysis: Attacks by Hour
SELECT 
    EXTRACT(HOUR FROM log_timestamp) AS attack_hour, 
    COUNT(*) AS volume
FROM network_logs
GROUP BY attack_hour
ORDER BY volume DESC;

-- 3. Risk Assesment: Average Anomaly Score by Severity
SELECT 
    severity_level, 
    ROUND(AVG(anomaly_score), 2) AS avg_risk
FROM network_logs
GROUP BY severity_level
ORDER BY avg_risk DESC;