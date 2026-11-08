USE it_service_desk;
-- 02.01 Check total ticket resolution overview
SELECT
    Status,
    COUNT(*) AS Ticket_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ticket_data_final), 2) AS Percentage
FROM ticket_data_final
GROUP BY Status
ORDER BY Ticket_Count DESC;
-- 02.02 Resolution Status Breakdown
SELECT
    Status,
    COUNT(*) AS Ticket_Count,
    SUM(CASE WHEN Resolution_Hours IS NULL THEN 1 ELSE 0 END) AS Missing_Resolution_Hours,
    ROUND(AVG(Resolution_Hours), 2) AS Avg_Resolution_Hours
FROM ticket_data_final
GROUP BY Status
ORDER BY Ticket_Count DESC;
-- 02.03 Resolution Performance by Priority
SELECT
    Priority,
    COUNT(*) AS Ticket_Count,
    SUM(CASE WHEN Status = 'Resolved' THEN 1 ELSE 0 END) AS Resolved_Tickets,
    ROUND(
        SUM(CASE WHEN Status = 'Resolved' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS Resolution_Rate_Percentage,
    ROUND(AVG(
        CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NOT NULL
            THEN Resolution_Hours
        END
    ), 2) AS Avg_Resolution_Hours
FROM ticket_data_final
GROUP BY Priority
ORDER BY
    CASE Priority
        WHEN 'P1' THEN 1
        WHEN 'P2' THEN 2
        WHEN 'P3' THEN 3
        WHEN 'P4' THEN 4
        ELSE 5
    END;
    
--  02.04 Priority-wise Ticket Status
SELECT
    Priority,
    Status,
    COUNT(*) AS Ticket_Count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (PARTITION BY Priority),
        2
    ) AS Percentage_Within_Priority
FROM ticket_data_final
GROUP BY Priority, Status
ORDER BY
    CASE Priority
        WHEN 'P1' THEN 1
        WHEN 'P2' THEN 2
        WHEN 'P3' THEN 3
        WHEN 'P4' THEN 4
        ELSE 5
    END,
    Ticket_Count DESC;
    
-- 02.05: Ticket Volume by Location
SELECT
    Location,
    COUNT(*) AS Ticket_Count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM ticket_data_final),
        2
    ) AS Percentage
FROM ticket_data_final
GROUP BY Location
ORDER BY Ticket_Count DESC;

-- 02.06: Location-wise Resolution Performance
SELECT
    Location,
    COUNT(*) AS Ticket_Count,
    SUM(CASE WHEN Status = 'Resolved' THEN 1 ELSE 0 END) AS Resolved_Tickets,
    ROUND(
        SUM(CASE WHEN Status = 'Resolved' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS Resolution_Rate_Percentage,
    ROUND(
        AVG(
            CASE
                WHEN Status = 'Resolved'
                     AND Resolution_Hours IS NOT NULL
                THEN Resolution_Hours
            END
        ),
        2
    ) AS Avg_Resolution_Hours
FROM ticket_data_final
GROUP BY Location
ORDER BY Ticket_Count DESC;
-- Overall Resolution Metrics
SELECT
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

    SUM(CASE
        WHEN Status = 'Resolved'
             AND Resolution_Hours IS NOT NULL
        THEN 1 ELSE 0
    END) AS Resolved_With_Resolution_Time,

    SUM(CASE
        WHEN Status = 'Resolved'
             AND Resolution_Hours IS NULL
        THEN 1 ELSE 0
    END) AS Resolved_Missing_Resolution_Time,

    ROUND(
        AVG(CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NOT NULL
            THEN Resolution_Hours
        END),
        2
    ) AS Avg_Resolution_Hours

FROM ticket_data_final;