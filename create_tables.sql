-- ============================================================
-- LinkedIn Portfolio Database Schema (DDL)
-- PostgreSQL implementation
-- Includes tables: User, User Profile, Education, Skills, Experience, Certifications, Projects 
-- ============================================================

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
