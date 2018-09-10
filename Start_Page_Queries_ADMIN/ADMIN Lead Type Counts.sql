-- ADMIN Widget: Lead Type Counts
-- Kelly MJ  |  09/10/2018

-- 1. New Leads
SELECT CT.typeName AS Type
	, COUNT(C.contactId) AS Count
FROM Contacts C
INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
    AND CT.contactTypeId = 4000040
WHERE C.isActive = 1
	AND C.<ADMINID>

UNION	-- 2. Left Message
SELECT CT.typeName AS Type
	, COUNT(C.contactId) AS Count
FROM Contacts C
INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
    AND CT.contactTypeId = 4000043
WHERE C.isActive = 1
	AND C.<ADMINID>
    
UNION	-- 3. Mailed Catalog
SELECT CT.typeName AS Type
	, COUNT(C.contactId) AS Count
FROM Contacts C
INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
    AND CT.contactTypeId = 4000044
WHERE C.isActive = 1
	AND C.<ADMINID>
    
UNION	-- 4. Made Appointment
SELECT CT.typeName AS Type
	, COUNT(C.contactId) AS Count
FROM Contacts C
INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
    AND CT.contactTypeId = 4000051
WHERE C.isActive = 1
	AND C.<ADMINID>
    
UNION	-- 5. Working
SELECT CT.typeName AS Type
	, COUNT(C.contactId) AS Count
FROM Contacts C
INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
    AND CT.contactTypeId = 4000045
WHERE C.isActive = 1
	AND C.<ADMINID>
    
UNION	-- Nurturing
SELECT CT.typeName AS Type
	, COUNT(C.contactId) AS Count
FROM Contacts C
INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
    AND CT.contactTypeId = 4000042
WHERE C.isActive = 1
	AND C.<ADMINID>
    
UNION	-- 7. In-Financial
SELECT CT.typeName AS Type
	, COUNT(C.contactId) AS Count
FROM Contacts C
INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
    AND CT.contactTypeId = 4000048
WHERE C.isActive = 1
	AND C.<ADMINID>
    
UNION	-- 8. GAIN
SELECT CT.typeName AS Type
	, COUNT(C.contactId) AS Count
FROM Contacts C
INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
    AND CT.contactTypeId = 4000047
WHERE C.isActive = 1
	AND C.<ADMINID>
    
UNION	-- 86. Lost - Not Interested
SELECT CT.typeName AS Type
	, COUNT(C.contactId) AS Count
FROM Contacts C
INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
    AND CT.contactTypeId = 4000050
WHERE C.isActive = 1
	AND C.<ADMINID>

UNION	-- 9. Future Attend Date
SELECT CT.typeName AS Type
	, COUNT(C.contactId) AS Count
FROM Contacts C
INNER JOIN ContactTypes CT
	ON CT.contactTypeId = C.contactTypeId
    AND CT.contactTypeId = 4000049
WHERE C.isActive = 1
	AND C.<ADMINID>