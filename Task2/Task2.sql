SELECT u.Name, c.Money, b.Name
FROM Cards c
	JOIN Accounts a ON c.UserID = a.UserID AND c.BankID = a.BankID
	JOIN Users u ON a.UserID = u.ID
	JOIN Banks b ON a.BankID = b.ID;