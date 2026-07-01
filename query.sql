/* SentinelDB Query
Purpose: Run sql commands and view analysis
*/


-- -----------------------------------------------------------
-- STEP 1: INITIALIZATION
-- Run these if starting from a fresh environment
-- -----------------------------------------------------------
-- CREATE TABLE network_logs (...);
-- CREATE INDEX idx_attack_type ON network_logs(attack_type);


-- -----------------------------------------------------------
-- STEP 2: PERFORMANCE TESTING
-- Run to compare before vs after performance
-- -----------------------------------------------------------
-- EXPLAIN ANALYZE 
-- SELECT attack_type, COUNT(*) FROM network_logs GROUP BY attack_type;


-- -----------------------------------------------------------
-- STEP 3: ANALYTICAL QUERIES
-- The primary insights for SentinelDB
-- -----------------------------------------------------------
-- [Paste your optimized queries from the analysis file here]


-- -----------------------------------------------------------
-- STEP 4: CLEANUP & VALIDATION
-- Testing constraints & lifecycle management
-- -----------------------------------------------------------
-- [Paste your CONSTRAINT tests and DELETE operations here]