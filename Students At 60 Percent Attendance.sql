-- Scheduled Attendance (Query Report)
-- Author: Kelly MJ   |   7/26/2018
    -- Lists students who are at 60% attendance or lower

SELECT CONCAT("Campus: ", CASE WHEN SA.campusCode = 34652 THEN 'New Port Richey'
	        WHEN SA.campusCode = 34601 THEN 'Brooksville'
            WHEN SA.campusCode = 34606 THEN 'Spring Hill'
		END) 'Student Name'
	 , null 'Program', null 'Percent Attended'
FROM SubAdmins SA
WHERE SA.subAdminId = [USERID]
AND SA.<ADMINID>

UNION
    
(SELECT t1.name
              , t1.program
              , CONCAT(t1.percent, '%')

FROM (
SELECT CONCAT('<a href="admin_view_student.jsp?studentid=', CAST(S.studentId AS CHAR), '">', CONCAT(UCASE(SUBSTRING(S.firstname, 1, 1)),LCASE(SUBSTRING(S.firstname, 2))," ",CONCAT(UCASE(SUBSTRING(S.lastName, 1, 1)),LCASE(SUBSTRING(S.lastName, 2)))), '</a>') 'Name'  -- Name (link)
     , P.programmeName 'Program' -- Program name
     , 100*FORMAT( SUM(A.duration)/(SUM(C.instructHour)/COUNT(A.attendanceId)), 2) 'percent'                                             -- Percentage (numerical)

FROM Registrations R
   
INNER JOIN (SELECT studentId, MAX(startDate) AS maxDate FROM Registrations GROUP BY studentId) R2
ON R2.studentId = R.studentId AND R2.maxDate = R.startDate

INNER JOIN Attendance A
ON R.studentId = A.studentId
AND A.isActive = 1
AND A.attendanceDate >= R.startDate

INNER JOIN Classes C
ON C.classId = A.classId
AND C.isActive = 1
AND C.subjectId IN (SELECT subjectId FROM GroupSubjectReltn GSR, CourseGroups CG
					WHERE CG.programmeId=R.programmeId AND CG.isActive=1
                    AND CG.courseGroupId=GSR.courseGroupId AND GSR.isActive=1)

INNER JOIN ClassStudentReltn CSR
ON CSR.classId = C.classId
AND CSR.isActive = 1
AND R.studentId = CSR.studentId

INNER JOIN Programmes P
ON P.programmeId = R.programmeId

INNER JOIN Students S
ON R.studentId = S.studentId
AND S.isActive = 1

WHERE R.isActive = 1
AND R.studentCampus = (SELECT campusCode from SubAdmins WHERE subAdminId = [USERID])
AND R.<ADMINID>
AND S.firstName NOT IN ('Test', 'TEST', 'test')
  
GROUP BY R.registrationId
) t1

WHERE t1.percent <= 60
ORDER BY t1.percent ASC)
