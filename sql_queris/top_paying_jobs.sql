SELECT job_id,
        job_title,
        job_location,
        job_schedule_type,
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