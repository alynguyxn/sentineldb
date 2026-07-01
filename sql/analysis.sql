-- SentinelDB: Analysis
-- Author: Alyssa Nguyen

-- Show Analysis for querying severity level
EXPLAIN ANALYZE 
SELECT * FROM network_logs 
WHERE severity_level = 'High';