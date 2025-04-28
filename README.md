            Top Skills in Demand with Average Salary





* This query retrieves the top 30 skills for Data Analyst jobs in 'Anywhere' based on demand and average salary.
 *It first calculates the demand count for each skill and then computes the average salary for those skills.
* The final result is sorted by average salary in descending order and then by demand count in descending order.
* The query uses Common Table Expressions (CTEs) to break down the process into manageable parts.
* The first CTE, skills_demand, counts the number of job postings for each skill.
* The second CTE, average_salary, calculates the average salary for each skill.
* The final SELECT statement joins these two CTEs to get the desired output.
* The WHERE clause filters out skills with a demand count of 10 or less.
* The LIMIT clause restricts the output to the top 30 skills.
* The query is designed to help job seekers identify the most in-demand and highest-paying skills for Data Analyst positions.


SQL queries? Check them out here: [projects folder](/projects/)



![Top Skills in Demand with Average Salary](e2415c66-10d8-441a-bba4-146ac1b3cf08.png)
| Rank | Skill       | Demand Count | Avg Salary  |
|------|-------------|--------------|-------------|
| 1    | sql         | 398          | $97,237     |
| 2    | python      | 236          | $101,397    |
| 3    | tableau     | 230          | $99,288     |
| 4    | r           | 148          | $100,499    |
| 5    | power bi    | 110          | $97,431     |
| 6    | sas         | 63           | $98,902     |
| 7    | sas         | 63           | $98,902     |
| 8    | looker      | 49           | $103,795    |
| 9    | snowflake   | 37           | $112,948    |
| 10   | oracle      | 37           | $104,534    |
| 11   | sql server  | 35           | $97,786     |
| 12   | azure       | 34           | $111,225    |
| 13   | aws         | 32           | $108,317    |
| 14   | flow        | 28           | $97,200     |
| 15   | go          | 27           | $115,320    |
| 16   | spss        | 24           | $92,170     |
| 17   | hadoop      | 22           | $113,193    |
| 18   | jira        | 20           | $104,918    |
| 19   | javascript  | 20           | $97,587     |
| 20   | java        | 17           | $106,906    |
| 21   | alteryx     | 17           | $94,145     |
| 22   | redshift    | 16           | $99,936     |
| 23   | ssrs        | 14           | $99,171     |
| 24   | qlik        | 13           | $99,631     |
| 25   | spark       | 13           | $99,077     |
| 26   | nosql       | 13           | $101,414    |
| 27   | bigquery    | 13           | $109,654    |
| 28   | ssis        | 12           | $106,683    |
| 29   | confluence  | 11           | $114,210    |
| 30   | c++         | 11           | $98,958     |


```SQL
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
```
 * Same Query with CTE Subquery format

 ```sql
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
```

                Top 5 Skills for Data Analyst

    
    This query retrieves the top 5 skills for remote Data Analyst jobs based on the number of job postings.
* It first counts the number of job postings for each skill in the remote_jobs_skills CTE.
* The main SELECT statement then joins this CTE with the skills_dim table to get the skill names.
* The results are ordered by the skill count in descending order, and the output is limited to the top 5 skills.
* The query uses Common Table Expressions (CTEs) to break down the process into manageable parts.
* The first CTE, remote_jobs_skills, counts the number of job postings for each skill.
* The final SELECT statement joins this CTE to get the desired output.
* The LIMIT clause restricts the output to the top 5 skills.
* The WHERE clause filters for remote jobs and the job title 'Data Analyst'.
* The query uses INNER JOIN to combine data from the skills_job_dim and job_postings_fact tables.
* The final result includes the skill ID, skill count, and skill name.
* The query is designed to help identify the most in-demand skills for remote Data Analyst positions.


SQL queries? Check them out here: [projects folder](/projects/)



![Top Skills in Demand with Average Salary](701743ef-02fb-4a23-b1d8-52c40c3c1d62.png)
Here is the data from the active selection formatted as a table:

| Skill ID | Skill Count | Skill      |
|----------|-------------|------------|
| 0        | 7291        | SQL        |
| 181      | 4611        | Excel      |
| 1        | 4330        | Python     |
| 182      | 3745        | Tableau    |
| 183      | 2609        | Power BI   |

```sql
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
```

            Top Paying SKills


Here is the data from the active selection formatted as a table:

| Job ID  | Job Title                        | Salary Year Avg | Job Posted Date      | Company Name | Skills      |
|---------|----------------------------------|-----------------|----------------------|--------------|-------------|
| 552322  | Associate Director- Data Insights | 255829.5        | 2023-06-18 16:03:12 | AT&T         | SQL         |
| 552322  | Associate Director- Data Insights | 255829.5        | 2023-06-18 16:03:12 | AT&T         | Python      |
| 552322  | Associate Director- Data Insights | 255829.5        | 2023-06-18 16:03:12 | AT&T         | R           |
| 552322  | Associate Director- Data Insights | 255829.5        | 2023-06-18 16:03:12 | AT&T         | Azure       |
| 552322  | Associate Director- Data Insights | 255829.5        | 2023-06-18 16:03:12 | AT&T         | Databricks  |
| 552322  | Associate Director- Data Insights | 255829.5        | 2023-06-18 16:03:12 | AT&T         | AWS         |
| 552322  | Associate Director- Data Insights | 255829.5        | 2023-06-18 16:03:12 | AT&T         | Pandas      |
| 552322  | Associate Director- Data Insights | 255829.5        | 2023-06-18 16:03:12 | AT&T         | PySpark     |
| 552322  | Associate Director- Data Insights | 255829.5        | 2023-06-18 16:03:12 | AT&T         | Jupyter     |
| 552322  | Associate Director- Data Insights | 255829.5        | 2023-06-18 16:03:12 | AT&T         | Excel       |

```sql
WITH top_paying_jobs as (
SELECT
    job_id,
    job_title,
    --job_location,
    --job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name company_name
FROM
    job_postings_fact
    left JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
where
    job_title_short = 'Data Analyst' and 
    job_location = 'Anywhere' and
    salary_year_avg is not NULL
order by
    salary_year_avg desc
limit
    10
    )
SELECT 
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg desc
LIMIT 10;
```


    Highest Paying Remote Jobs companies

 


 Here is the data from the active selection formatted as a table:

| Job ID   | Job Title                                     | Job Location | Job Schedule Type | Salary Year Avg | Job Posted Date      | Company Name                              |
|----------|-----------------------------------------------|--------------|--------------------|-----------------|----------------------|-------------------------------------------|
| 226942   | Data Analyst                                  | Anywhere     | Full-time          | 650000.0        | 2023-02-20 15:13:33 | Mantys                                    |
| 547382   | Director of Analytics                         | Anywhere     | Full-time          | 336500.0        | 2023-08-23 12:04:42 | Meta                                      |
| 552322   | Associate Director- Data Insights             | Anywhere     | Full-time          | 255829.5        | 2023-06-18 16:03:12 | AT&T                                      |
| 99305    | Data Analyst, Marketing                       | Anywhere     | Full-time          | 232423.0        | 2023-12-05 20:00:40 | Pinterest Job Advertisements              |
| 1021647  | Data Analyst (Hybrid/Remote)                  | Anywhere     | Full-time          | 217000.0        | 2023-01-17 00:17:23 | Uclahealthcareers                         |
| 168310   | Principal Data Analyst (Remote)               | Anywhere     | Full-time          | 205000.0        | 2023-08-09 11:00:01 | SmartAsset                                |
| 731368   | Director, Data Analyst - HYBRID               | Anywhere     | Full-time          | 189309.0        | 2023-12-07 15:00:13 | Inclusively                               |
| 310660   | Principal Data Analyst, AV Performance Analysis | Anywhere   | Full-time          | 189000.0        | 2023-01-05 00:00:25 | Motional                                  |
| 1749593  | Principal Data Analyst                        | Anywhere     | Full-time          | 186000.0        | 2023-07-11 16:00:05 | SmartAsset                                |
| 387860   | ERM Data Analyst                              | Anywhere     | Full-time          | 184000.0        | 2023-06-09 08:01:04 | Get It Recruit - Information Technology   |

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name company_name
FROM
    job_postings_fact
    left JOIN company_dim on job_postings_fact.company_id = company_dim.company_id
where
    job_title_short = 'Data Analyst' and 
    job_location = 'Anywhere' and
    salary_year_avg is not NULL
order by
    salary_year_avg desc
limit
    10;
```

        Top Paying Skills

        /* 💸 Top-Paying Skills for Data Analysts — Insights & Trends
🔥 1. Rise of Big Data & Cloud Tools

    Top Skills: PySpark ($208K), Databricks ($141K), Hadoop ($113K), GCP ($122K), Airflow ($126K).

    Trend: Employers pay a premium for data analysts who can handle large-scale, distributed data and build data pipelines on cloud platforms like GCP and Databricks.

👨‍💻 2. Data Science + ML Libraries = High Pay

    Top Skills: Pandas ($151K), NumPy ($143K), Scikit-learn ($125K), Jupyter ($152K).

    Trend: Analysts who bring coding + ML + statistics together are in demand. If you can use Jupyter + Pandas to explore and model data, you’re gold.

⚙️ 3. DevOps & CI/CD Knowledge Pays Off

    Top Skills: Bitbucket ($189K), GitLab ($154K), Jenkins ($125K), Kubernetes ($132K).

    Trend: Cross-functional analysts who can manage version control, automation, and even containerized deployments are getting paid like engineers.

💡 4. Business Intelligence & Visualization Still Matter

    Top Skills: MicroStrategy ($121K), Crystal Reports ($120K), PostgreSQL ($123K), Elasticsearch ($145K).

    Trend: High salaries come to those who make insights accessible—databases + dashboards = value.

📲 5. Niche/Hybrid Skills Are High-Reward

    Examples: Watson (IBM AI, $160K), Twilio (messaging APIs, $127K), Swift (iOS, $153K), Go/Golang ($145K).

    Trend: Analysts who work in specialized tech stacks (e.g., telecom, finance, mobile) often earn more due to domain-specific skills. */


    ```markdown
    | Skill           | Average Salary ($) |
    |------------------|--------------------|
    | PySpark         | 208,172            |
    | Bitbucket       | 189,155            |
    | Watson          | 160,515            |
    | Couchbase       | 160,515            |
    | DataRobot       | 155,486            |
    | GitLab          | 154,500            |
    | Swift           | 153,750            |
    | Jupyter         | 152,777            |
    | Pandas          | 151,821            |
    | Golang          | 145,000            |
    | Elasticsearch   | 145,000            |
    | NumPy           | 143,513            |
    | Databricks      | 141,907            |
    | Linux           | 136,508            |
    | Kubernetes      | 132,500            |
    | Atlassian       | 131,162            |
    | Twilio          | 127,000            |
    | Airflow         | 126,103            |
    | Scikit-learn    | 125,781            |
    | Jenkins         | 125,436            |
    | Notion          | 125,000            |
    | Scala           | 124,903            |
    | PostgreSQL      | 123,879            |
    | GCP             | 122,500            |
    | MicroStrategy   | 121,619            |
    | Crystal         | 120,100            |
    | Go              | 115,320            |
    | Confluence      | 114,210            |
    | DB2             | 114,072            |
    | Hadoop          | 113,193            |
    ```

