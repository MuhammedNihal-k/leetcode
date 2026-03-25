# Write your MySQL query statement below
SELECT 
    d.name AS department,
    e.name AS employee,
    e.salary
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY departmentId ORDER BY salary DESC) AS rnk
    FROM Employee
) e
JOIN department d 
ON e.departmentId = d.id
WHERE rnk = 1;