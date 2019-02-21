CREATE TABLE #T_Temp
(
	INumber int,
	ISubject nvarchar(50),
	Grade int
)

INSERT INTO #T_Temp VALUES(100, 'Hebrew', 87)
INSERT INTO #T_Temp VALUES(100, 'Dutch', 56)
INSERT INTO #T_Temp VALUES(100, 'English', 97)
INSERT INTO #T_Temp VALUES(101, 'Hebrew', 87)
INSERT INTO #T_Temp VALUES(101, 'Dutch', 45)
INSERT INTO #T_Temp VALUES(101, 'English', 78)
INSERT INTO #T_Temp VALUES(102, 'Hebrew', 56)
INSERT INTO #T_Temp VALUES(102, 'Dutch', 78)
INSERT INTO #T_Temp VALUES(102, 'English', 49)


SELECT INumber,
	Hebrew,
	Dutch,
	English,
	MaxGrade_Subject
FROM
(
	SELECT #T_Temp.*, 
		CAST(InnerSelect1.MaxGrade AS NVARCHAR) + '-' + (SELECT ISubject FROM #T_Temp WHERE INumber = InnerSelect1.INumber AND Grade = InnerSelect1.MaxGrade) AS MaxGrade_Subject
	FROM #T_Temp
		INNER JOIN
		(
			SELECT INumber, MAX(Grade) AS MaxGrade
			FROM #T_Temp
			GROUP BY INumber

		) AS InnerSelect1
			ON #T_Temp.INumber = InnerSelect1.INumber
) AS InnerSelect2
PIVOT
(
	AVG(Grade)
	FOR ISubject IN ([Hebrew], [Dutch], [English])
) AS pvt
ORDER BY INumber

DROP TABLE #T_Temp