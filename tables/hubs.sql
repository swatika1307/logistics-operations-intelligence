CREATE TABLE hubs (
	hub_id INT PRIMARY KEY,
    hub_name VARCHAR(100) NOT NULL,
    hub_capacity INT
);

DESCRIBE hubs;

SELECT * FROM hubs;

SELECT COUNT(*) FROM hubs;