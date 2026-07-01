# SentinelDB
<br/><br/>
# Overview
SentinelDB is a portfolio-based database project designed to store, manage, and analyze large-scale network security logs. 
This project demonstrates skills in data engineering, SQL performance optimization, and cybersecurity data analysis. <br/><br/>


## Project Purpose
The goal of this project is to simulate a Security Operations Center (SOC) environment where 40,000 network events are processed and queried to detect patterns in malicious activity. By building this database, I am exploring how to effectively index, aggregate, and report on security telemetry data.<br/><br/>


## Dataset
The project utilizes a synthetic network log dataset consisting of 25 metrics and 40,000 records created by Incribo.
Source: https://www.kaggle.com/datasets/teamincribo/cyber-security-attacks<br/><br/>


## Structure: 
The data includes the following field logs:
- log_ig
- log_timestamp
- source_ip
- destination_ip
- source_port
- destination_port
- protocol
- packet_length
- traffic_type
- payload_data
- malware-indicators
- anomaly_score
- alerts_warnings
- attack_type
- attack_signature
- action_taken
- severity_level
- user_info
- device_info
- network_segment
- geo_location
- proxy_info
- firewall_logs
- ids_ips_alerts
- log_source<br/><br/>


# Features
### Data Ingestion: 
Automated loading of raw CSV logs into a PostgreSQL relational structure.
<br/>
### Security Analytics: 
Complex SQL queries designed to calculate attack trends, identify high-risk IP addresses, and measure anomaly scores.
<br/>
### Performance Tuning: 
Optimization techniques implemented to reduce query execution time using B-Tree indexing.
<br/><br/>

# How to Run
1. Clone the repository: ``git clone https://github.com/alynguyxn/sentineldb.git``
2. Setup Database: Run ``sql/schema.sql`` to initialize the tables.
3. Import Data: Use the psql command to import your CSV file.
4. Analyze: Execute queries found in ``sql/analysis.sql``.
