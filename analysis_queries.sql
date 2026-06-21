-- ============================================================
-- LinkedIn Portfolio - SQL data analysis
-- Demonstrates SELECT, JOINs, aggregates, subqueries, and UNIONs.
-- ============================================================

/*
1. BASIC USER OVERVIEW (Table: users)

-- Get all active users in the system
-- Purpose: Fetch all active users
-- Logic: Filters only users who can access the platform
*/

SELECT id, email, username, created_at, last_login_at
FROM users
WHERE is_active = TRUE;

/*
2. FULL PROFILE VIEW (JOIN: users + user_profiles)

-- Combine login data with public profile
-- Purpose: Build complete user profile view
-- Logic: JOIN users with user_profiles using user_id
*/

SELECT 
    u.id,
    u.email,
    u.username,
    p.first_name,
    p.last_name,
    p.headline,
    p.location,
    p.visibility
FROM users u
JOIN user_profiles p ON u.id = p.user_id;

/*
3. EXPERIENCE ANALYSIS (GROUP + COUNT)

-- Count number of experiences per user
-- Purpose: Find how experienced each user is
-- Logic: Count work experiences grouped by user
*/

SELECT 
    user_id,
    COUNT(*) AS total_experiences
FROM work_experiences
GROUP BY user_id;

/*
4. EDUCATION + SKILLS COMBINATION (JOIN + GROUP)

-- Analyze academic + skill distribution
-- Purpose: Compare education level with skill count
-- Logic: Join education and skills per user
*/

SELECT 
    u.id,
    p.first_name,
    COUNT(DISTINCT e.id) AS education_count,
    COUNT(DISTINCT s.id) AS skill_count
FROM users u
LEFT JOIN user_profiles p ON u.id = p.user_id
LEFT JOIN education_records e ON u.id = e.user_id
LEFT JOIN skills s ON u.id = s.user_id
GROUP BY u.id, p.first_name;

/*
5. CERTIFICATION INSIGHTS

-- Most popular issuing organizations
-- Purpose: Analyze certification sources
-- Logic: Group certifications by organization
*/

SELECT 
    issuing_organization,
    COUNT(*) AS total_certifications
FROM certifications
GROUP BY issuing_organization
ORDER BY total_certifications DESC;

/*
6. CURRENT JOB HOLDERS

-- Find users currently working
-- Purpose: Identify users with active job roles
-- Logic: Filter is_current_position = true
*/

SELECT 
    u.id,
    p.first_name,
    p.last_name,
    w.company_name,
    w.job_title
FROM users u
JOIN user_profiles p ON u.id = p.user_id
JOIN work_experiences w ON u.id = w.user_id
WHERE w.is_current_position = TRUE;

/*
7. TOP SKILLS ANALYSIS (AGGREGATE)

-- Find most common skills in platform
-- Purpose: Identify popular skills
-- Logic: Count occurrences of each skill
*/

SELECT 
    skill_name,
    COUNT(*) AS total_users
FROM skills
GROUP BY skill_name
ORDER BY total_users DESC;

/*
8. PROJECTS ANALYSIS

-- Users with most projects
-- Purpose: Find most project-active users
-- Logic: Count projects per user
*/

SELECT 
    user_id,
    COUNT(*) AS total_projects
FROM projects
GROUP BY user_id
ORDER BY total_projects DESC;

/*
9. FULL CAREER SNAPSHOT (DETAILED JOIN)

-- Complete AI Engineer profile summary
-- Purpose: Build full career dashboard
-- Logic: Combine all tables for one user view
*/

SELECT 
    u.id,
    p.first_name,
    p.last_name,
    p.headline,
    COUNT(DISTINCT w.id) AS experiences,
    COUNT(DISTINCT e.id) AS education_records,
    COUNT(DISTINCT s.id) AS skills,
    COUNT(DISTINCT c.id) AS certifications,
    COUNT(DISTINCT pr.id) AS projects
FROM users u
LEFT JOIN user_profiles p ON u.id = p.user_id
LEFT JOIN work_experiences w ON u.id = w.user_id
LEFT JOIN education_records e ON u.id = e.user_id
LEFT JOIN skills s ON u.id = s.user_id
LEFT JOIN certifications c ON u.id = c.user_id
LEFT JOIN projects pr ON u.id = pr.user_id
GROUP BY u.id, p.first_name, p.last_name, p.headline;

/*
10. UNION QUERY (SKILLS + CERTIFICATIONS KEYWORD VIEW)

-- Create a unified “resume keywords” dataset
-- Purpose: Combine skills and certifications into one list
-- Logic: UNION removes duplicates and merges knowledge areas
*/

SELECT skill_name AS keyword
FROM skills

UNION

SELECT certification_name AS keyword
FROM certifications;