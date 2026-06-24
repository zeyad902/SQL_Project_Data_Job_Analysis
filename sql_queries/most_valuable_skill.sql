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

/*
[
  {
    "skill_id": 8,
    "skills": "go",
    "total_of_skills": "27",
    "average_salary": "115320"
  },
  {
    "skill_id": 234,
    "skills": "confluence",
    "total_of_skills": "11",
    "average_salary": "114210"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "total_of_skills": "22",
    "average_salary": "113193"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "total_of_skills": "37",
    "average_salary": "112948"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "total_of_skills": "34",
    "average_salary": "111225"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "total_of_skills": "13",
    "average_salary": "109654"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "total_of_skills": "32",
    "average_salary": "108317"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "total_of_skills": "17",
    "average_salary": "106906"
  },
  {
    "skill_id": 194,
    "skills": "ssis",
    "total_of_skills": "12",
    "average_salary": "106683"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "total_of_skills": "20",
    "average_salary": "104918"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "total_of_skills": "37",
    "average_salary": "104534"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "total_of_skills": "49",
    "average_salary": "103795"
  },
  {
    "skill_id": 2,
    "skills": "nosql",
    "total_of_skills": "13",
    "average_salary": "101414"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "total_of_skills": "236",
    "average_salary": "101397"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "total_of_skills": "148",
    "average_salary": "100499"
  },
  {
    "skill_id": 78,
    "skills": "redshift",
    "total_of_skills": "16",
    "average_salary": "99936"
  },
  {
    "skill_id": 187,
    "skills": "qlik",
    "total_of_skills": "13",
    "average_salary": "99631"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "total_of_skills": "230",
    "average_salary": "99288"
  },
  {
    "skill_id": 197,
    "skills": "ssrs",
    "total_of_skills": "14",
    "average_salary": "99171"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "total_of_skills": "13",
    "average_salary": "99077"
  },
  {
    "skill_id": 13,
    "skills": "c++",
    "total_of_skills": "11",
    "average_salary": "98958"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "total_of_skills": "63",
    "average_salary": "98902"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "total_of_skills": "63",
    "average_salary": "98902"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "total_of_skills": "35",
    "average_salary": "97786"
  },
  {
    "skill_id": 9,
    "skills": "javascript",
    "total_of_skills": "20",
    "average_salary": "97587"
  }
]*/