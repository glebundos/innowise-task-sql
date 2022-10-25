SELECT A.Name AS "Status", A.Total AS "Cards Count"
FROM
(
	SELECT DISTINCT Name,
		(SELECT COUNT(c2.ID)
		 FROM Cards c2
				JOIN Accounts a2 ON c2.UserID = a2.UserID AND c2.BankID = a2.BankID
				JOIN Users u2 ON a2.UserID = u2.ID
				JOIN Statuses s2 ON u2.StatusesID = s2.ID
		 WHERE s2.ID = s1.ID) Total
	FROM Statuses s1
) A
ORDER BY Total DESC