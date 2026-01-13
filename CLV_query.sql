CREATE DATABASE CLV_analysis;
USE CLV_analysis;

-- 1 Total number of Students  
SELECT 
	  COUNT(DISTINCT Student_ID) AS total_students
FROM edtech;

-- 2 Total revenue 
SELECT 
     SUM(Amount_Paid) AS total_revenue
FROM edtech;

-- 3 Average Revenue per Student 
SELECT 
    ROUND(SUM(Amount_Paid) / COUNT(DISTINCT Student_ID), 2) 
    AS avg_revenue_per_student
FROM edtech;

-- 4 Revenue Creation  
SELECT
     Is_Returning_Student,
     COUNT(DISTINCT Student_ID) As total_students,
     ROUND(AVG(Amount_Paid),2) AS Avg_amount
FROM edtech
GROUP BY Is_Returning_Student;

-- 5 Average revenue per course category
SELECT 
	 Course_Category,
	 ROUND(AVG(Amount_Paid),2) AS Avg_amount
FROM edtech 
GROUP BY Course_Category
ORDER BY Avg_amount DESC;

-- 6 Revenue contribution by course category 
 SELECT 
	  Course_Category,
      SUM(Amount_Paid) As total_amount,
      ROUND(SUM(Amount_Paid) * 100 / (SELECT SUM(Amount_Paid) FROM edtech),2) As revenue_contribution 
FROM edtech 
GROUP BY Course_Category
ORDER BY total_amount DESC;

-- 7 Completion rate buckets vs revenue
SELECT 
	 CASE 
         WHEN `Completion_Rate_%` < 40 THEN "Low Completion"
         WHEN `Completion_Rate_%` BETWEEN 40 AND 70 THEN "Medium Completion"
         ELSE "High Completion"
         END AS Completion_segment,
	 ROUND(AVG(Amount_Paid),2) AS Avg_revenue
FROM edtech
GROUP BY Completion_segment;

-- 8 Learning minutes vs revenu
SELECT
    CASE
        WHEN Total_Learning_Minutes < 500 THEN 'Low Engagement'
        WHEN Total_Learning_Minutes BETWEEN 500 AND 1500 THEN 'Medium Engagement'
        ELSE 'High Engagement'
    END AS engagement_segment,
    ROUND(AVG(Amount_Paid), 2) AS avg_revenue
FROM edtech
GROUP BY engagement_segment;

-- 9 Certification earned vs revenue
SELECT
    Certification_Earned,
    COUNT(*) AS enrollments,
    ROUND(AVG(Amount_Paid), 2) AS avg_revenue
FROM edtech
GROUP BY certification_earned;

-- 10 Create CLV segments using NTILE 
SELECT
    Student_ID,
    SUM(Amount_Paid) AS total_spent,
    NTILE(3) OVER (ORDER BY SUM(Amount_Paid)) AS clv_segment
FROM edtech
GROUP BY Student_ID;

