SELECT
	CONCAT('<a href="admin_view_student.jsp?studentid=', CAST(SID AS CHAR), '">', First, ' ', Last, '</a>') AS 'Student Name' ,
	Class_Name AS 'Class Name',
	Hours_Attended AS 'Hours Attended',
        PPD.PayperiodHours AS 'Next Pay Period',
        ROUND((PPD.PayperiodHours - Hours_Attended),2) AS 'Hours Till Period'
FROM
	Registrations REG
	INNER JOIN PayPeriod PPD ON REG.programmeId = PPD.programmeId AND PPD.isActive = 1
        INNER JOIN Programmes PRG ON PRG.programmeId = REG.programmeId AND PPD.isActive = 1
	INNER JOIN(
		SELECT
		        SDT.Firstname AS First,
                        SDT.LastName AS Last,
			SDT.studentId AS SID,
			CLS.className AS Class_Name,
			CLS.subjectId AS Subject_ID,
			FORMAT(SUM(ATD.duration),2) AS Hours_Attended
		FROM
			Attendance ATD
			INNER JOIN Students SDT ON ATD.studentId = SDT.studentId AND SDT.isActive = 1   -- 1 means active students only
			INNER JOIN Classes CLS ON ATD.classId = CLS.classId AND CLS.isActive=1
		WHERE
			ATD.<ADMINID> AND NOT ATD.isActive=0
		GROUP BY ATD.studentId) AS userZ ON REG.studentId = SID
	
WHERE
	REG.<ADMINID> AND REG.isActive=1 AND
	REG.endDate>=CURDATE() AND
	Hours_Attended < PPD.payPeriodHours AND PPD.payPeriodHours < Hours_Attended + 21 AND PRG.minClockHours >= Hours_Attended + 21 AND
	Subject_ID IN (SELECT GSR.subjectId
					FROM CourseGroups CGP
					INNER JOIN GroupSubjectReltn GSR ON CGP.courseGroupId=GSR.courseGroupId AND GSR.isActive=1
					WHERE REG.programmeId = CGP.programmeId and CGP.isActive=1)

ORDER BY Last