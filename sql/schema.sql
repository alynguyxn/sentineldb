/* 
SentinelDB Schema
Purpose: Create and edit tables and indexes
 */

---------------------------------------------------------------------------

CREATE TABLE network_logs (
    log_id SERIAL PRIMARY KEY,
    log_timestamp TIMESTAMP,
    source_ip INET,
    destination_ip INET,
    source_port INT,
    destination_port INT,
    protocol VARCHAR(10),
    packet_length INT,
    packet_type VARCHAR(20),
    traffic_type VARCHAR(20),
    payload_data TEXT,
    malware_indicators TEXT,
    anomaly_score NUMERIC(5, 2),
    alerts_warnings TEXT,
    attack_type VARCHAR(50),
    attack_signature VARCHAR(100),
    action_taken VARCHAR(20),
    severity_level VARCHAR(20),
    user_info TEXT,
    device_info TEXT,
    network_segment VARCHAR(50),
    geo_location TEXT,
    proxy_info TEXT,
    firewall_logs TEXT,
    ids_ips_alerts TEXT,
    log_source VARCHAR(50)
);

-- Solution 1: Create an index on the attack_type column
CREATE INDEX idx_attack_type ON network_logs(attack_type);

-- Solution 2: Create an index on the severity_level column
CREATE INDEX idx_severity_level ON network_logs(severity_level);

-- Solution 3: Create an index on the packet_length column
CREATE INDEX idx_packet_length ON network_logs(packet_length);

-- Solution 4: Create an index that extracts the hour from the log_timestamp column
CREATE INDEX idx_attack_hour ON network_logs ((EXTRACT(HOUR FROM log_timestamp)));

-- Solution 5: Create a check constraint
ALTER TABLE network_logs 
ADD CONSTRAINT check_severity 
CHECK (severity_level IN ('Low', 'Medium', 'High'));

-- Solution 6: Create a check constraint
ALTER TABLE network_logs 
ADD CONSTRAINT check_packet_length 
CHECK (packet_length >= 0);

-- Solution 7: Using a JOIN statement,search for all related events where the same source_ip generated subsequent log within 1 hour
SELECT 
    a.source_ip, 
    a.log_timestamp AS initial_event, 
    b.log_timestamp AS follow_up_event,
    a.attack_type AS initial_attack,
    b.attack_type AS follow_up_attack
FROM network_logs a
JOIN network_logs b ON a.source_ip = b.source_ip
WHERE a.log_timestamp < b.log_timestamp
  AND b.log_timestamp <= a.log_timestamp + INTERVAL '1 hour'
ORDER BY a.source_ip, a.log_timestamp;

-- Solution 8: Delete log entries that are low severity and are > 90 days old
DELETE FROM network_logs 
WHERE severity_level = 'Low' 
AND log_timestamp < CURRENT_DATE - INTERVAL '90 days';