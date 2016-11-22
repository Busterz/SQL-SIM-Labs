--Lab 2
--Qn 2.1
SELECT ename, age FROM Employee, Department WHERE eid = managerid;

--Qn 2.2
SELECT ename, salary FROM Employee, Works WHERE Employee.eid = Works.eid AND did = 'HR';

--Qn 2.3
--SELECT did AS 'Department No', COUNT(eid) AS 'Total Employees' FROM Works WHERE did = 'Finance' GROUP BY did;
SELECT did AS 'Department No', COUNT(*) AS 'Total Employees' FROM Works GROUP BY did HAVING COUNT(*) > 5;

--Qn 2.4
SELECT managerid, SUM(budget) AS 'Total Budget' FROM Department
HAVING SUM(budget) >= 5000000 
GROUP BY managerid;
