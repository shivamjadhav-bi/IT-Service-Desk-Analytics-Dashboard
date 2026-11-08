USE it_service_desk;

-- ============================================================
-- 06.01 Engineer-wise Ticket Volume & Resolution Performance
-- ============================================================

SELECT
    Assigned_Engineer,

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
GROUP BY Assigned_Engineer
ORDER BY Total_Tickets DESC;


-- ============================================================
-- 06.02 Engineer-wise P1/P2 Critical Ticket Workload
-- ============================================================

SELECT
    Assigned_Engineer,

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
GROUP BY Assigned_Engineer
ORDER BY P1_P2_Tickets DESC;


-- ============================================================
-- 06.03 Engineer-wise Unresolved Workload
-- ============================================================

SELECT
    Assigned_Engineer,

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
GROUP BY Assigned_Engineer
ORDER BY Unresolved_Tickets DESC;


-- ============================================================
-- 06.04 Engineer Overall Performance Summary
-- ============================================================

SELECT
    Assigned_Engineer,

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
        AVG(CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NOT NULL
            THEN Resolution_Hours
        END),
        2
    ) AS Avg_Resolution_Hours

FROM ticket_data_final
GROUP BY Assigned_Engineer
ORDER BY Total_Tickets DESC;