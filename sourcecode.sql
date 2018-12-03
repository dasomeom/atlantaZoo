/*CS4400 All SQL */


/*Create Table from Phase 2 */
USE atlzoo;

CREATE TABLE `exhibit` (
  `Size` int(11) NOT NULL,
  `Water_Feature` tinyint(1) NOT NULL,
  `Name` varchar(20) NOT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
# Comment to grading TA
# For Water_Feature, value of zero is false, Non­zero values are considered true
CREATE TABLE `animal` (
  `Age` int(11) NOT NULL,
  `Type` enum('Amphibian','Bird','Fish','Invertebrate','Mammal','Reptile') NOT NULL,
  `Species` varchar(20) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Exhibit` varchar(20) NOT NULL,
  PRIMARY KEY (`Name`,`Species`),
  KEY `Exhibit` (`Exhibit`),
  CONSTRAINT `animal_ibfk_1` FOREIGN KEY (`Exhibit`) REFERENCES `exhibit` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `admins` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Email` varchar(30) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `visitors` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Email` varchar(30) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `staff` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Email` varchar(30) NOT NULL,
  PRIMARY KEY (`Username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `shows` (
  `Name` varchar(20) NOT NULL,
  `Date_and_time` datetime NOT NULL,
  `Located_at` varchar(20) NOT NULL,
  `Host` varchar(20) NOT NULL,
  PRIMARY KEY (`Name`,`Date_and_time`),
  KEY `Located_at` (`Located_at`),
  KEY `Host` (`Host`),
  CONSTRAINT `shows_ibfk_1` FOREIGN KEY (`Located_at`) REFERENCES `exhibit` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `shows_ibfk_2` FOREIGN KEY (`Host`) REFERENCES `staff` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `note` (
  `Time` timestamp NOT NULL,
  `Text` text,
  `Username` varchar(20) NOT NULL,
  `Name` varchar(20) NOT NULL,
  `Species` varchar(20) NOT NULL,
  `Staff_email` varchar(30) NOT NULL,
  PRIMARY KEY (`Time`,`Username`,`Name`,`Species`,`Staff_email`),
  KEY `Username` (`Username`),
  KEY `Name` (`Name`,`Species`),
  CONSTRAINT `note_ibfk_1` FOREIGN KEY (`Username`) REFERENCES `staff` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `note_ibfk_2` FOREIGN KEY (`Name`, `Species`) REFERENCES `animal` (`name`, `species`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `visit_show` (
  `Shows_name` varchar(20) NOT NULL,
  `Visitor_username` varchar(20) NOT NULL,
  `Visitor_Email` varchar(30) NOT NULL,
  `Time` timestamp NOT NULL,
  PRIMARY KEY (`Time`,`Visitor_username`,`Shows_name`),
  KEY `Shows_name` (`Shows_name`),
  KEY `Visitor_username` (`Visitor_username`),
  CONSTRAINT `visit_show_ibfk_1` FOREIGN KEY (`Shows_name`) REFERENCES `shows` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `visit_show_ibfk_2` FOREIGN KEY (`Visitor_username`) REFERENCES `visitors` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci

CREATE TABLE `visit_exhibit` (
  `Datetime` timestamp NOT NULL,
  `Exhibit_name` varchar(20) NOT NULL,
  `Visitor_username` varchar(20) NOT NULL,
  `Visitor_Email` varchar(30) NOT NULL,
  PRIMARY KEY (`Datetime`,`Exhibit_name`,`Visitor_username`),
  KEY `Exhibit_name` (`Exhibit_name`),
  KEY `Visitor_username` (`Visitor_username`),
  CONSTRAINT `visit_exhibit_ibfk_1` FOREIGN KEY (`Exhibit_name`) REFERENCES `exhibit` (`name`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `visit_exhibit_ibfk_2` FOREIGN KEY (`Visitor_username`) REFERENCES `visitors` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


/*Data Insertion Script*/

INSERT INTO STAFF(Username, Password, Email) 
VALUES('martha_johnson', 'password1', 'marthajohnson@hotmail.com'),
('benjamin_rao', 'password2', 'benjaminrao@gmail.com'),
('ethan_roswell', 'password3', 'ethanroswell@yahoo.com');

INSERT INTO VISITORS (Username, Password, Email)
VALUES('xavier_swenson', 'password4', 'xavierswenson@outlook.com'),
('isabella_rodriguez', 'password5', 'isabellarodriguez@mail.com'),
('nadias_tevens', 'password6', 'nadiastevens@gmail.com'),
('robert_bernheardt', 'password7', 'robertbernheardt@yahoo.com');

INSERT INTO ADMINS (Username, Password, Email)
VALUES('admin1', 'adminpassword', 'adminemail@mail.com');

INSERT INTO EXHIBIT (Size, Water_Feature, Name)
VALUES(850, 1, 'Pacific'),
(600, 0, 'Jungle'),
(1000, 0, 'Sahara'),
(1200, 0, 'Mountainous'),
(1000, 1, 'Birds');

INSERT INTO SHOWS(Name, Date_and_time, Located_at, Host)
VALUES('Jungle Cruise', '2018-10-06 09:00:00', 'Jungle', 'martha_johnson'),
('Feed the Fish', '2018-10-08 12:00:00', 'Pacific', 'martha_johnson'),
('Fun Facts', '2018-10-09 15:00:00', 'Sahara', 'martha_johnson'),
('Climbing', '2018-10-10 16:00:00', 'Mountainous', 'benjamin_rao'),
('Flight of the Birds', '2018-10-11 15:00:00', 'Birds', 'ethan_roswell'),
('Jungle Cruise', '2018-10-12 14:00:00', 'Jungle', 'martha_johnson'),
('Feed the Fish', '2018-10-12 14:00:00', 'Pacific', 'ethan_roswell'),
('Fun Facts', '2018-10-13 13:00:00', 'Sahara', 'benjamin_rao'),
('Climbing', '2018-10-13 17:00:00', 'Mountainous', 'benjamin_rao'),
('Flight of the Birds', '2018-10-14 14:00:00', 'Birds', 'ethan_roswell'),
('Bald Eagle Show', '2018-10-15 14:00:00', 'Birds', 'ethan_roswell');

INSERT INTO ANIMAL(Age, Type, Species, Name, Exhibit)
VALUES(1, 'Fish', 'Goldfish', 'Goldy', 'Pacific'),
(2, 'Fish', 'Clownfish', 'Lincoln', 'Pacific'),
(3, 'Amphibian', 'Poison Dart frog', 'Pedro', 'Jungle'),
(8, 'Mammal', 'Lion', 'Lincoln', 'Sahara'),
(6, 'Mammal', 'Goat', 'Greg', 'Mountainous'),
(4, 'Bird', 'Bald Eagle', 'Brad', 'Birds');


/* Implementation SQL code */
/*We need   when we really run the code in flask.*/

/* Login */
--verify valid credentials
SELECT *
FROM ADMINS, VISITORS, STAFF
WHERE Email = $email AND Password = $password;
#What we used
SELECT * FROM admins WHERE Username = %s, (username)
SELECT * FROM admins WHERE Email = %s, (email)


/* New visitor registration */
--verify registration is valid
SELECT * FROM VISITORS, STAFF WHERE Username = $username OR Email = $email;
--insert new visitor account
INSERT INTO VISITORS VALUES ($username, $password, $email, 'VISITOR');
--insert new STAFF account
INSERT INTO STAFF VALUES ($username, $password, $email, 'STAFF');

#what we used
SELECT * FROM admins WHERE Username = %s, (username)
INSERT INTO  + db_name +  (Username, Password, Email) VALUES(%s, %s, %s), (username, password, email))

/* VISITOR HOME */
# NOTHING

/* VISITOR SEARCH EXHIBITS */
-- default view
SELECT exhibit.* COUNT(animal.Exhibit) 
FROM exhibit 
LEFT JOIN animal 
ON exhibit.Name = animal.Exhibit 
GROUP BY exhibit.Name

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

--sort by name (ASC DSC)
SELECT exhibit.*, COUNT(animal.Exhibit) 
FROM exhibit LEFT JOIN animal 
ON exhibit.Name = animal.Exhibit 
GROUP BY exhibit.Name 
ORDER BY exhibit.Name

SELECT exhibit.*, COUNT(animal.Exhibit) 
FROM exhibit LEFT JOIN animal 
ON exhibit.Name = animal.Exhibit 
GROUP BY exhibit.Name 
ORDER BY exhibit.Name DESC

--sort by Exhibit Size                               
SELECT exhibit.*, COUNT(animal.Exhibit) 
FROM exhibit LEFT JOIN animal 
ON exhibit.Name = animal.Exhibit 
GROUP BY exhibit.Name 
ORDER BY exhibit.Size

SELECT exhibit.*, COUNT(animal.Exhibit) 
FROM exhibit LEFT JOIN animal 
ON exhibit.Name = animal.Exhibit 
GROUP BY exhibit.Name 
ORDER BY exhibit.Size DESC

--sort by count                
SELECT exhibit.*, COUNT(animal.Exhibit) 
FROM exhibit LEFT JOIN animal 
ON exhibit.Name = animal.Exhibit 
GROUP BY exhibit.Name 
ORDER BY COUNT(animal.Exhibit)
SELECT exhibit.*, COUNT(animal.Exhibit) 
FROM exhibit LEFT JOIN animal 
ON exhibit.Name = animal.Exhibit 
GROUP BY exhibit.Name 
ORDER BY COUNT(animal.Exhibit) DESC

--sort by water feature                
SELECT exhibit.*, COUNT(animal.Exhibit) 
FROM exhibit LEFT JOIN animal 
ON exhibit.Name = animal.Exhibit 
GROUP BY exhibit.Name 
ORDER BY exhibit.Water_Feature

SELECT exhibit.*, COUNT(animal.Exhibit) 
FROM exhibit LEFT JOIN animal 
ON exhibit.Name = animal.Exhibit 
GROUP BY exhibit.Name 
ORDER BY exhibit.Water_Feature DESC

-- Filter overall 
SELECT Size, Water_Feature, Name, num FROM 
(SELECT exhibit.*, COUNT(animal.Exhibit) as num 
FROM exhibit LEFT JOIN animal ON exhibit.Name = animal.Exhibit 
GROUP BY exhibit.Name) as foo 
WHERE (%s IS NULL OR Name = %s) and (%s IS NULL OR Water_Feature = %s) 
AND (%s IS NULL OR Size >= %s) AND (%s IS NULL OR Size <= %s) 
AND (%s IS NULL OR num >= %s) AND (%s IS NULL OR num <= %s),
(searchkey, searchkey, hasWater, hasWater, min_size, min_size, max_size, max_size, min_num, min_num, max_num, max_num))

/* EXHIBITS DETAILS */
--getting email
SELECT Email FROM visitors WHERE Username = %s, (session['username'])
--getting exhibit detail
SELECT Datetime, Exhibit_name, Visitor_username FROM visit_exhibit 
WHERE Datetime = %s AND Exhibit_name = %s AND Visitor_username = %s,
(note_now, name, session['username']

--log insert
INSERT INTO visit_exhibit (Datetime, Exhibit_name, Visitor_username, Visitor_Email) VALUES(%s, %s, %s, %s),
                    (note_now, name, session['username'], email)


/* Exhibit History */

--default 
SELECT * FROM (SELECT foo.Exhibit_name, foo.Datetime, boo.cc FROM atlzoo.visit_exhibit AS foo
Left Join ( SELECT Exhibit_name, Count(*) as cc FROM atlzoo.visit_exhibit
WHERE visit_exhibit.Visitor_username = %s GROUP BY Exhibit_name ) AS boo
On foo.Exhibit_name = boo.Exhibit_name) as haa, (session['username']))

--sort by name
SELECT * FROM (SELECT foo.Exhibit_name, foo.Datetime, boo.cc FROM atlzoo.visit_exhibit AS foo 
Left Join ( SELECT Exhibit_name, Count(*) as cc FROM atlzoo.visit_exhibit 
WHERE visit_exhibit.Visitor_username = %s GROUP BY Exhibit_name ) AS boo 
On foo.Exhibit_name = boo.Exhibit_name) as haa ORDER BY haa.Exhibit_name,
(session['username']))
SELECT * FROM 
(SELECT foo.Exhibit_name, foo.Datetime, boo.cc FROM atlzoo.visit_exhibit AS foo 
Left Join ( SELECT Exhibit_name, Count(*) as cc FROM atlzoo.visit_exhibit 
WHERE visit_exhibit.Visitor_username = %s GROUP BY Exhibit_name ) AS boo 
On foo.Exhibit_name = boo.Exhibit_name) as haa ORDER BY haa.Exhibit_name DESC,
(session['username'])    

-- sort by time

SELECT * FROM (SELECT foo.Exhibit_name, foo.Datetime, boo.cc FROM atlzoo.visit_exhibit AS foo 
Left Join ( SELECT Exhibit_name, Count(*) as cc FROM atlzoo.visit_exhibit 
WHERE visit_exhibit.Visitor_username = %s GROUP BY Exhibit_name ) AS boo 
On foo.Exhibit_name = boo.Exhibit_name) as haa ORDER BY haa.Datetime,
(session['username'])
SELECT * FROM (SELECT foo.Exhibit_name, foo.Datetime, boo.cc FROM atlzoo.visit_exhibit AS foo 
Left Join ( SELECT Exhibit_name, Count(*) as cc FROM atlzoo.visit_exhibit 
WHERE visit_exhibit.Visitor_username = %s GROUP BY Exhibit_name ) AS boo 
On foo.Exhibit_name = boo.Exhibit_name) as haa ORDER BY haa.Datetime DESC,
(session['username'])   

-- sort by number of visits
SELECT * FROM 
(SELECT foo.Exhibit_name, foo.Datetime, boo.cc FROM atlzoo.visit_exhibit AS foo 
Left Join ( SELECT Exhibit_name, Count(*) as cc FROM atlzoo.visit_exhibit 
WHERE visit_exhibit.Visitor_username = %s GROUP BY Exhibit_name ) AS boo 
On foo.Exhibit_name = boo.Exhibit_name) as haa ORDER BY haa.cc,
(session['username'])
SELECT * FROM 
(SELECT foo.Exhibit_name, foo.Datetime, boo.cc FROM atlzoo.visit_exhibit AS foo 
Left Join ( SELECT Exhibit_name, Count(*) as cc FROM atlzoo.visit_exhibit 
WHERE visit_exhibit.Visitor_username = %s GROUP BY Exhibit_name ) AS boo 
On foo.Exhibit_name = boo.Exhibit_name) as haa ORDER BY haa.cc DESC,
(session['username'])

-- Filter 
SELECT * FROM 
(SELECT foo.Exhibit_name, foo.Datetime, boo.cc FROM atlzoo.visit_exhibit AS foo 
Left Join ( SELECT Exhibit_name, Count(*) as cc FROM atlzoo.visit_exhibit 
WHERE visit_exhibit.Visitor_username = %s GROUP BY Exhibit_name ) AS boo 
On foo.Exhibit_name = boo.Exhibit_name) as haa 
WHERE (%s IS NULL OR haa.Exhibit_name = %s) AND (%s IS NULL OR DATE(haa.Datetime) = %s) 
AND (%s IS NULL OR haa.cc >= %s) AND (%s IS NULL OR haa.cc <= %s),
(session['username'], search_exh, search_exh, exh_date, exh_date, min_num, min_num, max_num, max_num))


/* SEARCH ANIMALS */

-- default view
SELECT Name, Species, Exhibit, Age, Type FROM ANIMAL
-- sort by name
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Name
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Name DESC
-- sort by Species
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Species
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Species DESC
-- sort by Exhibit
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Exhibit
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Exhibit DESC
-- sort by Age
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Age
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Age DESC
-- sort by Type
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Type
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Type DESC
--choose the information to send to Animal Detail page
SELECT Name, Species, Exhibit, Age, Type FROM animal

--Filtering
SELECT Name, Species, Exhibit, Age, Type FROM animal WHERE
%s IS NULL OR Name LIKE %s) AND (%s IS NULL OR Species LIKE %s)
AND (%s IS NULL OR Exhibit = %s) AND (%s IS NULL OR Age >= %s) 
AND (%s IS NULL OR Age <= %s) AND (%s IS NULL OR Type = %s),
(search_name, search_name, search_spec, search_spec, exh_option, exh_option, min_age, min_age, max_age, max_age, type_option, type_option))

/* ANIMAL DETAILS */
SELECT * FROM ANIMAL WHERE (Name = %s AND Species = %s), (ani_name, ani_species)

/** Search Shows **/
--default
SELECT Name, Date_and_time, Located_at FROM shows

--sort by name
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Name
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Name DESC

--sort by exhibit name
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Located_at
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Located_at DESC

--sort by datetime
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Date_and_time
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Date_and_time DESC

--when search is null, show default page
SELECT Name, Date_and_time, Located_at FROM shows
-- or in other case, show the information in search option 
SELECT Name, Date_and_time, Located_at FROM shows 
WHERE (%s IS NULL OR Name LIKE %s) AND (%s IS NULL OR DATE(Date_and_time) = %s) 
AND (%s IS NULL OR Located_at = %s), (name, name, searchTime, searchTime, option, option))
-- when log visit is clicked no info was provided show default
SELECT Name, Date_and_time, Located_at FROM shows
-- select the info in interest
SELECT Shows_name, Visitor_username, Time FROM visit_show WHERE Shows_name = %s AND Visitor_username = %s AND Time = %s,
                (show_name, user_name, show_datetime))
-- log visit show
INSERT INTO visit_show (Shows_name, Visitor_username, Visitor_Email, Time) VALUES(%s, %s, %s, %s), (show_name, user_name, user_email, show_datetime))
                
/* Show History */
-- default page
SELECT shows.Name, shows.Located_at, shows.Date_and_time 
FROM (SELECT Shows_name, Time FROM visit_show WHERE visit_show.Visitor_username = %s) as foo 
JOIN shows ON shows.Name = foo.Shows_name AND shows.Date_and_time = foo.Time;, (session['username']))

--sort by name
SELECT shows.Name, shows.Located_at, shows.Date_and_time 
FROM (SELECT Shows_name, Time FROM visit_show WHERE visit_show.Visitor_username = %s) as foo 
JOIN shows ON shows.Name = foo.Shows_name AND shows.Date_and_time = foo.Time 
ORDER BY shows.Name;,(session['username'])
SELECT shows.Name, shows.Located_at, shows.Date_and_time 
FROM (SELECT Shows_name, Time FROM visit_show WHERE visit_show.Visitor_username = %s) as foo 
JOIN shows ON shows.Name = foo.Shows_name AND shows.Date_and_time = foo.Time 
ORDER BY shows.Name DESC;, (session['username'])

--sort by exhibit name
SELECT shows.Name, shows.Located_at, shows.Date_and_time 
FROM (SELECT Shows_name, Time FROM visit_show WHERE visit_show.Visitor_username = %s) as foo 
JOIN shows ON shows.Name = foo.Shows_name AND shows.Date_and_time = foo.Time 
ORDER BY shows.Located_at;,(session['username'])
SELECT shows.Name, shows.Located_at, shows.Date_and_time 
FROM (SELECT Shows_name, Time FROM visit_show WHERE visit_show.Visitor_username = %s) as foo 
JOIN shows ON shows.Name = foo.Shows_name AND shows.Date_and_time = foo.Time 
ORDER BY shows.Located_at DESC;, (session['username'])
--sort by time
SELECT shows.Name, shows.Located_at, shows.Date_and_time 
FROM (SELECT Shows_name, Time FROM visit_show WHERE visit_show.Visitor_username = %s) as foo 
JOIN shows ON shows.Name = foo.Shows_name AND shows.Date_and_time = foo.Time 
ORDER BY shows.Date_and_time;, (session['username'])
SELECT shows.Name, shows.Located_at, shows.Date_and_time 
FROM (SELECT Shows_name, Time FROM visit_show WHERE visit_show.Visitor_username = %s) as foo 
JOIN shows ON shows.Name = foo.Shows_name AND shows.Date_and_time = foo.Time 
ORDER BY shows.Date_and_time DESC;, (session['username'])
--filter option 
SELECT * FROM 
(SELECT shows.Name, shows.Located_at, shows.Date_and_time 
FROM (SELECT Shows_name, Time FROM visit_show 
WHERE visit_show.Visitor_username = %s) as foo 
JOIN shows ON shows.Name = foo.Shows_name AND shows.Date_and_time = foo.Time) as boo 
WHERE (%s IS NULL OR Name LIKE %s) AND (%s IS NULL OR Located_at = %s) 
AND (%s IS NULL OR DATE(Date_and_time) = %s), (session['username'], search_name, search_name, exh_option, exh_option, show_date, show_date)                               

/** STAFF HOME **/
-- store username
SELECT Username FROM STAFF WHERE Username = %s, (staff_name)

/* STAFF Show */
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s, (staff_name)
--sort by name
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Name, (staff_name)
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Name DESC, (staff_name)
--sort by exhibit name
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Located_at, (staff_name)
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Located_at DESC, (staff_name)
--sort by time
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Date_and_time, (staff_name)
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Date_and_time DESC, (staff_name)


/* STAFF ANIMALS */

-- default view
SELECT Name, Species, Exhibit, Age, Type FROM ANIMAL
-- sort by name
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Name
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Name DESC
-- sort by Species
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Species
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Species DESC
-- sort by Exhibit
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Exhibit
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Exhibit DESC
-- sort by Age
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Age
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Age DESC
-- sort by Type
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Type
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Type DESC
--choose the information to send to Animal Detail page
SELECT Name, Species, Exhibit, Age, Type FROM animal

--Filtering
SELECT Name, Species, Exhibit, Age, Type FROM animal WHERE
%s IS NULL OR Name LIKE %s) AND (%s IS NULL OR Species LIKE %s)
AND (%s IS NULL OR Exhibit = %s) AND (%s IS NULL OR Age >= %s) 
AND (%s IS NULL OR Age <= %s) AND (%s IS NULL OR Type = %s),
(search_name, search_name, search_spec, search_spec, exh_option, exh_option, min_age, min_age, max_age, max_age, type_option, type_option))

--Send data to animal care page
SELECT Name, Species, Exhibit, Age, Type FROM animal


/* ANIMAL CARE */
SELECT Username, Text, Time FROM NOTE

--sort staff
SELECT Username, Text, Time FROM NOTE ORDER BY Name
SELECT Username, Text, Time FROM NOTE ORDER BY Name DESC

--sort by text
SELECT Username, Text, Time FROM NOTE ORDER BY Text
SELECT Username, Text, Time FROM NOTE ORDER BY Text DESC

--sort by team
SELECT Username, Text, Time FROM NOTE ORDER BY Time
SELECT Username, Text, Time FROM NOTE ORDER BY Time DESC

--before log, get the email info
SELECT Email FROM staff WHERE Username = %s, (note_host)
--getting other info as well
SELECT Name, Species FROM NOTE WHERE Name = %s AND Species = %s AND Time = %s AND Username = %s, (note_name, note_species, note_now, note_host)
--log note
INSERT INTO NOTE (Time, Text, Username, Name, Species, Staff_email) VALUES(%s, %s, %s, %s, %s, %s), (note_now, note_text, note_host, note_name, note_species, note_email)

/** STAFF Show **/

--default
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s, (staff_name)
--sort by name
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Name, (staff_name)
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Name DESC, (staff_name)

--sort by exhibit
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Located_at, (staff_name)
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Located_at DESC, (staff_name)

-- sort by datetime
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Date_and_time, (staff_name)
SELECT Name, Date_and_time, Located_at FROM shows WHERE Host = %s ORDER BY Date_and_time DESC, (staff_name)

/** ADNIM HOME **/
--save admin info
SELECT Username FROM admins WHERE Username = %s, (admin_name)


/* Admin: Manage Visitors */

--default
SELECT Username, Email FROM visitors

--sort by name
SELECT Username, Email FROM visitors ORDER BY Username
SELECT Username, Email FROM visitors ORDER BY Username DESC

--sort by email
SELECT Username, Email FROM visitors ORDER BY Email
SELECT Username, Email FROM visitors ORDER BY Email DESC

--searching visitor
-- if null show default
SELECT Username, Email FROM visitors
-- else 
SELECT Username, Email FROM visitors WHERE  + str(option) +  LIKE %s, % + str(key) + %

-- get info to delete
SELECT Username, Email FROM visitors
-- delete visitor
DELETE FROM visitors WHERE Username = %s, (vis_name)
-- then show default
SELECT Username, Email FROM visitors


/* Admin: Manage Staff */

--default
SELECT Username, Email FROM staff

--sort by name
SELECT Username, Email FROM staff ORDER BY Username
SELECT Username, Email FROM staff ORDER BY Username DESC

--sort by email
SELECT Username, Email FROM staff ORDER BY Email
SELECT Username, Email FROM staff ORDER BY Email DESC

--searching staff
-- if null show default
SELECT Username, Email FROM staff
-- else 
SELECT Username, Email FROM staff WHERE  + str(option) +  LIKE %s, % + str(key) + %

-- get info to delete
SELECT Username, Email FROM staff
-- delete visitor
DELETE FROM staff WHERE Username = %s, (stf_name)
-- then show default
SELECT Username, Email FROM staff

/* Admin: Manage Shows */

--default
SELECT Name, Date_and_time, Located_at FROM shows

--sort by name
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Name
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Name DESC

--sort by Date_and_time
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Date_and_time
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Date_and_time DESC

--sort by Located_at
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Located_at
SELECT Name, Date_and_time, Located_at FROM shows ORDER BY Located_at DESC


--searching staff
-- if null show default
SELECT Name, Date_and_time, Located_at FROM shows
-- else 
SELECT Name, Date_and_time, Located_at FROM shows WHERE (%s IS NULL OR Name LIKE %s) AND (%s IS NULL OR DATE(Date_and_time) = %s) AND (%s IS NULL OR Located_at = %s), (name, name, searchTime, searchTime, option, option))

-- get info to delete
SELECT Name, Date_and_time, Located_at FROM shows
-- delete visitor
DELETE FROM shows WHERE Name = %s AND Located_at = %s AND Date_and_time = %s, (str(show_name),str(show_exh),
                                                                                                    show_datetime))
-- then show default
SELECT Name, Date_and_time, Located_at FROM shows


/* Admin: Manage animals */
-- default view
SELECT Name, Species, Exhibit, Age, Type FROM animal

--sort by name
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Name
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Name DESC

--sort by species
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Species
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Species DESC

--sort by Exhibit
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Exhibit
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Exhibit DESC
--sort by Age
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Age
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Age DESC
--sort by Type
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Type
SELECT Name, Species, Exhibit, Age, Type FROM animal ORDER BY Type DESC

-- Filter
SELECT Name, Species, Exhibit, Age, Type FROM animal WHERE
(%s IS NULL OR Name LIKE %s) AND (%s IS NULL OR Species LIKE %s) 
AND (%s IS NULL OR Exhibit = %s) AND (%s IS NULL OR Age >= %s) 
AND (%s IS NULL OR Age <= %s) AND (%s IS NULL OR Type = %s),
(search_name, search_name, search_spec, search_spec, exh_option, exh_option, min_age, min_age, max_age, max_age, type_option, type_option)

-- before delete, check if it is null
SELECT Name, Species, Exhibit, Age, Type FROM animal

--delete animal
DELETE FROM animal WHERE Age = %s AND Type = %s AND Species = %s AND Name = %s AND Exhibit = %s, (age, ani_type, species, name, exhibit)
--then show the default page
SELECT Name, Species, Exhibit, Age, Type FROM animal


/* Admin: ADD animals */
-- check if there is same animal in db
SELECT Name, Species FROM animal WHERE Name = %s AND Species = %s, (name, spec)
-- add
INSERT INTO animal (Age, Type, Species, Name, Exhibit) VALUES(%s, %s, %s, %s, %s), (age, anitype, spec, name, exh)

/* Admin: ADD Shows */
-- check if there is same show in db
SELECT Name, Date_and_time FROM shows WHERE Name = %s AND Date_and_time = %s, (name, show_datetime)
--add
INSERT INTO shows (Name, Date_and_time, Located_at, Host) VALUES(%s, %s, %s, %s),
                               (name, show_datetime, aniexh, staff)
