with 
    remote_jobs_skills as (
SELECT 
    skill_id,
    count(*) as skill_count
from
    skills_job_dim as skill_for_job
inner join job_postings_fact as job_posting on job_posting.job_id = skill_for_job.job_id
where
    job_posting.job_work_from_home = TRUE AND
    job_posting.job_title_short LIKE 'Data Analyst'
GROUP BY
    skill_id)
SELECT 
    remote_jobs_skills.skill_id,
    skill_count,
    skills
FROM
    remote_jobs_skills
INNER JOIN skills_dim as skill ON remote_jobs_skills.skill_id = skill.skill_id
ORDER BY
    skill_count DESC
LIMIT 5;

-- This query retrieves the top 5 skills for remote Data Analyst jobs based on the number of job postings.
-- It first counts the number of job postings for each skill in the remote_jobs_skills CTE.
-- The main SELECT statement then joins this CTE with the skills_dim table to get the skill names.
-- The results are ordered by the skill count in descending order, and the output is limited to the top 5 skills.
-- The query uses Common Table Expressions (CTEs) to break down the process into manageable parts.
-- The first CTE, remote_jobs_skills, counts the number of job postings for each skill.
-- The final SELECT statement joins this CTE to get the desired output.
-- The LIMIT clause restricts the output to the top 5 skills.
-- The WHERE clause filters for remote jobs and the job title 'Data Analyst'.
-- The query uses INNER JOIN to combine data from the skills_job_dim and job_postings_fact tables.
-- The final result includes the skill ID, skill count, and skill name.
-- The query is designed to help identify the most in-demand skills for remote Data Analyst positions.