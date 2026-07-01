ALTER TABLE network_logs 
ADD CONSTRAINT check_packet_length CHECK (packet_length >= 0);

SELECT 
    attack_type, 
    COUNT(*) AS total_incidents
FROM network_logs
GROUP BY attack_type
ORDER BY total_incidents DESC;

INSERT INTO network_logs (
    log_timestamp, 
    source_ip, 
    attack_type, 
    severity_level, 
    packet_length
) 
VALUES (
    '2026-07-01 18:30:00', 
    '192.168.1.50', 
    'Malware', 
    'Medium', 
    -100
);