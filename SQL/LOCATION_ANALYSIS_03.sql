USE it_service_desk;

-- ============================================================
-- SECTION 03: LOCATION ANALYSIS
-- ============================================================


-- 03.01 Location × Priority Analysis
SELECT
    Location,
    Priority,
    COUNT(*) AS Ticket_Count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Location),
        2
    ) AS Percentage_Within_Location
FROM ticket_data_final
GROUP BY Location, Priority
ORDER BY
    Location,
    CASE Priority
        WHEN 'P1' THEN 1
        WHEN 'P2' THEN 2
        WHEN 'P3' THEN 3
        WHEN 'P4' THEN 4
        ELSE 5
    END;


-- 03.02 Location × Status Analysis
SELECT
    Location,
    Status,
    COUNT(*) AS Ticket_Count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Location),
        2
    ) AS Percentage_Within_Location
FROM ticket_data_final
GROUP BY Location, Status
ORDER BY
    Location,
    Ticket_Count DESC;


-- 03.03 Location-wise Open / Pending / On Hold Tickets
SELECT
    Location,
    COUNT(*) AS Total_Tickets,

    SUM(CASE
        WHEN Status = 'Open'
        THEN 1 ELSE 0
    END) AS Open_Tickets,

    SUM(CASE
        WHEN Status = 'Pending User'
        THEN 1 ELSE 0
    END) AS Pending_User_Tickets,

    SUM(CASE
        WHEN Status = 'On Hold'
        THEN 1 ELSE 0
    END) AS On_Hold_Tickets,

    SUM(CASE
        WHEN Status IN ('Open', 'Pending User', 'On Hold')
        THEN 1 ELSE 0
    END) AS Unresolved_Tickets,

    ROUND(
        SUM(CASE
            WHEN Status IN ('Open', 'Pending User', 'On Hold')
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS Unresolved_Rate_Percentage

FROM ticket_data_final
GROUP BY Location
ORDER BY Unresolved_Tickets DESC;


-- 03.04 Location-wise P1 / P2 Critical Tickets
SELECT
    Location,

    COUNT(*) AS Total_Tickets,

    SUM(CASE
        WHEN Priority = 'P1'
        THEN 1 ELSE 0
    END) AS P1_Tickets,

    SUM(CASE
        WHEN Priority = 'P2'
        THEN 1 ELSE 0
    END) AS P2_Tickets,

    SUM(CASE
        WHEN Priority IN ('P1', 'P2')
        THEN 1 ELSE 0
    END) AS P1_P2_Tickets,

    ROUND(
        SUM(CASE
            WHEN Priority IN ('P1', 'P2')
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS P1_P2_Percentage

FROM ticket_data_final
GROUP BY Location
ORDER BY P1_P2_Tickets DESC;


-- 03.05 Location-wise Resolution Performance
SELECT
    Location,

    COUNT(*) AS Total_Tickets,

    SUM(CASE
        WHEN Status = 'Resolved'
        THEN 1 ELSE 0
    END) AS Resolved_Tickets,

    ROUND(
        SUM(CASE
            WHEN Status = 'Resolved'
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS Resolution_Rate_Percentage,

    ROUND(
        AVG(CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NOT NULL
            THEN Resolution_Hours
        END),
        2
    ) AS Avg_Resolution_Hours,

    SUM(CASE
        WHEN Status = 'Resolved'
             AND Resolution_Hours IS NULL
        THEN 1 ELSE 0
    END) AS Resolved_Missing_Resolution_Time

FROM ticket_data_final
GROUP BY Location
ORDER BY Resolution_Rate_Percentage DESC;


-- 03.06 Location-wise Resolution Time Performance
SELECT
    Location,

    COUNT(CASE
        WHEN Status = 'Resolved'
             AND Resolution_Hours IS NOT NULL
        THEN 1
    END) AS Resolved_Tickets_With_Time,

    ROUND(
        MIN(CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NOT NULL
            THEN Resolution_Hours
        END),
        2
    ) AS Min_Resolution_Hours,

    ROUND(
        AVG(CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NOT NULL
            THEN Resolution_Hours
        END),
        2
    ) AS Avg_Resolution_Hours,

    ROUND(
        MAX(CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NOT NULL
            THEN Resolution_Hours
        END),
        2
    ) AS Max_Resolution_Hours

FROM ticket_data_final
GROUP BY Location
ORDER BY Avg_Resolution_Hours DESC;


-- 03.07 Location-wise Overall Performance Summary
SELECT
    Location,

    COUNT(*) AS Total_Tickets,

    SUM(CASE
        WHEN Status = 'Resolved'
        THEN 1 ELSE 0
    END) AS Resolved_Tickets,

    SUM(CASE
        WHEN Status IN ('Open', 'Pending User', 'On Hold')
        THEN 1 ELSE 0
    END) AS Unresolved_Tickets,

    SUM(CASE
        WHEN Priority IN ('P1', 'P2')
        THEN 1 ELSE 0
    END) AS P1_P2_Tickets,

    ROUND(
        SUM(CASE
            WHEN Status = 'Resolved'
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS Resolution_Rate_Percentage,

    ROUND(
        SUM(CASE
            WHEN Status IN ('Open', 'Pending User', 'On Hold')
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS Unresolved_Rate_Percentage,

    ROUND(
        AVG(CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NOT NULL
            THEN Resolution_Hours
        END),
        2
    ) AS Avg_Resolution_Hours

FROM ticket_data_final
GROUP BY Location
ORDER BY Total_Tickets DESC;


-- ============================================================
-- END OF SECTION 03
-- ============================================================