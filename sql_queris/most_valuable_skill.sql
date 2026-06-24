WITH skills_in_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills,
        count(*) AS Total_of_skills
    FROM    
        job_postings_fact 
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst' 
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    GROUP BY skills, skills_dim.skill_id
    ORDER BY Total_of_skills DESC

),

skills_payable AS (
    SELECT 
        skills_dim.skill_id, 
        skills,
        Round(AVG(salary_year_avg),0) as average_salary
    FROM    
        job_postings_fact 
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills, skills_dim.skill_id
    ORDER BY 
        average_salary DESC 
  
)
SELECT  d.skill_id,
        d.skills,
       d.Total_of_skills,
        p.average_salary
FROM skills_in_demand  AS d
INNER JOIN skills_payable as p ON d.skill_id = p.skill_id
WHERE Total_of_skills > 10

ORDER BY average_salary DESC,
        Total_of_skills DESC
LIMIT 25


