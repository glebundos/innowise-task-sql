DROP TRIGGER IF EXISTS t_Account_Insert
GO
DROP TRIGGER IF EXISTS t_Account_Update
GO

CREATE TRIGGER t_Account_Insert
ON Accounts INSTEAD OF INSERT
AS BEGIN
	DECLARE @AccountMoney DECIMAL(10,2)
	DECLARE @UserID INT
	DECLARE @BankID INT
	DECLARE @CardSum DECIMAL(10,2)
	SELECT @AccountMoney = Money, @UserID = UserID, @BankID = BankID
	FROM INSERTED
	SELECT @CardSum = SUM(c.Money)
	FROM Cards c
	WHERE c.UserID = @UserID
		AND c.BankID = @BankID
	IF @CardSum IS NULL OR (@AccountMoney > @CardSum)
	BEGIN
		INSERT INTO Accounts (UserID, BankID, Money)
		VALUES (@UserID, @BankID, @AccountMoney)
	END
	ELSE
	BEGIN
		PRINT 'The amount of money transferred to the account is less than the amount of money on all cards of this account'
	END

END
GO

CREATE TRIGGER t_Account_Update
ON Accounts INSTEAD OF UPDATE
AS BEGIN
	DECLARE @AccountMoney DECIMAL(10,2)
	DECLARE @UserID INT
	DECLARE @BankID INT
	DECLARE @CardSum DECIMAL(10,2)
	SELECT @AccountMoney = Money, @UserID = UserID, @BankID = BankID
	FROM INSERTED
	SELECT @CardSum = SUM(c.Money)
	FROM Cards c
	WHERE c.UserID = @UserID
		AND c.BankID = @BankID
	IF @CardSum IS NULL OR (@AccountMoney > @CardSum)
	BEGIN
		UPDATE Accounts
		SET Money = @AccountMoney
		WHERE UserID = @UserID 
			AND BankID = @BankID
	END
	ELSE
	BEGIN
		PRINT 'The amount of money transferred to the account is less than the amount of money on all cards of this account'
	END

END