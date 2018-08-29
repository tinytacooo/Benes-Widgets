-- Total Attendance Hours Graph: Admin-view widget
-- Author: Kelly MJ  |  08/29/2018
-- Shows cumulative hours attended per day for the past 7 days

SELECT A.attendanceDate
	, SUM(A.duration) AS 'Total Attendance Hours vs. Date'
    
FROM Attendance A

WHERE A.attendanceDate >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) AND A.attendanceDate < CURDATE()
AND A.<ADMINID>

GROUP BY A.attendanceDate