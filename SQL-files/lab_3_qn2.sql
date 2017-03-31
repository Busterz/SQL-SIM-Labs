--Lab 3
--Qn 2.1
SELECT ename 'Name', age FROM Employee, Works
WHERE Works.eid = AND did = 'Hardware' AND Employee.eid IN (SELECT eid FROM Works WHERE did = 'Software')

--Qn 2.2
SELECT DISTINCT ename FROM Employee, Works w
WHERE w.eid = Employee.eid AND
salary > ALL(SELECT budget FROM Department WHERE Department.did = w.did)

--Qn 2.3
SELECT managerid FROM Department
WHERE budget > 1000000 AND managerid NOT IN (
SELECT managerid FROM Department WHERE budget <= 1000000)

--Qn 2.4
SELECT ename FROM Employee, Department
WHERE managerid = eid AND budget = (SELECT MAX(budget) FROM Department)

--Qn 2.5
SELECT managerid FROM Department
GROUP BY managerid
HAVING SUM(budget) >= ALL(SELECT SUM(budget) FROM Department GROUP BY managerid)

--Qn 2.6
SELECT ename FROM Employee, Works
WHERE Employee.eid = Works.eid AND did = 'Hardware' AND
Employee.eid NOT IN (SELECT eid FROM Works WHERE did = 'Software')