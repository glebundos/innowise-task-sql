CREATE PROCEDURE AddMoneyToCards
	@SocialID INT
AS
IF 
	@SocialID = (SELECT s.ID 
				 FROM Statuses s 
				 WHERE s.ID = @SocialID)
BEGIN
	-- There are such a social status
	IF
		(SELECT COUNT(s.ID)
		 FROM Accounts a
			JOIN Users u ON a.UserID = u.ID
			JOIN Statuses s ON u.StatusesID = s.ID
		 WHERE s.ID = @SocialID) > 0
	BEGIN
		-- There are cards with such social status
		UPDATE Cards
		SET Money = c.Money + 10
		FROM Cards c
				JOIN Accounts a ON c.UserID = a.UserID AND c.BankID = a.BankID
				JOIN Users u ON a.UserID = u.ID
				JOIN Statuses s ON u.StatusesID = s.ID
		WHERE s.ID = @SocialID
	END
	ELSE
	BEGIN
		PRINT 'No cards with such social status'
	END

END
ELSE
BEGIN
	PRINT 'There are NO such a social status'
END