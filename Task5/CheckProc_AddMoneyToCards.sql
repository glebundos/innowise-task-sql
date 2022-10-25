SELECT
	c.ID AS "Card ID",
	u.Name AS "User Name",
	s.ID AS "SocialID",
	s.Name AS "Social Status",
	c.Money AS "Money"
FROM Cards c
	JOIN Accounts a ON c.UserID = a.UserID AND c.BankID = a.BankID
	JOIN Users u ON a.UserID = u.ID
	JOIN Statuses s ON u.StatusesID = s.ID
WHERE s.ID = 1

EXEC AddMoneyToCards @SocialID = 1

SELECT
	c.ID AS "Card ID",
	u.Name AS "User Name",
	s.ID AS "SocialID",
	s.Name AS "Social Status",
	c.Money AS "Money"
FROM Cards c
	JOIN Accounts a ON c.UserID = a.UserID AND c.BankID = a.BankID
	JOIN Users u ON a.UserID = u.ID
	JOIN Statuses s ON u.StatusesID = s.ID
WHERE s.ID = 1