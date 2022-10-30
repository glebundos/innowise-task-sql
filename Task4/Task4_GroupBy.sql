SELECT s.Name as "Status", COUNT(c.Id) as "Cards Count"
FROM Cards c
	JOIN Accounts a ON c.UserID = a.UserID AND c.BankID = a.BankID
	JOIN Users u ON a.UserID = u.ID
	JOIN Statuses s ON u.StatusesID = s.ID
GROUP BY s.Name
ORDER BY COUNT(c.Id) DESC