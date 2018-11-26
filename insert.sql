INSERT INTO STAFF (Username, Password, Email)
VALUES(martha_johnson, password1, marthajohnson@hotmail.com),
(benjamin_rao, password2, benjaminrao@gmail.com),
(ethan_roswell, password3, ethanroswell@yahoo.com);

INSERT INTO VISITORS (Username, Password, Email)
VALUES(xavier_swenson, password4, xavierswenson@outlook.com),
(isabella_rodriguez, password5, isabellarodriguez@mail.com),
(nadias_tevens, password6, nadiastevens@gmail.com),
(robert_bernheardt, password7, robertbernheardt@yahoo.com);

INSERT INTO ADMINS (Username, Password, Email)
VALUES(admin1, adminpassword, adminemail@mail.com);

INSERT INTO EXHIBIT (Size, Water_Feature, Name)
VALUES(850, 1, Pacific),
VALUES(600, 0, Jungle),
VALUES(1000, 0, Sahara),
VALUES(1200, 0, Mountainous),
VALUES(1000, 1, Birds);

INSERT INTO SHOWS(Name, Date_and_time, Located_at, Host)
VALUES(Jungle Cruise, '2018-10-06 09:00:00', Jungle, martha_johnson),
VALUES(Feed the Fish, '2018-10-08 12:00:00', Pacific, martha_johnson),
VALUES(Fun Facts, '2018-10-09 15:00:00', Sahara, martha_johnson),
VALUES(Climbing, '2018-10-10 16:00:00', Mountainous, benjamin_rao),
VALUES(Flight of the Birds, '2018-10-11 15:00:00', Birds, ethan_roswell),
VALUES(Jungle Cruise, '2018-10-12 14:00:00', Jungle, martha_johnson),
VALUES(Feed the Fish, '2018-10-12 14:00:00', Pacific, ethan_roswell),
VALUES(Fun Facts, '2018-10-13 13:00:00', Sahara, benjamin_rao),
VALUES(Climbing, '2018-10-13 17:00:00', Mountainous, benjamin_rao),
VALUES(Flight of the Birds, '2018-10-14 14:00:00', Birds, ethan_roswell),
VALUES(Bald Eagle Show, '2018-10-15 14:00:00', Birds, ethan_roswell);

INSERT INTO ANIMAL(Age, Type, Species, Name, Exhibit)
VALUES(1, Fish, Goldfish, Goldy, Pacific),
VALUES(2, Fish, Clownfish, Lincoln, Pacific),
VALUES(3, Amphibian, Poison Dart frog, Pedro, Jungle),
VALUES(8, Mammal, Lion, Lincoln, Sahara),
VALUES(6, Mammal, Goat, Greg, Mountainous),
VALUES(4, Bird, Bald Eagle, Brad, Birds);













