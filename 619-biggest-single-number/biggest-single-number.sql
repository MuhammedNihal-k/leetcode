# Write your MySQL query statement below
 SELECT MAX(NUM) as num FROM(SELECT NUM FROM  Mynumbers GROUP BY num HAVING COUNT(num)=1)AS num;