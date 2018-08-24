SELECT
	CONCAT('<a href="view_attendance.jsp?semesterid=', CAST(REG.enrollmentSemesterId AS CHAR), '&classid=', CAST(ATD.classId AS CHAR), '&subjectid=', CAST(ATD.subjectId AS CHAR), '&studentid=', CAST(ATD.studentId AS CHAR), '"target="_blank">', CAST(SDT.firstName AS CHAR), ' ', CAST(SDT.lastName AS CHAR), '</a>') AS Name,
	ATD.duration AS Duration,
	ATD.attendanceDate AS Attendance_Date,
        ATD.reasonText
FROM
	Attendance ATD
	INNER JOIN Registrations REG ON ATD.studentId = REG.studentId
	INNER JOIN Students SDT ON ATD.studentId = SDT.studentId
WHERE
	ATD.<ADMINID> AND NOT ATD.isActive = 0 AND
	YEAR(ATD.attendanceDate) > 2017 AND
	ATD.duration = 0 AND ATD.present = 1
GROUP BY Attendance_Date, Name
ORDER BY SDT.firstName, Attendance_Date
LIMIT 10000