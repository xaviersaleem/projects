# 📊 Data Analyst Job Market Exploration

## 📌 Introduction

Dive into the data job market! Focusing on **data analyst roles**, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

> 🔍 SQL queries? Check them out in the `project_sql` folder.

---

## 📚 Background

Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint **top-paid** and **in-demand** skills. The dataset comes from a SQL course and includes job titles, salaries, locations, and essential skills.

### ❓ Questions Explored:
- What are the top-paying data analyst jobs?
- What skills are required for these top-paying jobs?
- What skills are most in demand for data analysts?
- Which skills are associated with higher salaries?
- What are the most optimal skills to learn?

---

## 🛠 Tools I Used

- **SQL** – Core analysis tool
- **PostgreSQL** – Database management system
- **Visual Studio Code** – SQL query execution
- **Git & GitHub** – Version control & sharing

---

## 📊 The Analysis

### 1️⃣ Top Paying Data Analyst Jobs

```sql
SELECT job_id, job_title, job_location, job_schedule_type, salary_year_avg,
       job_posted_date, name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst' 
  AND job_location = 'Anywhere' 
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;

Insights:

    Salaries range from $184K to $650K

    Employers: SmartAsset, Meta, AT&T

    Job title variety: from Analyst to Director


WITH top_paying_jobs AS (
  SELECT job_id, job_title, salary_year_avg, name AS company_name
  FROM job_postings_fact
  LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
  WHERE job_title_short = 'Data Analyst' 
    AND job_location = 'Anywhere' 
    AND salary_year_avg IS NOT NULL
  ORDER BY salary_year_avg DESC
  LIMIT 10
)
SELECT top_paying_jobs.*, skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;

Top Skills:

    SQL (8/10 jobs)

    Python (7)

    Tableau (6)


SELECT skills, COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;


| Skill     | Demand Count |
|-----------|---------------|
| SQL       | 7,291         |
| Excel     | 4,611         |
| Python    | 4,330         |
| Tableau   | 3,745         |
| Power BI  | 2,609         |

SELECT skills, ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
  AND salary_year_avg IS NOT NULL 
  AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;


| Skill       | Average Salary ($) |
|-------------|--------------------|
| PySpark     | 208,172            |
| Bitbucket   | 189,155            |
| Couchbase   | 160,515            |
| DataRobot   | 155,486            |
| Pandas      | 151,821            |

SELECT skills_dim.skill_id, skills_dim.skills, 
       COUNT(skills_job_dim.job_id) AS demand_count, 
       ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' 
  AND salary_year_avg IS NOT NULL 
  AND job_work_from_home = TRUE
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC, demand_count DESC
LIMIT 25;


| Skill         | Demand Count | Avg Salary ($) |
|---------------|--------------|----------------|
| Go            | 27           | 115,320        |
| Confluence    | 11           | 114,210        |
| Hadoop        | 22           | 113,193        |
| Snowflake     | 37           | 112,948        |
| AWS           | 32           | 108,317        |



