-- Current Attended Hours in School (student widget)
-- Author: Kelly MJ   |   7/26/2018
    -- Lists students who are at 60% attendance or lower
    
SELECT 
     , FORMAT(SUM(A.duration),2) 'Total Hours Attended in Program'    -- hours attended
     , SUM(C.instructHour)/COUNT(A.attendanceId) 'Hours Scheduled'          -- hours scheduled
     , FORMAT(SUM(C.instructHour)/COUNT(A.attendanceId) - SUM(A.duration), 2) 'Hours Remaining' -- hours remaining
    
FROM (SELECT MAX(REG.startDate) AS startDate
           , REG.studentId
           , REG.programmeId
           , REG.registrationId
       FROM Registrations REG
       WHERE REG.isActive = 1
	   GROUP BY REG.studentId
       ORDER BY REG.registrationDate DESC) R
        , ClassStudentReltn CSR
        , Classes C
        , Attendance A
        , Students S
   
WHERE R.studentId = A.studentId AND R.studentId = CSR.studentId AND R.studentId = S.studentId       -- studentId criteria
AND C.classId = A.classId AND C.classId = CSR.classId                       -- classId criteria
AND C.subjectId IN (SELECT subjectId FROM GroupSubjectReltn GSR, CourseGroups CG
					WHERE CG.programmeId=R.programmeId AND CG.isActive=1
                    AND CG.courseGroupId=GSR.courseGroupId AND GSR.isActive=1)
AND C.isActive = 1 AND A.isActive = 1 AND CSR.isActive = 1  AND S.isActive = 1              -- isActive criteria
AND A.attendanceDate >= R.startDate                                       -- attendance date criteria
  
GROUP BY R.registrationId