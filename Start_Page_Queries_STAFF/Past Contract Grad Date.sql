SELECT
	CONCAT('<a href="admin_view_student.jsp?studentid=', CAST(SDT.studentId AS CHAR), '">', CAST(SDT.firstName AS CHAR), ' ', CAST(SDT.lastName AS CHAR), '</a>') AS Name

, CASE WHEN SDT.studentCampus = '34652' THEN 'New Port Richey'
   WHEN SDT.studentCampus = '34606' THEN 'Spring Hill'
   WHEN SDT.studentCampus = '34601' THEN 'Brooksville'
   ELSE 'Unknown/Other'
 END AS 'Student Campus'

    
FROM  Registrations REG
INNER JOIN Students  SDT ON REG.studentId = SDT.studentId AND SDT.isactive = 1
WHERE SDT.<ADMINID> AND REG.enrollmentSemesterId = 4000441 AND REG.EndDate <= current_date() AND REG.graduationDate IS NULL
GROUP BY SDT.studentID
ORDER BY SDT.firstName