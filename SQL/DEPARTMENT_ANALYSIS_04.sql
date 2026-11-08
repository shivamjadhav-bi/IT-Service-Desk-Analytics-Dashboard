USE it_service_desk;

-- 04.01 Department Ticket Volume
USE it_service_desk;

SELECT
    Department,
    COUNT(*) AS Ticket_Count,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM ticket_data_final),
        2
    ) AS Percentage
FROM ticket_data_final
GROUP BY Department
ORDER BY Ticket_Count DESC;
-- 04.02 Department Status & Resolution Performance

SELECT
    Department,

    COUNT(*) AS Total_Tickets,

    SUM(CASE
        WHEN Status = 'Resolved'
        THEN 1 ELSE 0
    END) AS Resolved_Tickets,

    SUM(CASE
        WHEN Status IN ('Open', 'Pending User', 'On Hold')
        THEN 1 ELSE 0
    END) AS Unresolved_Tickets,

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
    ) AS Avg_Resolution_Hours

FROM ticket_data_final
GROUP BY Department
ORDER BY Resolution_Rate_Percentage DESC;

-- 04.03 Department Priority / P1-P2 Analysis

SELECT
    Department,

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
GROUP BY Department
ORDER BY P1_P2_Tickets DESC;

-- 04.04 Department Unresolved Workload

SELECT
    Department,

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
GROUP BY Department
ORDER BY Unresolved_Tickets DESC;

-- 04.05 Department Overall Performance Summary

SELECT
    Department,

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
GROUP BY Department
ORDER BY Total_Tickets DESC;


