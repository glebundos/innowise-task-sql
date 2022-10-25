DROP TRIGGER IF EXISTS t_Cards_Update
GO
DROP TRIGGER IF EXISTS t_Cards_Insert
GO



CREATE TRIGGER t_Cards_Update
ON Cards INSTEAD OF UPDATE
AS BEGIN
	DECLARE @CardID INT
	DECLARE @UserID INT
	DECLARE @BankID INT
	DECLARE @CardMoney DECIMAL(10,2)
	DECLARE @AccontMoney DECIMAL(10,2)
	DECLARE @CardsSum DECIMAL (10,2)
	SELECT @CardID = ID, @UserID = UserID, @BankID = BankID, @CardMoney = Money FROM INSERTED
	SELECT @AccontMoney = a.Money
	FROM Accounts a
		JOIN Cards c ON a.UserID = c.UserID AND a.BankID = c.BankID
	WHERE c.ID = @CardID
	SELECT @CardsSum = SUM(c.Money) - (SELECT c1.Money FROM Cards c1 WHERE c1.ID = @CardID) + @CardMoney
	FROM Cards c
	WHERE c.UserID = @UserID
		AND c.BankID = @BankID
	IF @CardsSum <= @AccontMoney
	BEGIN
		UPDATE Cards
		SET UserID = @UserID, BankID = @BankID, Money = @CardMoney
		WHERE ID = @CardID
	END
	ELSE
	BEGIN
		PRINT 'The amount of money on the cards is more than the account money'
	END
END
GO

CREATE TRIGGER t_Cards_Insert
ON Cards INSTEAD OF INSERT
AS BEGIN
	DECLARE @CardID INT
	DECLARE @UserID INT
	DECLARE @BankID INT
	DECLARE @CardMoney DECIMAL(10,2)
	DECLARE @AccontMoney DECIMAL(10,2)
	DECLARE @CardsSum DECIMAL (10,2)
	SELECT @CardID = ID, @UserID = UserID, @BankID = BankID, @CardMoney = Money FROM INSERTED
	SELECT @AccontMoney = a.Money
	FROM Accounts a
		JOIN Cards c ON a.UserID = c.UserID AND a.BankID = c.BankID
	WHERE c.ID = @CardID
	SELECT @CardsSum = SUM(c.Money) - (SELECT c1.Money FROM Cards c1 WHERE c1.ID = @CardID) + @CardMoney
	FROM Cards c
	WHERE c.UserID = @UserID
		AND c.BankID = @BankID
	IF @CardsSum <= @AccontMoney
	BEGIN
		INSERT INTO Cards (UserID, BankID, Money)
		VALUES (@UserID, @BankID, @CardsSum)
	END
	ELSE
	BEGIN
		PRINT 'The amount of money on the cards is more than the account money'
	END
END