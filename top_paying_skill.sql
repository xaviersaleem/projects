select 
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
    skills
order by
    avg_salary desc
limit 30


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