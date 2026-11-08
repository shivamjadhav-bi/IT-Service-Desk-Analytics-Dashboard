USE it_service_desk;

-- 09.01 Power BI Data Validation

SELECT
    COUNT(*) AS Total_Tickets,
    COUNT(DISTINCT Ticket_ID) AS Unique_Ticket_IDs,
    MIN(Created_Date_Time) AS First_Ticket_Date,
    MAX(Created_Date_Time) AS Last_Ticket_Date
FROM ticket_data_final;

-- 09.02 Power BI Key Column Check

SELECT
    COUNT(*) AS Total_Tickets,
    SUM(CASE WHEN Ticket_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Ticket_ID,
    SUM(CASE WHEN Created_Date_Time IS NULL THEN 1 ELSE 0 END) AS Missing_Created_Date,
    SUM(CASE WHEN Location IS NULL THEN 1 ELSE 0 END) AS Missing_Location,
    SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS Missing_Department,
    SUM(CASE WHEN Priority IS NULL THEN 1 ELSE 0 END) AS Missing_Priority,
    SUM(CASE WHEN Status IS NULL THEN 1 ELSE 0 END) AS Missing_Status,
    SUM(CASE WHEN Assigned_Engineer IS NULL THEN 1 ELSE 0 END) AS Missing_Engineer
FROM ticket_data_final;

-- 09.03 Power BI Resolution Data Check

SELECT
    COUNT(*) AS Total_Tickets,

    SUM(
        CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NOT NULL
            THEN 1 ELSE 0
        END
    ) AS Resolved_With_Resolution_Time,

    SUM(
        CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NULL
            THEN 1 ELSE 0
        END
    ) AS Resolved_Missing_Resolution_Time,

    SUM(
        CASE
            WHEN Status <> 'Resolved'
                 AND Resolution_Hours IS NULL
            THEN 1 ELSE 0
        END
    ) AS Unresolved_Missing_Resolution_Time,

    SUM(
        CASE
            WHEN Status = 'Resolved'
                 AND Resolved_Date_Time IS NULL
            THEN 1 ELSE 0
        END
    ) AS Resolved_Missing_Resolved_Date_Time
FROM ticket_data_final;

-- 09.04 Create Power BI Analytical View

CREATE OR REPLACE VIEW vw_it_service_desk_powerbi AS
SELECT
    Ticket_ID,
    Created_Date_Time,
    Resolved_Date_Time,
    Location,
    Department,
    Priority,
    Status,
    Category,
    Assigned_Engineer,
    Resolution_Hours
FROM ticket_data_final;

SELECT COUNT(*) AS PowerBI_View_Tickets
FROM vw_it_service_desk_powerbi;