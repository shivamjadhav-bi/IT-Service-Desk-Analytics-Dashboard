USE it_service_desk;
-- 07.01 Overall SLA Compliance

SELECT
    COUNT(*) AS Resolved_Tickets_With_SLA_Data,

    SUM(
        CASE
            WHEN Priority = 'P1' AND Resolution_Hours <= 4 THEN 1
            WHEN Priority = 'P2' AND Resolution_Hours <= 8 THEN 1
            WHEN Priority = 'P3' AND Resolution_Hours <= 24 THEN 1
            WHEN Priority = 'P4' AND Resolution_Hours <= 48 THEN 1
            ELSE 0
        END
    ) AS SLA_Met_Tickets,

    SUM(
        CASE
            WHEN Priority = 'P1' AND Resolution_Hours > 4 THEN 1
            WHEN Priority = 'P2' AND Resolution_Hours > 8 THEN 1
            WHEN Priority = 'P3' AND Resolution_Hours > 24 THEN 1
            WHEN Priority = 'P4' AND Resolution_Hours > 48 THEN 1
            ELSE 0
        END
    ) AS SLA_Breached_Tickets,

    ROUND(
        SUM(
            CASE
                WHEN Priority = 'P1' AND Resolution_Hours <= 4 THEN 1
                WHEN Priority = 'P2' AND Resolution_Hours <= 8 THEN 1
                WHEN Priority = 'P3' AND Resolution_Hours <= 24 THEN 1
                WHEN Priority = 'P4' AND Resolution_Hours <= 48 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS SLA_Compliance_Percentage

FROM ticket_data_final

WHERE Status = 'Resolved'
  AND Resolution_Hours IS NOT NULL;
  
  -- 07.02 SLA Performance by Priority

SELECT
    Priority,

    COUNT(*) AS Resolved_Tickets,

    SUM(
        CASE
            WHEN Priority = 'P1' AND Resolution_Hours <= 4 THEN 1
            WHEN Priority = 'P2' AND Resolution_Hours <= 8 THEN 1
            WHEN Priority = 'P3' AND Resolution_Hours <= 24 THEN 1
            WHEN Priority = 'P4' AND Resolution_Hours <= 48 THEN 1
            ELSE 0
        END
    ) AS SLA_Met_Tickets,

    SUM(
        CASE
            WHEN Priority = 'P1' AND Resolution_Hours > 4 THEN 1
            WHEN Priority = 'P2' AND Resolution_Hours > 8 THEN 1
            WHEN Priority = 'P3' AND Resolution_Hours > 24 THEN 1
            WHEN Priority = 'P4' AND Resolution_Hours > 48 THEN 1
            ELSE 0
        END
    ) AS SLA_Breached_Tickets,

    ROUND(
        SUM(
            CASE
                WHEN Priority = 'P1' AND Resolution_Hours <= 4 THEN 1
                WHEN Priority = 'P2' AND Resolution_Hours <= 8 THEN 1
                WHEN Priority = 'P3' AND Resolution_Hours <= 24 THEN 1
                WHEN Priority = 'P4' AND Resolution_Hours <= 48 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS SLA_Compliance_Percentage

FROM ticket_data_final

WHERE Status = 'Resolved'
  AND Resolution_Hours IS NOT NULL

GROUP BY Priority

ORDER BY Priority;

-- 07.03 SLA Performance by Location

SELECT
    Location,

    COUNT(*) AS Resolved_Tickets,

    SUM(
        CASE
            WHEN Priority = 'P1' AND Resolution_Hours <= 4 THEN 1
            WHEN Priority = 'P2' AND Resolution_Hours <= 8 THEN 1
            WHEN Priority = 'P3' AND Resolution_Hours <= 24 THEN 1
            WHEN Priority = 'P4' AND Resolution_Hours <= 48 THEN 1
            ELSE 0
        END
    ) AS SLA_Met_Tickets,

    SUM(
        CASE
            WHEN Priority = 'P1' AND Resolution_Hours > 4 THEN 1
            WHEN Priority = 'P2' AND Resolution_Hours > 8 THEN 1
            WHEN Priority = 'P3' AND Resolution_Hours > 24 THEN 1
            WHEN Priority = 'P4' AND Resolution_Hours > 48 THEN 1
            ELSE 0
        END
    ) AS SLA_Breached_Tickets,

    ROUND(
        SUM(
            CASE
                WHEN Priority = 'P1' AND Resolution_Hours <= 4 THEN 1
                WHEN Priority = 'P2' AND Resolution_Hours <= 8 THEN 1
                WHEN Priority = 'P3' AND Resolution_Hours <= 24 THEN 1
                WHEN Priority = 'P4' AND Resolution_Hours <= 48 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS SLA_Compliance_Percentage

FROM ticket_data_final

WHERE Status = 'Resolved'
  AND Resolution_Hours IS NOT NULL

GROUP BY Location

ORDER BY SLA_Compliance_Percentage DESC;

-- 07.04 Overall SLA Summary

SELECT
    COUNT(*) AS Resolved_Tickets_With_SLA_Data,

    SUM(
        CASE
            WHEN Priority = 'P1' AND Resolution_Hours <= 4 THEN 1
            WHEN Priority = 'P2' AND Resolution_Hours <= 8 THEN 1
            WHEN Priority = 'P3' AND Resolution_Hours <= 24 THEN 1
            WHEN Priority = 'P4' AND Resolution_Hours <= 48 THEN 1
            ELSE 0
        END
    ) AS SLA_Met_Tickets,

    SUM(
        CASE
            WHEN Priority = 'P1' AND Resolution_Hours > 4 THEN 1
            WHEN Priority = 'P2' AND Resolution_Hours > 8 THEN 1
            WHEN Priority = 'P3' AND Resolution_Hours > 24 THEN 1
            WHEN Priority = 'P4' AND Resolution_Hours > 48 THEN 1
            ELSE 0
        END
    ) AS SLA_Breached_Tickets,

    ROUND(
        SUM(
            CASE
                WHEN Priority = 'P1' AND Resolution_Hours <= 4 THEN 1
                WHEN Priority = 'P2' AND Resolution_Hours <= 8 THEN 1
                WHEN Priority = 'P3' AND Resolution_Hours <= 24 THEN 1
                WHEN Priority = 'P4' AND Resolution_Hours <= 48 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS SLA_Compliance_Percentage,

    ROUND(
        SUM(
            CASE
                WHEN Priority = 'P1' AND Resolution_Hours > 4 THEN 1
                WHEN Priority = 'P2' AND Resolution_Hours > 8 THEN 1
                WHEN Priority = 'P3' AND Resolution_Hours > 24 THEN 1
                WHEN Priority = 'P4' AND Resolution_Hours > 48 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS SLA_Breach_Percentage

FROM ticket_data_final

WHERE Status = 'Resolved'
  AND Resolution_Hours IS NOT NULL;