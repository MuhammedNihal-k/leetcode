# Write your MySQL query statement below
SELECT n.name, b.bonus
FROM Employee n
LEFT JOIN Bonus b
ON n.empId = b.empId
WHERE b.bonus < 1000 OR b.bonus IS NULL;