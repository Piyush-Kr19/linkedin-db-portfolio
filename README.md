# 🚀 LinkedIn Database Portfolio

> A comprehensive PostgreSQL-based LinkedIn-style portfolio database with complete schema design, sample data, and advanced SQL queries demonstrating real-world data analysis and relational database modeling.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Database: PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-316192?style=flat&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![SQL Standard](https://img.shields.io/badge/SQL-Standard-4169E1)](https://en.wikipedia.org/wiki/SQL)

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Database Schema](#database-schema)
- [Installation](#installation)
- [Usage Examples](#usage-examples)
- [Technologies Used](#technologies-used)
- [Project Structure](#project-structure)
- [Sample Queries](#sample-queries)

---

## 🎯 Overview

The **LinkedIn Database Portfolio** is a fully-designed relational database system that models a professional networking platform similar to LinkedIn. It enables users to build comprehensive digital portfolios with their professional experiences, educational background, skills, certifications, and projects.

This project demonstrates:
- ✅ Professional database schema design with 7 interconnected tables
- ✅ Advanced SQL queries including JOINs, aggregates, and subqueries
- ✅ Real-world data modeling for professional profiles
- ✅ Data integrity through foreign keys and constraints
- ✅ Index optimization for query performance
- ✅ PostgreSQL ENUM types for data consistency

Perfect for **students, professionals, and database enthusiasts** learning advanced SQL and database design patterns.

---

## ✨ Features

### 👤 User Management
- Secure user account creation with email and username
- Account activation and login tracking
- Unique constraint enforcement for data integrity

### 📝 Professional Profiles
- Detailed profile information with headline and bio
- Profile visibility controls (public, connections, private)
- Cover image and profile picture URLs
- Contact information management
- Open to opportunities flag for recruiters

### 💼 Work Experience Tracking
- Multiple job positions per user
- Employment type classification (full-time, part-time, contract, freelance, internship)
- Current position tracking
- Company and location information
- Date range tracking with optional end dates

### 🎓 Education Management
- Multiple education records per user
- Degree and field of study tracking
- Grade/CGPA storage
- Educational timeline with start and end dates

### 🛠️ Skills & Proficiency
- Skill management with proficiency levels (beginner, intermediate, advanced, expert)
- Multiple skills per user
- Track technical and professional abilities

### 🏆 Certifications
- Professional certification tracking
- Issuing organization and credential ID
- Certification expiration dates
- Credential URLs for verification

### 🔗 Project Portfolio
- Showcase multiple personal and professional projects
- Technology stack documentation
- Project URLs and GitHub repository links
- Project timeline tracking

### 📊 Advanced Analytics
- Complex JOIN operations for data retrieval
- Aggregate functions for insights (COUNT, GROUP BY)
- UNION queries for combining data
- Subquery demonstrations
- Career snapshot reports

---

## 🗄️ Database Schema

### Tables Overview

```
┌─────────────────────────────────────────────────────────┐
│                    SCHEMA DIAGRAM                       │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │ users (PK: id)                                   │  │
│  │ ├─ email, username, password_hash               │  │
│  │ ├─ is_active, last_login_at                     │  │
│  │ └─ created_at, updated_at                       │  │
│  └──────────┬───────────────────────────────────────┘  │
│             │ 1                                        │
│             │ (one-to-one)                            │
│             │                                         │
│  ┌──────────▼───────────────────────────────────────┐  │
│  │ user_profiles (PK: id, FK: user_id)             │  │
│  │ ├─ first_name, last_name, headline              │  │
│  │ ├─ about, location, website_url                 │  │
│  │ ├─ profile_picture_url, visibility              │  │
│  │ └─ is_open_to_opportunities                     │  │
│  └──────────────────────────────────────────────────┘  │
│             │                                         │
│  ┌──────────┴─────────────────────────────────────┐   │
│  │  1      │         1       │          1      │    │
│  │ (one-to-many for all below)                 │    │
│  │                                              │    │
│  ▼          ▼                ▼                 ▼    │
│  ┌────────────────┐  ┌──────────────────┐  ┌───┐   │
│  │work_experiences│  │education_records │  │skills   │
│  │ ├─ company     │  │ ├─ institution   │  │├─skill_ │
│  │ ├─ job_title   │  │ ├─ degree        │  ││ name   │
│  │ ├─ location    │  │ └─ field_of_study│  │└─profi  │
│  │ └─ start/end   │  │    └─ grade      │  │ ceincy  │
│  └────────────────┘  └──────────────────┘  └───────┘  │
│                                                     │
│  ┌──────────────────┐  ┌──────────────────────────┐   │
│  │certifications    │  │projects                  │   │
│  │├─ cert_name      │  │├─ project_name           │   │
│  │├─ issuing_org    │  │├─ description            │   │
│  │├─ issue_date     │  │├─ tech_stack             │   │
│  │└─ credential_id  │  │├─ project_url, github    │   │
│  │                  │  │└─ start/end_date         │   │
│  └──────────────────┘  └──────────────────────────┘   │
│                                                     │
└─────────────────────────────────────────────────────────┘
```

### Table Details

| Table | Records | Purpose |
|-------|---------|---------|
| **users** | Authentication & Account Management | Store login credentials and account status |
| **user_profiles** | Public Profile Information | Display profile details on portfolio |
| **work_experiences** | Career History | Track job positions and roles |
| **education_records** | Academic Background | Store educational qualifications |
| **skills** | Professional Abilities | Manage skills with proficiency levels |
| **certifications** | Professional Credentials | Track certifications and credentials |
| **projects** | Portfolio Work | Showcase completed projects |

---

## 📦 Installation

### Prerequisites

- **PostgreSQL 12.0+** installed and running
- **psql** command-line tool
- Basic knowledge of SQL

### Step 1: Clone the Repository

```bash
git clone https://github.com/Piyush-Kr19/linkedin-db-portfolio.git
cd linkedin-db-portfolio
```

### Step 2: Connect to PostgreSQL

```bash
psql -U postgres
```

### Step 3: Create Database

```sql
CREATE DATABASE linkedin_portfolio;
\c linkedin_portfolio
```

### Step 4: Execute SQL Scripts in Order

```bash
# 1. Create tables and schema
psql -U postgres -d linkedin_portfolio -f create_tables.sql

# 2. Insert sample data
psql -U postgres -d linkedin_portfolio -f insert_data.sql

# 3. Run analysis queries
psql -U postgres -d linkedin_portfolio -f analysis_queries.sql
```

### Alternative: Using Connection String

```bash
psql postgresql://username:password@localhost:5432/linkedin_portfolio -f create_tables.sql
psql postgresql://username:password@localhost:5432/linkedin_portfolio -f insert_data.sql
```

### Verify Installation

```sql
-- Connect to the database
psql -U postgres -d linkedin_portfolio

-- List all tables
\dt

-- View table structure
\d users
\d user_profiles
```

---

## 💻 Usage Examples

### Basic User Queries

#### Get All Active Users
```sql
SELECT id, email, username, created_at, last_login_at
FROM users
WHERE is_active = TRUE;
```

#### View Complete User Profile
```sql
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
```

### Experience Analysis

#### Count Total Experiences Per User
```sql
SELECT 
    user_id,
    COUNT(*) AS total_experiences
FROM work_experiences
GROUP BY user_id
ORDER BY total_experiences DESC;
```

#### Find Current Job Holders
```sql
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
```

### Skills & Certifications

#### Find Most Popular Skills
```sql
SELECT 
    skill_name,
    COUNT(*) AS total_users
FROM skills
GROUP BY skill_name
ORDER BY total_users DESC
LIMIT 10;
```

#### Top Certifying Organizations
```sql
SELECT 
    issuing_organization,
    COUNT(*) AS total_certifications
FROM certifications
GROUP BY issuing_organization
ORDER BY total_certifications DESC;
```

### Advanced Analytics

#### Complete Career Snapshot
```sql
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
```

#### Education + Skills Combination
```sql
SELECT 
    u.id,
    p.first_name,
    COUNT(DISTINCT e.id) AS education_count,
    COUNT(DISTINCT s.id) AS skill_count
FROM users u
LEFT JOIN user_profiles p ON u.id = p.user_id
LEFT JOIN education_records e ON u.id = e.user_id
LEFT JOIN skills s ON u.id = s.user_id
GROUP BY u.id, p.first_name
ORDER BY skill_count DESC;
```

#### Combined Resume Keywords (UNION)
```sql
SELECT skill_name AS keyword
FROM skills

UNION

SELECT certification_name AS keyword
FROM certifications
ORDER BY keyword;
```

---

## 🛠️ Technologies Used

### Database & Language
- **PostgreSQL** - Relational Database Management System
- **SQL** - Structured Query Language
- **PL/pgSQL** - PostgreSQL procedural language

### Features Utilized
- **ENUM Types** - For standardized data values
- **Foreign Keys** - Enforce referential integrity
- **Indexes** - Optimize query performance
- **Constraints** - Ensure data quality and uniqueness
- **Timestamp Tracking** - Audit trail with created_at and updated_at
- **JOIN Operations** - Multiple join types for data retrieval
- **Aggregate Functions** - COUNT, GROUP BY analysis
- **Subqueries** - Complex nested queries
- **UNION Queries** - Combining result sets

### Soft Skills Demonstrated
- Database Design & Normalization
- Data Modeling
- Query Optimization
- Relational Integrity
- SQL Best Practices

---

## 📂 Project Structure

```
linkedin-db-portfolio/
│
├── create_tables.sql          # Database schema definition
│   ├── ENUM type definitions
│   ├── Table creation statements
│   ├── Foreign key relationships
│   └── Index creation
│
├── insert_data.sql            # Sample data population
│   ├── User account creation
│   ├── Profile information
│   ├── Work experience records
│   ├── Education records
│   ├── Skills data
│   ├── Certifications
│   └── Projects showcase
│
├── analysis_queries.sql       # 10 advanced query examples
│   ├── Basic user retrieval
│   ├── JOIN operations
│   ├── GROUP BY aggregates
│   ├── Career analytics
│   ├── Skills analysis
│   └── UNION queries
│
├── README.md                  # Project documentation
├── LICENSE                    # MIT License
└── .gitignore                # Git ignore rules
```

---

---

## 🔍 Sample Queries

The `analysis_queries.sql` file includes 10 comprehensive query examples:

1. ✅ **Basic User Overview** - Retrieve active users
2. ✅ **Full Profile View** - JOIN users with profiles
3. ✅ **Experience Analysis** - COUNT experiences per user
4. ✅ **Education + Skills** - Analyze academic data
5. ✅ **Certification Insights** - Popular organizations
6. ✅ **Current Job Holders** - Active position tracking
7. ✅ **Top Skills Analysis** - Most common skills
8. ✅ **Projects Analysis** - User project counts
9. ✅ **Full Career Snapshot** - Complete dashboard query
10. ✅ **Resume Keywords** - UNION of skills and certs

---

### Ideas for Enhancement
- Add table for endorsements/recommendations
- Implement triggers for timestamp automation
- Create views for common queries
- Add data validation procedures
- Design dashboard-ready materialized views
- Implement full-text search on profiles

---

## 🎓 Learning Resources

### SQL Concepts Covered
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [SQL JOINs Explained](https://www.w3schools.com/sql/sql_join.asp)
- [Database Normalization](https://en.wikipedia.org/wiki/Database_normalization)
- [Foreign Keys & Constraints](https://www.postgresql.org/docs/current/ddl-constraints.html)

---

## 📈 Project Statistics

- **Tables**: 7
- **Sample Records**: 15+
- **Query Examples**: 10
- **Indexes**: 15+
- **Documentation**: Comprehensive with examples

---

<div align="center">

### Built with ❤️ for database enthusiasts and professional developers

**[⭐ Star this repository](https://github.com/Piyush-Kr19/linkedin-db-portfolio)** if you find it helpful!

---

*Last Updated: June 2025*  
*Version: 1.0.0*

</div>