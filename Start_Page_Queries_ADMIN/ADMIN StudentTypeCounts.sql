SELECT CONCAT('Enrolled students as of yesterday (', DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 DAY), "%m/%d/%y"), '): ') AS 'Student Type'
    , COUNT(DISTINCT S.idNumber) AS Count
    
FROM Students S
	, Registrations R

WHERE S.studentId = R.studentId
	AND R.isActive = 1 AND R.enrollmentSemesterId = 4000441
	AND S.isActive = 1 AND S.firstName NOT LIKE '%test%' AND S.lastName NOT LIKE '%test%'
    AND S.studentId Not In (Select Distinct L.studentId From LeavesOfAbsence L WHERE L.isActive = 1 AND (leaveDate < Now() AND (L.returnDate IS NULL OR L.returnDate > NOW())))
    AND DATE(S.lastUpdateDtTm) < CURDATE() AND DATE(R.lastUpdateDtTm) < CURDATE()
    AND S.<ADMINID>

UNION

SELECT CONCAT('New starts in the past week:') AS 'Student Type'
	, COUNT(DISTINCT S.idNumber)
    
FROM Students S
INNER JOIN Registrations R
	ON R.studentId = S.studentId
    AND R.enrollmentSemesterId = 4000441

WHERE S.isActive = 1
	AND R.isActive = 1
	AND S.firstName NOT LIKE '%test%' AND S.lastName NOT LIKE '%test%'
	AND DATE(S.lastUpdateDtTm) <= CURDATE() AND DATE(S.lastUpdateDtTm) >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
    AND R.startDate <= CURDATE() AND R.startDate >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
    AND S.<ADMINID>
    
UNION

SELECT CONCAT('Graduates in the past week:') AS 'Student Type'
	, COUNT(DISTINCT S.idNumber)
    
FROM Students S
INNER JOIN Registrations R
	ON R.studentId = S.studentId
    AND R.enrollmentSemesterId = 4000441

WHERE S.isActive = 3
	AND S.firstName NOT LIKE '%test%' AND S.lastName NOT LIKE '%test%'
	AND DATE(S.lastUpdateDtTm) <= CURDATE() AND DATE(S.lastUpdateDtTm) >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
    AND R.graduationDate <= CURDATE() AND R.graduationDate >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
    AND S.<ADMINID>
    
UNION

SELECT CONCAT('Drops in the past week:') AS 'Student Type'
	, COUNT(DISTINCT S.idNumber)
    
FROM Students S
INNER JOIN Registrations R
	ON R.studentId = S.studentId
    AND R.enrollmentSemesterId = 4000441

WHERE S.isActive = 0
	AND S.firstName NOT LIKE '%test%' AND S.lastName NOT LIKE '%test%'
	AND DATE(S.lastUpdateDtTm) <= CURDATE() AND DATE(S.lastUpdateDtTm) >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
    AND R.graduationDate <= CURDATE() AND R.graduationDate >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
    AND S.<ADMINID>

UNION

SELECT CONCAT('LOA in the past week:') AS 'Student Type'
	, COUNT(DISTINCT S.idNumber)
    
FROM Students S
INNER JOIN Registrations R
	ON R.studentId = S.studentId
    AND R.enrollmentSemesterId = 4000441
INNER JOIN LeavesOfAbsence LOA
	ON LOA.studentId = S.studentId
    AND LOA.leaveDate >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK) AND LOA.leaveDate <= CURDATE()

WHERE S.isActive = 0
	AND S.firstName NOT LIKE '%test%' AND S.lastName NOT LIKE '%test%'
	AND DATE(S.lastUpdateDtTm) <= CURDATE() AND DATE(S.lastUpdateDtTm) >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
    AND R.graduationDate <= CURDATE() AND R.graduationDate >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
    AND S.<ADMINID>