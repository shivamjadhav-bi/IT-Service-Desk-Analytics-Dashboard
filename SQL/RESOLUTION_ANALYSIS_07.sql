-- 08.01 Overall Resolution Time Analysis

SELECT
    COUNT(*) AS Resolved_Tickets_With_Time,

    ROUND(MIN(Resolution_Hours), 2) AS Minimum_Resolution_Hours,

    ROUND(AVG(Resolution_Hours), 2) AS Average_Resolution_Hours,

    ROUND(MAX(Resolution_Hours), 2) AS Maximum_Resolution_Hours,

    ROUND(
        SUM(CASE
            WHEN Resolution_Hours <= 24 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS Resolved_Within_24_Hours_Percentage,

    ROUND(
        SUM(CASE
            WHEN Resolution_Hours <= 48 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS Resolved_Within_48_Hours_Percentage

FROM ticket_data_final

WHERE Status = 'Resolved'
  AND Resolution_Hours IS NOT NULL;
  
-- 08.02 Resolution Time by Priority

SELECT
    Priority,

    COUNT(*) AS Resolved_Tickets,

    ROUND(MIN(Resolution_Hours), 2) AS Minimum_Resolution_Hours,

    ROUND(AVG(Resolution_Hours), 2) AS Average_Resolution_Hours,

    ROUND(MAX(Resolution_Hours), 2) AS Maximum_Resolution_Hours,

    ROUND(
        SUM(
            CASE
                WHEN Resolution_Hours <= 24 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Resolved_Within_24_Hours_Percentage

FROM ticket_data_final

WHERE Status = 'Resolved'
  AND Resolution_Hours IS NOT NULL

GROUP BY Priority

ORDER BY Priority;

-- 08.03 Resolution Time by Department

SELECT
    Department,

    COUNT(*) AS Resolved_Tickets,

    ROUND(MIN(Resolution_Hours), 2) AS Minimum_Resolution_Hours,

    ROUND(AVG(Resolution_Hours), 2) AS Average_Resolution_Hours,

    ROUND(MAX(Resolution_Hours), 2) AS Maximum_Resolution_Hours,

    ROUND(
        SUM(
            CASE
                WHEN Resolution_Hours <= 24 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Resolved_Within_24_Hours_Percentage

FROM ticket_data_final

WHERE Status = 'Resolved'
  AND Resolution_Hours IS NOT NULL

GROUP BY Department

ORDER BY Average_Resolution_Hours;

-- 08.04 Overall Resolution Summary

SELECT
    COUNT(*) AS Total_Tickets,
    SUM(CASE WHEN Status = 'Resolved' THEN 1 ELSE 0 END) AS Resolved_Tickets,
    SUM(
        CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NOT NULL
            THEN 1
            ELSE 0
        END
    ) AS Resolved_With_Resolution_Time,
    SUM(
        CASE
            WHEN Status = 'Resolved'
                 AND Resolution_Hours IS NULL
            THEN 1
            ELSE 0
        END
    ) AS Resolved_Missing_Resolution_Time,
    ROUND(
        AVG(
            CASE
                WHEN Status = 'Resolved'
                     AND Resolution_Hours IS NOT NULL
                THEN Resolution_Hours
            END
        ),
        2
    ) AS Average_Resolution_Hours,
    ROUND(
        MIN(
            CASE
                WHEN Status = 'Resolved'
                     AND Resolution_Hours IS NOT NULL
                THEN Resolution_Hours
            END
        ),
        2
    ) AS Minimum_Resolution_Hours,
    ROUND(
        MAX(
            CASE
                WHEN Status = 'Resolved'
                     AND Resolution_Hours IS NOT NULL
                THEN Resolution_Hours
            END
        ),
        2
    ) AS Maximum_Resolution_Hours,
    ROUND(
        SUM(
            CASE
                WHEN Status = 'Resolved'
                     AND Resolution_Hours IS NOT NULL
                     AND Resolution_Hours <= 24
                THEN 1
                ELSE 0
            END
        ) * 100.0
        /
        SUM(
            CASE
                WHEN Status = 'Resolved'
                     AND Resolution_Hours IS NOT NULL
                THEN 1
                ELSE 0
            END
        ),
        2
    ) AS Resolved_Within_24_Hours_Percentage
FROM ticket_data_final;
  
