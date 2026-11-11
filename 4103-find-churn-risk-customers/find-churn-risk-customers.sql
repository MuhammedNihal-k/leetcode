# Write your MySQL query statement below

WITH user_summary AS (
    SELECT
        user_id,
        MIN(event_date) AS first_date,
        MAX(event_date) AS last_date,
        MAX(monthly_amount) AS max_historical_amount,
        MAX(CASE
            WHEN event_type = 'downgrade' THEN 1
            ELSE 0
        END) AS has_downgrade
    FROM subscription_events
    GROUP BY user_id
),

latest_event AS (
    SELECT
        user_id,
        event_type,
        plan_name,
        monthly_amount,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY event_date DESC, event_id DESC
        ) AS rn
    FROM subscription_events
)

SELECT
    l.user_id,
    l.plan_name AS current_plan,
    l.monthly_amount AS current_monthly_amount,
    u.max_historical_amount,
    DATEDIFF(u.last_date, u.first_date) AS days_as_subscriber
FROM latest_event l
JOIN user_summary u
    ON l.user_id = u.user_id
WHERE
    l.rn = 1
    AND l.event_type <> 'cancel'
    AND u.has_downgrade = 1
    AND l.monthly_amount < u.max_historical_amount * 0.5
    AND DATEDIFF(u.last_date, u.first_date) >= 60
ORDER BY
    days_as_subscriber DESC,
    l.user_id ASC;
