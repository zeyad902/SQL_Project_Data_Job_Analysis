WITH top_10_jobs AS(
    SELECT job_id,
        job_title,
        salary_year_avg,
        job_posted_date,
        company.name
    FROM 
        job_postings_fact as jobs
    LEFT JOIN 
        company_dim AS company ON jobs.company_id = company.company_id 
    WHERE 
        job_title_short = 'Data Analyst' 
    AND 
        job_work_from_home = TRUE
    AND 
        salary_year_avg IS NOT NULL 
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
) 
SELECT 
    top_10_jobs.*,
    skills,
    type
FROM 
    top_10_jobs
INNER JOIN skills_job_dim ON top_10_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
