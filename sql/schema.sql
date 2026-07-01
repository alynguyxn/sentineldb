/* SentinelDB Schema */

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

-- Indexes for performance
CREATE INDEX idx_attack_type ON network_logs(attack_type);
CREATE INDEX idx_severity_level ON network_logs(severity_level);
CREATE INDEX idx_packet_length ON network_logs(packet_length);
CREATE INDEX idx_attack_hour ON network_logs ((EXTRACT(HOUR FROM log_timestamp)));

-- Data Integrity Constraints
ALTER TABLE network_logs 
ADD CONSTRAINT check_severity 
CHECK (severity_level IN ('Low', 'Medium', 'High', 'Critical'));

ALTER TABLE network_logs 
ADD CONSTRAINT check_packet_length 
CHECK (packet_length >= 0);