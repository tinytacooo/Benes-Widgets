-- Report: Graduated Students Without Scheduled Test Dates
-- Author: Kelly MJ   |   Creation date: 8/3/2018
-- Purpose: Display a list of students who have graduated since the "Report Start Date" who have not scheduled their state board exam.
		 -- The list is ordered by the least-to-most recent graduation dates

SELECT S.idNumber 'Student ID'
	 , CONCAT('<a href="admin_view_student.jsp?studentid=', CAST(S.studentId AS CHAR), '">', S.firstName, ' ', S.lastName, '</a>') AS 'Student Name'
     , MAX(R.endDate) AS 'Graduation Date'
     , CASE WHEN R.regStatus =  3 THEN 'Graduated'
            WHEN R.regStatus = 16 THEN 'Pending Grad'
	   END AS 'Status'

FROM Registrations R
   , Students S
   , Programmes P
   , ProfileFieldValues PFV

WHERE R.studentId = S.studentId			-- Student table join
  AND R.programmeId = P.programmeId		-- Programme table join
  AND P.programmeName NOT LIKE '%career%'
  AND R.studentId = PFV.userId			-- PFV table join
  AND PFV.fieldName LIKE 'EXAM_DATE'
  AND (PFV.fieldValue IS NULL OR PFV.fieldValue < '1970-01-01')
  AND R.regStatus IN (3, 16)			-- Registration/graduation criteria
  AND R.isActive = 1
  AND R.enrollmentSemesterId = 4000441
  AND R.endDate > '[?Report Start Date]'
  AND R.<ADMINID>
GROUP BY S.studentId

ORDER BY R.endDate ASC