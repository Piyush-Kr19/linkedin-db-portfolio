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