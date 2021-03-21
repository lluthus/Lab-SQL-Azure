

SELECT *
FROM Waterfalls
RIGHT OUTER JOIN Countries ON Waterfalls.Country = Countries.CountryName

SELECT *
FROM Countries
LEFT OUTER JOIN Waterfalls ON Waterfalls.Country = Countries.CountryName

