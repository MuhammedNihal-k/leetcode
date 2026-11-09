SELECT
    session_id,
    user_id,

    TIMESTAMPDIFF(
        MINUTE,
        MIN(event_timestamp),
        MAX(event_timestamp)
    ) AS session_duration_minutes,

    SUM(
        CASE
            WHEN event_type = 'scroll' THEN 1
            ELSE 0
        END
    ) AS scroll_count

FROM app_events

GROUP BY user_id, session_id

HAVING
    session_duration_minutes > 30

    AND scroll_count >= 5

    AND (
        SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) * 1.0
        / NULLIF(scroll_count, 0)
    ) < 0.20

    AND SUM(
        CASE
            WHEN event_type = 'purchase' THEN 1
            ELSE 0
        END
    ) = 0

ORDER BY
    scroll_count DESC,
    session_id ASC;