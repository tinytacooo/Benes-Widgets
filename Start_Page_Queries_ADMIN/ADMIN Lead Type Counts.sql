-- ADMIN Widget: Lead Type Counts
-- Kelly MJ  |  09/10/2018

-- 1. New Leads
SELECT SA.campusCode
	, CT.typeName AS Type
	, COUNT(C.contactId) AS Count

FROM Contacts C

INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
	AND CT.contactTypeId IN (4000040, 4000043, 4000044, 4000051, 4000045, 4000042, 4000048, 4000047, 4000050, 4000049)

LEFT JOIN SubAdmins SA
	ON SA.subAdminId = CT.subAdminId

WHERE C.isActive = 1
	AND C.<ADMINID>

GROUP BY SA.campusCode, CT.typeName