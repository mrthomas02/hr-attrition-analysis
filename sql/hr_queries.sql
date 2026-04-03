-- ============================================
-- HR Attrition Analysis — SQL Queries
-- Database: hr_attrition.db
-- Author: Sanju Thomas Sabu
-- ============================================

-- Q1: Overall Attrition Summary
SELECT 
    Attrition,
    COUNT(*) AS EmployeeCount,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM employees), 1) AS Percentage
FROM employees
GROUP BY Attrition
ORDER BY EmployeeCount DESC;

-- Q2: Attrition Rate by Department
SELECT 
    Department,
    COUNT(*) AS TotalEmployees,
    SUM(AttritionBinary) AS Attrited,
    ROUND(SUM(AttritionBinary) * 100.0 / COUNT(*), 1) AS AttritionRate_Pct
FROM employees
GROUP BY Department
ORDER BY AttritionRate_Pct DESC;

-- Q3: Attrition Rate by Job Role
SELECT 
    JobRole,
    COUNT(*) AS TotalEmployees,
    SUM(AttritionBinary) AS Attrited,
    ROUND(SUM(AttritionBinary) * 100.0 / COUNT(*), 1) AS AttritionRate_Pct
FROM employees
GROUP BY JobRole
ORDER BY AttritionRate_Pct DESC;

-- Q4: Overtime Impact on Attrition
SELECT 
    OverTime,
    COUNT(*) AS TotalEmployees,
    SUM(AttritionBinary) AS Attrited,
    ROUND(SUM(AttritionBinary) * 100.0 / COUNT(*), 1) AS AttritionRate_Pct,
    ROUND(AVG(MonthlyIncome), 0) AS AvgMonthlyIncome
FROM employees
GROUP BY OverTime
ORDER BY AttritionRate_Pct DESC;

-- Q5: Income Comparison — Stayed vs Left
SELECT 
    Attrition,
    ROUND(AVG(MonthlyIncome), 0) AS AvgMonthlyIncome,
    ROUND(MIN(MonthlyIncome), 0) AS MinIncome,
    ROUND(MAX(MonthlyIncome), 0) AS MaxIncome,
    ROUND(AVG(Age), 1) AS AvgAge,
    ROUND(AVG(TotalWorkingYears), 1) AS AvgWorkingYears
FROM employees
GROUP BY Attrition;

-- Q6: High Risk Segment — Young + Overtime + Low Satisfaction
SELECT 
    COUNT(*) AS HighRiskEmployees,
    SUM(AttritionBinary) AS Attrited,
    ROUND(SUM(AttritionBinary) * 100.0 / COUNT(*), 1) AS AttritionRate_Pct,
    ROUND(AVG(MonthlyIncome), 0) AS AvgIncome
FROM employees
WHERE Age <= 25 
  AND OverTime = 'Yes' 
  AND JobSatisfaction <= 2;

-- Q7: Attrition by Tenure Band
SELECT 
    CASE 
        WHEN YearsAtCompany <= 1 THEN '0-1 Years'
        WHEN YearsAtCompany <= 3 THEN '2-3 Years'
        WHEN YearsAtCompany <= 5 THEN '4-5 Years'
        WHEN YearsAtCompany <= 10 THEN '6-10 Years'
        ELSE '10+ Years'
    END AS TenureBand,
    COUNT(*) AS TotalEmployees,
    SUM(AttritionBinary) AS Attrited,
    ROUND(SUM(AttritionBinary) * 100.0 / COUNT(*), 1) AS AttritionRate_Pct
FROM employees
GROUP BY TenureBand
ORDER BY AttritionRate_Pct DESC;

-- Q8: Department vs Overtime Attrition Risk
SELECT 
    Department,
    OverTime,
    COUNT(*) AS TotalEmployees,
    SUM(AttritionBinary) AS Attrited,
    ROUND(SUM(AttritionBinary) * 100.0 / COUNT(*), 1) AS AttritionRate_Pct,
    ROUND(AVG(MonthlyIncome), 0) AS AvgIncome
FROM employees
GROUP BY Department, OverTime
ORDER BY AttritionRate_Pct DESC;
