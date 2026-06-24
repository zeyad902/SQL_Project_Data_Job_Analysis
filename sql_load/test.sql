SELECT job_title_short,
        salary_year_avg,
        skills,
        type
FROM(
    SELECT * FROM january_jobs
    UNION ALL
    SELECT * FROM february_jobs
    UNION ALL
    SELECT * FROM march_jobs
) AS Q1_Table
LEFT JOIN skills_job_dim ON Q1_Table.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE salary_year_avg > 70000