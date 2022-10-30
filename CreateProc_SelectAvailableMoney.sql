CREATE PROC SelectAvailableMoney
AS
SELECT a1.UserID, a1.BankID, a1.Available
FROM
(
	SELECT a2.UserID, a2.BankID,
		(SELECT a2.Money - SUM(c.Money)
		 FROM Accounts a
			JOIN Cards c ON c.UserID = a.UserID AND c.BankID = a.BankID
			JOIN Users u ON a.UserID = u.ID
		 WHERE c.UserID = A2.UserID AND c.BankID = A2.BankID
		) Available
	FROM Accounts a2
		JOIN Users u2 ON a2.UserID = u2.ID
		JOIN Banks b2 ON a2.BankID = b2.ID
) a1