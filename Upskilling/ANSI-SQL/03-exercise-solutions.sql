-- =========================================================
-- ANSI SQL USING MYSQL
-- EXERCISE SOLUTIONS 1 TO 25
-- =========================================================

USE community_event_portal;


-- =========================================================
-- 1. USER UPCOMING EVENTS
-- Show upcoming events registered by users in their own city
-- =========================================================

SELECT
    u.user_id,
    u.full_name,
    u.city AS user_city,
    e.event_id,
    e.title,
    e.city AS event_city,
    e.start_date
FROM Users u
JOIN Registrations r
    ON u.user_id = r.user_id
JOIN Events e
    ON r.event_id = e.event_id
WHERE e.status = 'upcoming'
  AND u.city = e.city
ORDER BY e.start_date;


-- =========================================================
-- 2. TOP RATED EVENTS
-- Only events with at least 10 feedback entries
-- =========================================================

SELECT
    e.event_id,
    e.title,
    COUNT(f.feedback_id) AS total_feedbacks,
    ROUND(AVG(f.rating), 2) AS average_rating
FROM Events e
JOIN Feedback f
    ON e.event_id = f.event_id
GROUP BY
    e.event_id,
    e.title
HAVING COUNT(f.feedback_id) >= 10
ORDER BY average_rating DESC;


-- =========================================================
-- 3. INACTIVE USERS
-- No event registration during the last 90 days
-- =========================================================

SELECT
    u.user_id,
    u.full_name,
    u.email
FROM Users u
LEFT JOIN Registrations r
    ON u.user_id = r.user_id
    AND r.registration_date >= CURDATE() - INTERVAL 90 DAY
WHERE r.registration_id IS NULL;


-- =========================================================
-- 4. PEAK SESSION HOURS
-- Sessions starting between 10 AM and before 12 PM
-- =========================================================

SELECT
    e.event_id,
    e.title,
    COUNT(s.session_id) AS peak_hour_sessions
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
    AND TIME(s.start_time) >= '10:00:00'
    AND TIME(s.start_time) < '12:00:00'
GROUP BY
    e.event_id,
    e.title
ORDER BY peak_hour_sessions DESC;


-- =========================================================
-- 5. MOST ACTIVE CITIES
-- Top 5 event cities with distinct registered users
-- =========================================================

SELECT
    e.city,
    COUNT(DISTINCT r.user_id) AS distinct_registered_users
FROM Events e
JOIN Registrations r
    ON e.event_id = r.event_id
GROUP BY e.city
ORDER BY distinct_registered_users DESC
LIMIT 5;


-- =========================================================
-- 6. EVENT RESOURCE SUMMARY
-- Count PDFs, images and links for every event
-- =========================================================

SELECT
    e.event_id,
    e.title,
    SUM(CASE
        WHEN r.resource_type = 'pdf' THEN 1
        ELSE 0
    END) AS pdf_count,
    SUM(CASE
        WHEN r.resource_type = 'image' THEN 1
        ELSE 0
    END) AS image_count,
    SUM(CASE
        WHEN r.resource_type = 'link' THEN 1
        ELSE 0
    END) AS link_count,
    COUNT(r.resource_id) AS total_resources
FROM Events e
LEFT JOIN Resources r
    ON e.event_id = r.event_id
GROUP BY
    e.event_id,
    e.title;


-- =========================================================
-- 7. LOW FEEDBACK ALERTS
-- Users who gave ratings below 3
-- =========================================================

SELECT
    u.user_id,
    u.full_name,
    e.title AS event_name,
    f.rating,
    f.comments
FROM Feedback f
JOIN Users u
    ON f.user_id = u.user_id
JOIN Events e
    ON f.event_id = e.event_id
WHERE f.rating < 3
ORDER BY f.rating;


-- =========================================================
-- 8. SESSIONS PER UPCOMING EVENT
-- =========================================================

SELECT
    e.event_id,
    e.title,
    COUNT(s.session_id) AS session_count
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
WHERE e.status = 'upcoming'
GROUP BY
    e.event_id,
    e.title
ORDER BY session_count DESC;


-- =========================================================
-- 9. ORGANIZER EVENT SUMMARY
-- Count events by organizer and status
-- =========================================================

SELECT
    u.user_id AS organizer_id,
    u.full_name AS organizer_name,
    e.status,
    COUNT(e.event_id) AS total_events
FROM Users u
JOIN Events e
    ON u.user_id = e.organizer_id
GROUP BY
    u.user_id,
    u.full_name,
    e.status
ORDER BY
    u.full_name,
    e.status;


-- =========================================================
-- 10. FEEDBACK GAP
-- Events having registrations but no feedback
-- =========================================================

SELECT
    e.event_id,
    e.title,
    COUNT(DISTINCT r.registration_id) AS total_registrations
FROM Events e
JOIN Registrations r
    ON e.event_id = r.event_id
LEFT JOIN Feedback f
    ON e.event_id = f.event_id
GROUP BY
    e.event_id,
    e.title
HAVING COUNT(f.feedback_id) = 0;


-- =========================================================
-- 11. DAILY NEW USER COUNT
-- Users who created accounts during the last 7 days
-- =========================================================

SELECT
    registration_date,
    COUNT(user_id) AS new_user_count
FROM Users
WHERE registration_date >= CURDATE() - INTERVAL 7 DAY
GROUP BY registration_date
ORDER BY registration_date;


-- =========================================================
-- 12. EVENT WITH MAXIMUM SESSIONS
-- =========================================================

SELECT
    e.event_id,
    e.title,
    COUNT(s.session_id) AS session_count
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
GROUP BY
    e.event_id,
    e.title
HAVING COUNT(s.session_id) = (
    SELECT MAX(session_total)
    FROM (
        SELECT
            COUNT(s2.session_id) AS session_total
        FROM Events e2
        LEFT JOIN Sessions s2
            ON e2.event_id = s2.event_id
        GROUP BY e2.event_id
    ) AS session_counts
);


-- =========================================================
-- 13. AVERAGE RATING PER CITY
-- =========================================================

SELECT
    e.city,
    ROUND(AVG(f.rating), 2) AS average_rating
FROM Events e
JOIN Feedback f
    ON e.event_id = f.event_id
GROUP BY e.city
ORDER BY average_rating DESC;


-- =========================================================
-- 14. MOST REGISTERED EVENTS
-- Top 3 events
-- =========================================================

SELECT
    e.event_id,
    e.title,
    COUNT(r.registration_id) AS registration_count
FROM Events e
LEFT JOIN Registrations r
    ON e.event_id = r.event_id
GROUP BY
    e.event_id,
    e.title
ORDER BY registration_count DESC
LIMIT 3;


-- =========================================================
-- 15. EVENT SESSION TIME CONFLICT
-- Overlapping sessions within the same event
-- =========================================================

SELECT
    e.title AS event_name,
    s1.session_id AS first_session_id,
    s1.title AS first_session,
    s1.start_time AS first_start,
    s1.end_time AS first_end,
    s2.session_id AS second_session_id,
    s2.title AS second_session,
    s2.start_time AS second_start,
    s2.end_time AS second_end
FROM Sessions s1
JOIN Sessions s2
    ON s1.event_id = s2.event_id
    AND s1.session_id < s2.session_id
    AND s1.start_time < s2.end_time
    AND s2.start_time < s1.end_time
JOIN Events e
    ON s1.event_id = e.event_id;


-- =========================================================
-- 16. UNREGISTERED ACTIVE USERS
-- Accounts created in last 30 days with no event registration
-- =========================================================

SELECT
    u.user_id,
    u.full_name,
    u.email,
    u.registration_date
FROM Users u
LEFT JOIN Registrations r
    ON u.user_id = r.user_id
WHERE u.registration_date >= CURDATE() - INTERVAL 30 DAY
  AND r.registration_id IS NULL;


-- =========================================================
-- 17. MULTI-SESSION SPEAKERS
-- Speakers handling more than one session
-- =========================================================

SELECT
    speaker_name,
    COUNT(session_id) AS total_sessions
FROM Sessions
GROUP BY speaker_name
HAVING COUNT(session_id) > 1
ORDER BY total_sessions DESC;


-- =========================================================
-- 18. RESOURCE AVAILABILITY CHECK
-- Events without resources
-- =========================================================

SELECT
    e.event_id,
    e.title
FROM Events e
LEFT JOIN Resources r
    ON e.event_id = r.event_id
WHERE r.resource_id IS NULL;


-- =========================================================
-- 19. COMPLETED EVENTS WITH FEEDBACK SUMMARY
-- =========================================================

SELECT
    e.event_id,
    e.title,
    COUNT(DISTINCT r.registration_id) AS total_registrations,
    ROUND(AVG(f.rating), 2) AS average_rating
FROM Events e
LEFT JOIN Registrations r
    ON e.event_id = r.event_id
LEFT JOIN Feedback f
    ON e.event_id = f.event_id
WHERE e.status = 'completed'
GROUP BY
    e.event_id,
    e.title;


-- =========================================================
-- 20. USER ENGAGEMENT INDEX
-- Registrations used as attended-event count
-- =========================================================

SELECT
    u.user_id,
    u.full_name,
    COUNT(DISTINCT r.event_id) AS events_attended,
    COUNT(DISTINCT f.feedback_id) AS feedbacks_submitted
FROM Users u
LEFT JOIN Registrations r
    ON u.user_id = r.user_id
LEFT JOIN Feedback f
    ON u.user_id = f.user_id
GROUP BY
    u.user_id,
    u.full_name
ORDER BY
    events_attended DESC,
    feedbacks_submitted DESC;


-- =========================================================
-- 21. TOP FEEDBACK PROVIDERS
-- =========================================================

SELECT
    u.user_id,
    u.full_name,
    COUNT(f.feedback_id) AS feedback_count
FROM Users u
JOIN Feedback f
    ON u.user_id = f.user_id
GROUP BY
    u.user_id,
    u.full_name
ORDER BY feedback_count DESC
LIMIT 5;


-- =========================================================
-- 22. DUPLICATE REGISTRATIONS CHECK
-- =========================================================

SELECT
    user_id,
    event_id,
    COUNT(*) AS duplicate_count
FROM Registrations
GROUP BY
    user_id,
    event_id
HAVING COUNT(*) > 1;


-- =========================================================
-- 23. REGISTRATION TRENDS
-- Month-wise registrations during past 12 months
-- =========================================================

SELECT
    DATE_FORMAT(registration_date, '%Y-%m') AS registration_month,
    COUNT(registration_id) AS registration_count
FROM Registrations
WHERE registration_date >= CURDATE() - INTERVAL 12 MONTH
GROUP BY DATE_FORMAT(registration_date, '%Y-%m')
ORDER BY registration_month;


-- =========================================================
-- 24. AVERAGE SESSION DURATION PER EVENT
-- =========================================================

SELECT
    e.event_id,
    e.title,
    ROUND(
        AVG(
            TIMESTAMPDIFF(
                MINUTE,
                s.start_time,
                s.end_time
            )
        ),
        2
    ) AS average_session_duration_minutes
FROM Events e
JOIN Sessions s
    ON e.event_id = s.event_id
GROUP BY
    e.event_id,
    e.title
ORDER BY average_session_duration_minutes DESC;


-- =========================================================
-- 25. EVENTS WITHOUT SESSIONS
-- =========================================================

SELECT
    e.event_id,
    e.title,
    e.status
FROM Events e
LEFT JOIN Sessions s
    ON e.event_id = s.event_id
WHERE s.session_id IS NULL;