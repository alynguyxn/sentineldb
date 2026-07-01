-- SentinelDB: Query
-- Author: Alyssa Nguyen

-- Problem #1: Querying severity_level was taking ~40ms longer using a Sequential Scan.
-- Optimization: Create a B-Tree index on the severity-level column
CREATE INDEX idx_severity_level ON network_logs(severity_level);

    