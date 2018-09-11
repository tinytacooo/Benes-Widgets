-- ADMIN Widget: New Leads in the Past Week
-- Kelly MJ  |  09/10/2018

SELECT CONCAT('<a target="_blank" href="https://benes.orbund.com/einstein-freshair/admin_view_contact.jsp?contactid=', CAST(C.contactId AS CHAR), '"">', C.firstName, ' ', C.lastName, '</a>') AS 'Contact Name'
	, CT.typeName AS Stage
	, PFV.fieldValue AS 'Program of Interest'
	, DATE(C.lastUpdateDtTm) AS 'Last Updated'

FROM Contacts C

LEFT JOIN ProfileFieldValues PFV
	ON PFV.userId = C.contactId
	AND PFV.fieldName = 'PROGRAM_OF_INTEREST'

LEFT JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId

WHERE C.contactTypeId IN (4000040, 4000043, 4000044, 4000051, 4000045, 4000042, 4000048, 4000047, 4000049)
	AND DATE(C.creationDtTm) >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK)
	AND C.<ADMINID>