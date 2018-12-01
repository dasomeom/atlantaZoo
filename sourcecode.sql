/* Login */
--verify valid credentials
SELECT *
FROM ADMINS, VISITORS, STAFF
WHERE Email = $email AND Password = $password;

/* New visitor registration */
--verify registration is valid
SELECT *
FROM VISITORS, STAFF
WHERE Email = $email OR Email = $email;
--insert new visitor account
INSERT INTO VISITORS
VALUES ($username, $password, $email, 'VISITOR');
--insert new STAFF account
INSERT INTO STAFF
VALUES ($username, $password, $email, 'STAFF');


/* SEARCH EXHIBITS */
-- default view
SELECT Name, Size, COUNT(*) as ANIMAL.Exhibits, (CASE WHEN Water_Feature =1
THEN 'True'
ELSE 'False'
END
) AS Water,
FROM EXHIBITS
JOIN ANIMAL ON ANIMAL.Exhibits = EXHIBITS.Name
WHERE Name = $name
# Group by ??

--search by term filter
SELECT
	Name,
	Size, COUNT(*) as ANIMAL.Exhibits, (CASE WHEN Water_Feature =1
THEN 'True'
ELSE 'False'
END
) AS Water,
FROM EXHIBITS
JOIN ANIMAL ON ANIMAL.Exhibits = EXHIBITS.Name
WHERE $searchby = $search
# Group by ??
--sort by name
SELECT
	Name,
	Size, COUNT(*) as ANIMAL.Exhibits, (CASE WHEN Water_Feature =1
THEN 'True'
ELSE 'False'
END
) AS Water,
FROM EXHIBITS
JOIN ANIMAL ON ANIMAL.Exhibits = EXHIBITS.Name
WHERE $searchby = $search
ORDER By Name
-- Filter
SELECT
	Name,
	Size, COUNT(*) as ANIMAL.Exhibits, (CASE WHEN Water_Feature =1
THEN 'True'
ELSE 'False'
END
) AS Water,
FROM EXHIBITS
JOIN ANIMAL ON ANIMAL.Exhibits = EXHIBITS.Name
WHERE COUNT(*) as ANIMAL.Exhibits < $max AND COUNT(*) as ANIMAL.Exhibits > $min

/* EXHIBITS DETAILS */
SELECT
	Name,
	Size, COUNT(*) as ANIMAL.Exhibits, (CASE WHEN Water_Feature =1
THEN 'True'
ELSE 'False'
END
) AS Water, ANIMAL.Name, ANIMAL.Species
FROM EXHIBITS
JOIN ANIMAL ON ANIMAL.Exhibits = EXHIBITS.Name
WHERE Name = $name

--log insert
INSERT INTO VISIT_EXHIBIT VALUES (CURRENT_TIMESTAMP, $exhibit_name, $username, $visitor_email);


/* ANIMAL DETAILS */
SELECT
	*
FROM ANIMAL
WHERE Name = $name

/* SEARCH ANIMALS */
-- default view
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL

--search by name
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL
WHERE Name = $searchName
--search by species
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL
WHERE Species = $searchSpecies
ORDER By Name
-- Filter
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL
WHERE Age < $max AND Age > $min AND Exhibit = $exhibit AND Type = $type

/* SEARCH Shows */
-- default view
SELECT Name, Located_At, Date_and_time
FROM SHOWS

--search by name
SELECT Name, Located_At, Date_and_time
FROM SHOWS
WHERE Name = $searchName
--filter by date_and_time
SELECT Name, Located_At, Date_and_time
FROM SHOWS
WHERE Date_and_time = $visitdatetime
--filter by exhibit
SELECT Name, Located_At, Date_and_time
FROM SHOWS
WHERE Located_At = $exhibit

--log insert
INSERT INTO VISIT_SHOW VALUES ($show_name, $username, $visitor_email, CURRENT_TIMESTAMP);

/* Exhibit History */
SELECT Exhibit_name, Datetime, COUNT(Datetime) 
FROM VISIT_EXHIBIT

--filter 
SELECT Exhibit_name, Datetime, COUNT(Datetime) 
FROM VISIT_EXHIBIT
WHERE Exhibit_name = $searchName 
--filter 
SELECT Exhibit_name, Datetime, COUNT(Datetime) 
FROM VISIT_EXHIBIT
WHERE COUNT(Datetime) > $min AND COUNT(Datetime) < $max
--filter 
SELECT Exhibit_name, Datetime, COUNT(Datetime) 
FROM VISIT_EXHIBIT
WHERE Datetime = $dateandtime

/* Show History */
SELECT Shows_name, Time, COUNT(Time) 
FROM VISIT_SHOW
--filter 
SELECT Shows_name, Time, COUNT(Time) 
FROM VISIT_SHOW
WHERE Shows_name = $searchName 
--filter 
SELECT Shows_name, Time, COUNT(Time) 
FROM VISIT_SHOW
WHERE COUNT(Time) > $min AND COUNT(Time) < $max
--filter 
SELECT Shows_name, Time, COUNT(Time) 
FROM VISIT_SHOW
WHERE Time = $dateandtime

/* STAFF Show */
SELECT
	Name,
	Size, Date_and_time, Located_At
FROM SHOWS
WHERE SHOWS.Host = $username


/* STAFF ANIMALS */
-- default view
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL

--search by name
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL
WHERE Name = $searchName
--search by species
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL
WHERE Species = $searchSpecies
ORDER By Name
-- Filter
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL
WHERE Age < $max AND Age > $min AND Exhibit = $exhibit AND Type = $type

/* ANIMAL CARE */
SELECT Username, Text, Time
FROM NOTE
--log note
INSERT INTO NOTE VALUES (CURRENT_TIMESTAMP, $notelog, $username, $animalname, $species, $email);


/* Admin: Manage Visitors */
SELECT Username, Email
FROM VISITORS
--delete user
DELETE FROM VISITORS
WHERE Username = $username

/* Admin: Manage Staff */
SELECT Username, Email
FROM STAFF
--delete user
DELETE FROM STAFF
WHERE Username = $username

/* Admin: Manage Shows */
SELECT Name, Located_At, Date_and_time 
FROM SHOWS
--search by name
SELECT Name, Located_At, Date_and_time
FROM SHOWS
WHERE Name = $searchName
--filter by date_and_time
SELECT Name, Located_At, Date_and_time
FROM SHOWS
WHERE Date_and_time = $visitdatetime
--filter by exhibit
SELECT Name, Located_At, Date_and_time
FROM SHOWS
WHERE Located_At = $exhibit

--delete show
DELETE FROM SHOWS
WHERE Name = $showname AND Located_At = $exhibit AND Date_and_time = $datetimeInfo

/* Admin: Manage animals */
-- default view
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL

--search by name
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL
WHERE Name = $searchName
--search by species
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL
WHERE Species = $searchSpecies
ORDER By Name
-- Filter
SELECT Name, Species, Exhibit, Age, Type
FROM ANIMAL
WHERE Age < $max AND Age > $min AND Exhibit = $exhibit AND Type = $type
--delete animal
DELETE FROM ANIMAL
WHERE Name = $name AMD species = $species

/* Admin: ADD animals */
INSERT INTO ANIMAL VALUES($age, $type, $species, $name, $exhibit)

/* Admin: ADD Shows */
INSERT INTO SHOWS VALUES($name, $dateandtime, $exhibit, $staff)
