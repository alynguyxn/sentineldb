-- SentinelDB: Import
-- Author: Alyssa Nguyen

copy network_logs(log_timestamp, source_ip, destination_ip, source_port, destination_port, protocol, packet_length, packet_type, traffic_type, payload_data, malware_indicators, anomaly_score, alerts_warnings, attack_type, attack_signature, action_taken, severity_level, user_info, device_info, network_segment, geo_location, proxy_info, firewall_logs, ids_ips_alerts, log_source) FROM 'C:/sentineldb/data/cybersecurity_attacks.csv' WITH (FORMAT csv, HEADER true);