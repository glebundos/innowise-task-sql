SELECT DISTINCT a.UserID, a.BankID, a.Money,
	(SELECT SUM(c1.Money)
	 FROM Cards c1
	 WHERE c1.UserID = a.UserID AND c1.BankID = a.BankID) as "Card Sum",
	 a.Money - (SELECT SUM(c1.Money)
	 FROM Cards c1
	 WHERE c1.UserID = a.UserID AND c1.BankID = a.BankID) as "Diff"
FROM Accounts a
	JOIN Cards c ON c.UserID = a.UserID AND c.BankID = a.BankID
WHERE a.Money <> 
	(SELECT SUM(c1.Money)
	 FROM Cards c1
	 WHERE c1.UserID = a.UserID AND c1.BankID = a.BankID)