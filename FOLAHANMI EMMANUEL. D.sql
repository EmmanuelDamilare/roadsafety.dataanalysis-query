CREATE schema Project;

SELECT *
FROM `accident.project`;

RENAME table `accident.project`
TO accident;

SELECT *
FROM accident;

SELECT *
FROM vehicle;


CREATE table vehicle(vehicle_id VARCHAR(250), accident_index VARCHAR(250),vehicle_type VARCHAR(250),pointimpact VARCHAR(250),
					lefthand VARCHAR(250),journeypurpose VARCHAR(250),propulsion VARCHAR(250),agevehicle TEXT);
LOAD DATA INFILE "\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\vehicle.project.csv"
INTO TABLE project.vehicle
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
;

-- What is the distribution of accident severity (Slight, Serious, Fatal)?
SELECT
severity,
count(severity)
FROM accident
GROUP BY severity
;

-- How does speed limit impact accident severity?
SELECT
speedlimit,
severity,
count(severity)
FROM accident
GROUP BY SpeedLimit, Severity
ORDER BY speedlimit DESC
;

-- What are the most dangerous weather and road conditions for accidents?
SELECT
weatherconditions,
roadconditions,
count(severity)
FROM accident
WHERE severity = 'fatal'
GROUP BY weatherconditions, roadconditions
ORDER BY count(severity) DESC
;

-- Which days of the week have the highest accident rates?
SELECT
day,
count(AccidentIndex) AS a_r
FROM accident
GROUP BY day
ORDER BY a_r DESC
LIMIT 1;

-- Which vehicle types are involved in the most accidents?
SELECT
vehicle_type,
count(vehicle_id) 
FROM vehicle
GROUP BY vehicle_type
ORDER BY count(vehicle_id) DESC
;

-- What is the relationship between vehicle age and accident severity?
SELECT
severity,
v.agevehicle
FROM accident AS a
RIGHT JOIN vehicle AS v 
ON a.accidentindex = v.accident_index
;

-- What are the most common points of impact in accidents?
SELECT
pointimpact,
COUNT(accident_index)
FROM vehicle
GROUP BY pointimpact
ORDER BY COUNT(accident_index) DESC
;

-- Are left-hand drive vehicles more likely to be in accidents?
SELECT
lefthand,
count(accident_index)
FROM vehicle

;

-- Are accidents more common in urban or rural areas?
SELECT
Area,
count(accidentindex)
FROM accident
GROUP BY area 
;

-- How do light conditions (Daylight vs. Darkness) affect accident severity?
SELECT
lightconditions,
severity,
count(accidentindex)
FROM accident
GROUP BY lightconditions, severity
ORDER BY lightconditions
;

-- Do certain weather conditions lead to higher accident severity?
SELECT
weatherconditions,
severity,
COUNT(accidentindex)
FROM accident
GROUP BY weatherconditions, severity
ORDER BY weatherconditions
;

-- What are the most common journey purposes for vehicles involved in accidents?
SELECT
journeypurpose,
count(accident_index)
FROM vehicle
GROUP BY journeypurpose
ORDER BY count(accident_index) DESC
;

-- Are work-related journeys more prone to severe accidents?
SELECT
journeypurpose,
a.severity,
COUNT(accidentindex)
FROM vehicle AS v
RIGHT JOIN accident AS a
ON a.accidentindex = v.Accident_Index
WHERE journeypurpose LIKE "%work%"
GROUP BY journeypurpose, a.severity
ORDER BY journeypurpose
;
SELECT*
FROM accident;
SELECT*
FROM vehicle;

SELECT
journeypurpose,
a.severity,
COUNT(accidentindex)
FROM accident AS a
RIGHT JOIN vehicle AS v
ON a.accidentindex = v.Accident_Index
WHERE journeypurpose LIKE "%work%"
GROUP BY journeypurpose, a.severity
ORDER BY journeypurpose
;

SELECT *
FROM accident;


-- How does the propulsion type (petrol, diesel, electric) impact accident rate?
SELECT
propulsion,
CONCAT(CEILING((COUNT(propulsion)/COUNT(*)) * 100), '%') AS percent
FROM vehicle
GROUP BY propulsion
;

SET sql_safe_updates = 0;

UPDATE accident
SET `Date` = str_to_date(Date, "%d/%m,/%Y")
;

ALTER table accident
ADD column `month` VARCHAR(10) AFTER `year`
;
UPDATE accident 
SET 
    `month` = MONTH(date);
    SELECT *
    FROM accident;

-- How has the number of accidents changed over time?

SELECT
month,
count(accidentindex)
FROM accident
GROUP BY month;
