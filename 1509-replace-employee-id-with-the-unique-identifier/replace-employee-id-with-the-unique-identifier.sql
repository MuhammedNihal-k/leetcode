# Write your MySQL query statement below
SELECT ee.unique_id,e.name FROM Employees e LEFT JOIN  EmployeeUNI ee ON e.id=ee.id;