SELECT DISTINCT b.Name
FROM Banks b
	JOIN Offices o ON b.ID = o.BankID
	JOIN Towns t ON o.TownID = t.ID
WHERE t.Name = N'Брест';