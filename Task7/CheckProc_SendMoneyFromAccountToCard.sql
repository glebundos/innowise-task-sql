SELECT c.ID, c.UserID, c.BankID, c.Money AS "Card Money", a.Money AS "Account Money"
FROM Cards c
	JOIN Accounts a ON a.UserID=c.UserID AND a.BankID=c.BankID
WHERE c.UserID = 1 AND c.BankID = 3

EXEC SendMoneyFromAccountToCard
	@UserID = 1,
	@BankID = 3,
	@CardID = 2,
	@Amount = 20.20

SELECT c.ID, c.UserID, c.BankID, c.Money AS "Card Money", a.Money AS "Account Money"
FROM Cards c
	JOIN Accounts a ON a.UserID=c.UserID AND a.BankID=c.BankID
WHERE c.UserID = 1 AND c.BankID = 3