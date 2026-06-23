-- ENUM types for fixed values

CREATE TYPE employment_type AS ENUM (
    'full_time',
    'part_time',
    'contract',
    'freelance',
    'internship'
);

CREATE TYPE visibility_level AS ENUM (
    'public',
    'connections',
    'private'
);

CREATE TYPE proficiency_level AS ENUM (
    'beginner',
    'intermediate',
    'advanced',
    'expert'
);

/*
====================================================
TABLE: users
====================================================

Purpose:
Stores account and authentication information
for every user on the platform.

Why this table exists:
A user needs an account to log in and access
the LinkedIn-style portfolio platform.

Stores:
- Email
- Username
- Password Hash
- Account Status
- Login Information

Relationship:
One user can have one profile stored in the
user_profiles table.

====================================================
*/

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    last_login_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_is_active ON users(is_active);

/*
====================================================
TABLE: user_profiles
====================================================

Purpose:
Stores public profile information displayed
on a user's portfolio page.

Why this table exists:
Separates profile information from account
information to keep the database organized
and scalable.

Stores:
- Name
- Headline
- Bio
- Location
- Website
- Profile Picture
- Visibility Settings

Relationship:
Each profile belongs to exactly one user
through user_id.

users.id → user_profiles.user_id

====================================================
*/

CREATE TABLE user_profiles (
    id SERIAL PRIMARY KEY,
    user_id INTEGER UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    headline VARCHAR(220),
    about TEXT,
    location VARCHAR(255),
    website_url VARCHAR(500),
    profile_picture_url VARCHAR(500),
    cover_image_url VARCHAR(500),
    is_open_to_opportunities BOOLEAN DEFAULT FALSE,
    visibility visibility_level DEFAULT 'public',
    phone_number VARCHAR(20),

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE INDEX idx_user_profiles_user_id ON user_profiles(user_id);
CREATE INDEX idx_user_profiles_full_name ON user_profiles(first_name, last_name);

/*
====================================================
TABLE: work_experiences
====================================================

Purpose:
Stores the professional work experience of users.

Why this table exists:
Allows users to showcase current and
previous job positions.

Relationship:
One user can have multiple work experiences.

users.id → work_experiences.user_id
====================================================
*/

CREATE TABLE work_experiences (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    company_name VARCHAR(255) NOT NULL,
    job_title VARCHAR(255) NOT NULL,
    employment_type employment_type DEFAULT 'full_time',
    location VARCHAR(255),
    start_date DATE NOT NULL,
    end_date DATE,
    is_current_position BOOLEAN DEFAULT FALSE,
    description TEXT,
    company_logo_url VARCHAR(500),

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE INDEX idx_work_experiences_user_id ON work_experiences(user_id);
CREATE INDEX idx_work_experiences_company ON work_experiences(company_name);
CREATE INDEX idx_work_experiences_is_current ON work_experiences(is_current_position);

/*
====================================================
TABLE: education_records
====================================================

Purpose:
Stores a user's educational background.

Why this table exists:
Education is a key part of a LinkedIn profile
and helps showcase academic qualifications.

Relationship:
One user can have multiple education records.

users.id → education_records.user_id

Example:
John Doe
 ├── B.Tech Computer Science
 ├── M.Tech Data Science
 └── MBA

====================================================
*/

CREATE TABLE education_records (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    institution_name VARCHAR(255) NOT NULL,
    degree VARCHAR(255),
    field_of_study VARCHAR(255),
    start_date DATE,
    end_date DATE,
    grade VARCHAR(50),
    description TEXT,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE INDEX idx_education_records_user_id ON education_records(user_id);
CREATE INDEX idx_education_records_institution ON education_records(institution_name);

/*
====================================================
TABLE: skills
====================================================

Purpose:
Stores skills possessed by users.

Why this table exists:
Skills help users showcase their
technical and professional abilities.

Relationship:
One user can have multiple skills.

users.id → skills.user_id

====================================================
*/

CREATE TABLE skills (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    skill_name VARCHAR(100) NOT NULL,
    proficiency proficiency_level DEFAULT 'beginner',

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
		
    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE INDEX idx_skills_user_id ON skills(user_id);
CREATE INDEX idx_skills_name ON skills(skill_name);

/*
====================================================
TABLE: certifications
====================================================

Purpose:
Stores professional certifications earned
by users.

Why this table exists:
Certifications help validate skills and
professional knowledge.

Relationship:
One user can have multiple certifications.

users.id → certifications.user_id

Examples:
AWS Certified Cloud Practitioner
Google Data Analytics Certificate

====================================================
*/

CREATE TABLE certifications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    certification_name VARCHAR(255) NOT NULL,
    issuing_organization VARCHAR(255) NOT NULL,
    issue_date DATE,
    expiration_date DATE,
    credential_id VARCHAR(255),
    credential_url VARCHAR(500),

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	
    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE INDEX idx_certifications_user_id ON certifications(user_id);
CREATE INDEX idx_certifications_name ON certifications(certification_name);

/*
====================================================
TABLE: projects
====================================================

Purpose:
Stores projects completed by users.

Why this table exists:
Projects allow users to showcase
practical work and portfolio achievements.

Relationship:
One user can have multiple projects.

users.id → projects.user_id

====================================================
*/

CREATE TABLE projects (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    project_name VARCHAR(255) NOT NULL,
    description TEXT,
    tech_stack VARCHAR(500),
    project_url VARCHAR(500),
    github_url VARCHAR(500),
    start_date DATE,
    end_date DATE,

    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
    REFERENCES users(id)
    ON DELETE CASCADE
);

CREATE INDEX idx_projects_user_id ON projects(user_id);
CREATE INDEX idx_projects_project_name ON projects(project_name);
CREATE INDEX idx_projects_tech_stack ON projects(tech_stack);

-- ============================================================
-- LinkedIn Portfolio - Sample Data
-- Populates tables with realistic KIIT student profile
-- ============================================================

/*
Creating a sample user account
*/

INSERT INTO users (email, username, password_hash, is_active)
VALUES ('piyush14.kiit.ac.in', 'piyushk', 'hashed_password_123', TRUE);

/*
Adding public profile details for the user
*/

INSERT INTO user_profiles (
    user_id,
    first_name,
    last_name,
    headline,
    about,
    location,
    website_url,
    profile_picture_url,
    cover_image_url,
    is_open_to_opportunities,
    visibility,
    phone_number
)
VALUES (
    1,
    'Piyush',
    'Kumar',
    'AI Engineer | Machine Learning & Backend Systems',
    'AI Engineer focused on building intelligent systems, machine learning models, and scalable backend architectures. Passionate about LLMs, data pipelines, and applied AI solutions.',
    'Mumbai, India',
    'https://portfolio.com',
    'https://image.com/profile.jpg',
    'https://image.com/cover.jpg',
    TRUE,
    'public',
    '+91-9984567892'
);

/*
Adding internship and freelance experience for the user
*/

INSERT INTO work_experiences (
    user_id, company_name, job_title, employment_type, location, start_date, end_date, is_current_position, description
)
VALUES
(1, 'AI Research Lab', 'Machine Learning Intern', 'internship', 'Mumbai', '2025-06-01', '2025-08-31', FALSE, 'Worked on building and training machine learning models, data preprocessing pipelines, and evaluating model performance using Python and scikit-learn'),

(1, 'Freelance', 'AI Engineer', 'freelance', 'Remote', '2025-09-01', NULL, TRUE, 'Developing AI-powered applications, integrating LLM APIs, and building intelligent backend systems for real-world use cases');

/*
Adding school + higher secondary + university education
*/

INSERT INTO education_records (
    user_id, institution_name, degree, field_of_study, start_date, end_date, grade
)
VALUES
(
    1,
    'KIIT University',
    'B.Tech',
    'Computer Science and Engineering',
    '2024-08-02',
    '2028-07-25',
    '8.2 CGPA'
),
(
    1,
    'Jusco School South Park',
    'Higher Secondary (XII)',
    'PCM with Computer Science',
    '2022-04-01',
    '2024-05-04',
    '80.4%'
),
(
    1,
    'Jusco School South Park',
    'Secondary (X)',
    NULL,
    '2020-04-01',
    '2022-04-26',
    '89.0%'
);

/*
Adding technical and professional skills
*/

INSERT INTO skills (user_id, skill_name, proficiency)
VALUES
(1, 'Python', 'advanced'),
(1, 'SQL', 'intermediate'),
(1, 'Node.js', 'intermediate'),
(1, 'PostgreSQL', 'intermediate'),
(1, 'Data Structures', 'advanced'),
(1, 'Machine Learnig', 'beginner'),
(1, 'JAVA','intermediate');

/*
Adding professional certifications
*/

INSERT INTO certifications (
    user_id, certification_name, issuing_organization, issue_date, credential_id
)
VALUES
(1, 'AWS Certified Cloud Practitioner', 'Amazon Web Services', '2025-03-10', 'AWS-12345'),
(1, 'Google Data Analytics Certificate', 'Google', '2024-11-20', 'GOOGLE-67890'),
(1, 'Microsoft Azure AI Fundamentals', 'Microsoft', '2025-02-15', 'AZ-900-AI-56789'),
(1, 'Machine Learning Certificate', 'Kaggle', '2024-09-10', 'KAGGLE-ML-2024-1122'),
(1, 'Deep Learning Fundamentals', 'Kaggle', '2025-01-05', 'KAGGLE-DL-2025-7788');

/*
Adding personal and academic projects
*/

INSERT INTO projects (
    user_id, project_name, description, tech_stack, project_url, github_url, start_date, end_date
)
VALUES
(
    1,
    'Netflix Clone',
    'A full-stack Netflix clone with authentication, movie browsing, and streaming UI',
    'React, Node.js, MongoDB, JWT, TMDB API',
    'https://netflix-clone-demo.com',
    'https://github.com/piyush/netflix-clone',
    '2025-05-01',
    '2025-06-15'
),
(
    1,
    'ATS Friendly Resume Analyzer',
    'AI-powered resume analyzer that checks ATS compatibility, keyword matching, and suggests improvements',
    'Python, NLP, Flask, OpenAI API',
    'https://resume-analyzer-demo.com',
    'https://github.com/piyush/resume-analyzer',
    '2025-06-20',
    NULL
);


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