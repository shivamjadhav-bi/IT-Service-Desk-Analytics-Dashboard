USE it_service_desk;
-- =====================================================
-- IT SERVICE DESK ANALYTICS PROJECT
-- SQL ANALYSIS
-- SECTION 01 - DATA VALIDATION
-- Main Table: ticket_data_final
-- =====================================================


-- 01.1 Check total number of tickets
SELECT
    COUNT(*) AS Total_Tickets
FROM ticket_data_final;


-- 01.2 Check duplicate Ticket IDs
SELECT
    Ticket_ID,
    COUNT(*) AS Duplicate_Count
FROM ticket_data_final
GROUP BY Ticket_ID
HAVING COUNT(*) > 1;


-- 01.3 Check NULL Ticket IDs
SELECT
    COUNT(*) AS Missing_Ticket_ID
FROM ticket_data_final
WHERE Ticket_ID IS NULL
   OR TRIM(Ticket_ID) = '';


-- 01.4 Check NULL values in important fields
SELECT
    SUM(CASE WHEN Ticket_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Ticket_ID,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS Missing_Location,
    SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS Missing_Department,
    SUM(CASE WHEN Priority IS NULL THEN 1 ELSE 0 END) AS Missing_Priority,
    SUM(CASE WHEN Status IS NULL THEN 1 ELSE 0 END) AS Missing_Status,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS Missing_Category,
    SUM(CASE WHEN Assigned_Engineer IS NULL THEN 1 ELSE 0 END) AS Missing_Engineer
FROM ticket_data_final;


-- 01.5 Check ticket status distribution
SELECT
    Status,
    COUNT(*) AS Ticket_Count
FROM ticket_data_final
GROUP BY Status
ORDER BY Ticket_Count DESC;


-- 01.6 Check priority distribution
SELECT
    Priority,
    COUNT(*) AS Ticket_Count
FROM ticket_data_final
GROUP BY Priority
ORDER BY Ticket_Count DESC;


-- 01.7 Check location distribution
SELECT
    Location,
    COUNT(*) AS Ticket_Count
FROM ticket_data_final
GROUP BY Location
ORDER BY Ticket_Count DESC;


-- 01.8 Check department distribution
SELECT
    Department,
    COUNT(*) AS Ticket_Count
FROM ticket_data_final
GROUP BY Department
ORDER BY Ticket_Count DESC;


-- 01.9 Check Data Quality Status
SELECT
    Data_Quality_Status,
    COUNT(*) AS Ticket_Count
FROM ticket_data_final
GROUP BY Data_Quality_Status
ORDER BY Ticket_Count DESC;


-- 01.10 Check missing Resolution Hours
SELECT
    COUNT(*) AS Missing_Resolution_Hours
FROM ticket_data_final
WHERE Resolution_Hours IS NULL;


-- 01.11 Check missing Resolved Date Time
SELECT
    COUNT(*) AS Missing_Resolved_Date_Time
FROM ticket_data_final
WHERE Resolved_Date_Time IS NULL;


-- 01.12 Check date range of the dataset
SELECT
    MIN(Created_Date) AS Earliest_Ticket_Date,
    MAX(Created_Date) AS Latest_Ticket_Date
FROM ticket_data_final;


-- 01.13 Check for invalid negative Resolution Hours
SELECT
    COUNT(*) AS Negative_Resolution_Hours
FROM ticket_data_final
WHERE Resolution_Hours < 0;


-- 01.14 Check SLA Status distribution
SELECT
    SLA_Status,
    COUNT(*) AS Ticket_Count
FROM ticket_data_final
GROUP BY SLA_Status
ORDER BY Ticket_Count DESC;