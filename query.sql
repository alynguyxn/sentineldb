ALTER TABLE network_logs 
ADD CONSTRAINT check_severity 
CHECK (severity_level IN ('Low', 'Medium', 'High'));

INSERT INTO network_logs(severity_level) 'Super-Urgent-Critical';