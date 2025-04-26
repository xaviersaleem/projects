select 
    skills,
    count(skills_job_dim.skill_id) as demand_count
FROM
    job_postings_fact

INNER JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
where job_title_short = 'Data Analyst' 
    and job_location = 'Anywhere'
group BY
    skills
order by
    demand_count desc
limit 5


-- /* 📈 Top 5 Most Demanded Skills for Data Analysts       