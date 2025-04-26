with skills_demand as (
select 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
FROM
    job_postings_fact

INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst'
    and salary_year_avg is not NULL
    and job_location = 'Anywhere'
group BY
    skills_dim.skill_id,skills_job_dim.skill_id

),
average_salary as (
select 
    skills_job_dim.skill_id,
    skills,
    round(avg (salary_year_avg),0) as avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' and 
    salary_year_avg is not NULL
    and job_location = 'Anywhere'
group BY
    skills_job_dim.skill_id,
    skills_dim.skill_id
)
SELECT  
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM
    skills_demand
INNER JOIN average_salary on skills_demand.skill_id = average_salary.skill_id
WHERE
    skills_demand.demand_count > 10
ORDER BY
   average_salary.avg_salary DESC,
    skills_demand.demand_count DESC
    
limit 30



-- This query retrieves the top 30 skills for Data Analyst jobs in 'Anywhere' based on demand and average salary.
-- It first calculates the demand count for each skill and then computes the average salary for those skills.
-- The final result is sorted by average salary in descending order and then by demand count in descending order.
-- The query uses Common Table Expressions (CTEs) to break down the process into manageable parts.
-- The first CTE, skills_demand, counts the number of job postings for each skill.
-- The second CTE, average_salary, calculates the average salary for each skill.
-- The final SELECT statement joins these two CTEs to get the desired output.
-- The WHERE clause filters out skills with a demand count of 10 or less.
-- The LIMIT clause restricts the output to the top 30 skills.
-- The query is designed to help job seekers identify the most in-demand and highest-paying skills for Data Analyst positions.
-- The query is designed to help job seekers identify the most in-demand and highest-paying skills for Data Analyst positions.




SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count,
    round(avg(job_postings_fact.salary_year_avg),0) as avg_salary
FROM
    job_postings_fact
INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst'
    and salary_year_avg is not NULL
    and job_location = 'Anywhere'
group BY
    skills_dim.skill_id
HAVING
    count(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
limit 30;
-- This query retrieves the top 30 skills for Data Analyst jobs in 'Anywhere' based on demand and average salary.
-- It first calculates the demand count for each skill and then computes the average salary for those skills.
-- The final result is sorted by average salary in descending order and then by demand count in descending order.
-- The query uses Common Table Expressions (CTEs) to break down the process into manageable parts.
-- The first CTE, skills_demand, counts the number of job postings for each skill.
-- The second CTE, average_salary, calculates the average salary for each skill.
-- The final SELECT statement joins these two CTEs to get the desired output.
-- The WHERE clause filters out skills with a demand count of 10 or less.
-- The LIMIT clause restricts the output to the top 30 skills.
-- The query is designed to help job seekers identify the most in-demand and highest-paying skills for Data Analyst positions.
