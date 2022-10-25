CREATE PROC SendMoneyFromAccountToCard
	@UserID INT,
	@BankID INT,
	@CardID INT,
	@Amount DECIMAL(10,2)
AS
BEGIN TRY
BEGIN TRANSACTION
	if @UserID = (SELECT a.UserID FROM Accounts a WHERE a.UserID=@UserID AND a.BankID=@BankID)
		AND @BankID = (SELECT a.BankID FROM Accounts a WHERE a.UserID=@UserID AND a.BankID=@BankID)
	BEGIN
		if @CardID = (SELECT c.ID FROM Cards c WHERE c.ID=@CardID)
		BEGIN
			CREATE TABLE #AvailableMoney
			(
				[UserID] INT,
				[BankID] INT,
				[Available] DECIMAL(10,2)
			)
			INSERT #AvailableMoney EXEC SelectAvailableMoney
			if @Amount <= (SELECT a.Available FROM #AvailableMoney a WHERE a.UserID = @UserID AND a.BankID = @BankID)
			BEGIN
				-- ALL IS OK
				UPDATE Cards
				SET Money = c.Money + @Amount
				FROM Cards c
				WHERE c.UserID = @UserID
					AND c.BankID = @BankID
					AND c.ID = @CardID
			END
			ELSE
			BEGIN
				PRINT 'Not enough money'
				DROP TABLE #AvailableMoney
			END
		END
		ELSE
		BEGIN
			PRINT 'No such card'
		END
	END
	ELSE
	BEGIN
		PRINT 'No such account'
	END
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
END CATCH
COMMIT TRANSACTION