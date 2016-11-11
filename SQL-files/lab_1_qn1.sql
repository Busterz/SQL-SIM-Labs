--Qn 1.1
CREATE TABLE Hotel
(
	hotelNo CHAR(3),
	hotelName VARCHAR(30) NOT NULL,
	city VARCHAR(20),
	phoneNo CHAR(7),
	PRIMARY KEY (hotelNo)
);

CREATE TABLE Room
(
	hotelNo CHAR(3),
	roomNo CHAR(3),
	type CHAR(1),
	price DEC(6,2)
	PRIMARY KEY (hotelNo, roomNo),
	FOREIGN KEY (hotelNo) REFERENCES Hotel
);

CREATE TABLE Guest
(
	guestNo CHAR(4),
	guestName VARCHAR(30),
	guestAddress VARCHAR(50)
	PRIMARY KEY (guestNo)
);

CREATE TABLE Booking
(
	hotelNo CHAR(3),
	guestNo CHAR(4),
	dateFrom DATE,
	dateTo DATE,
	CHECK (dateTo >= dateFrom),
	roomNo CHAR(3),
	PRIMARY KEY (hotelNo, guestNo, dateFrom),
	FOREIGN KEY (guestNo) REFERENCES Guest,
	FOREIGN KEY (hotelNo, roomNo) REFERENCES Room
);


--Qn 1.2
--Part a
INSERT INTO Hotel VALUES ('H1', 'Grosvenor', 'London', '4335252');
INSERT INTO Hotel VALUES ('H2', 'Raffles', 'Singapore', '6544532');
INSERT INTO Hotel VALUES ('H3', 'St.James', 'London', '4332133');

--Part b
INSERT INTO Room VALUES ('H1', '001','S',200);
INSERT INTO Room VALUES ('H1', '002','S',300);
INSERT INTO Room VALUES ('H1', '003','D',350);
INSERT INTO Room VALUES ('H1', '004','F',600);
INSERT INTO Room VALUES ('H2', '001','S',300);
INSERT INTO Room VALUES ('H2', '002','D',1000);
INSERT INTO Room VALUES ('H2', '003','D',600);
INSERT INTO Room VALUES ('H3', '001','S',600);
INSERT INTO Room VALUES ('H3', '002','S',900);
INSERT INTO Room VALUES ('H3', '003','S',1000);

INSERT INTO guest VALUES ('G1','William Smith','Gatswick, England');
INSERT INTO guest VALUES ('G2','Tammy Lee','Clementi, Singapore');
INSERT INTO guest VALUES ('G3','Jessica Lee Watts','Bangkok, Thailand');
INSERT INTO guest VALUES ('G4','Jonas Tan','Jurong, Singapore');
INSERT INTO guest VALUES ('G5','Lee Ming Yong','Woodlands, Singapore');

INSERT INTO booking VALUES ('H1','G2','4 Dec 2013','10 Dec 2013','001');
INSERT INTO booking VALUES ('H1','G1','4 Oct 2013','23 Dec 2013','002');
INSERT INTO booking VALUES ('H2','G1','1 Oct 2014','3 Oct 2014','001');
INSERT INTO booking VALUES ('H3','G1','4 Oct 2014','10 Oct 2014','003');
INSERT INTO booking VALUES ('H2','G2','4 Oct 2014','14 Oct 2014','001');
INSERT INTO booking VALUES ('H1','G3','1 Oct 2014','13 Oct 2014','001');
INSERT INTO booking VALUES ('H2','G4','1 Oct 2014','10 Oct 2014','002');
INSERT INTO booking VALUES ('H1','G2','4 Oct 2014','10 Oct 2014','001');
INSERT INTO booking VALUES ('H3','G2','29 Oct 2014','23 Nov 2014','001');
INSERT INTO booking VALUES ('H1','G3','5 Oct 2014','30 Oct 2014','002');
INSERT INTO booking VALUES ('H1','G2','11 Sep 2014','30 Nov 2014','001');
INSERT INTO booking VALUES ('H1','G3','11 Sep 2014','27 Dec 2014','002');
INSERT INTO booking VALUES ('H2','G1','15 Sep 2014','16 Sep 2014','003');

SELECT * FROM Hotel;
SELECT * FROM Room;
SELECT * FROM Booking;
SELECT * FROM Guest;


--Qn 1.3
--Part a
/**
 * Can also: alter table room add constraint check_type_price check (...)
 * or: alter table room add constraint check_type check (type in('s','d','f'));
       alter table room add constraint check_price check (price>=200 and price<=1000);
*/
ALTER TABLE Room ADD CHECK (type IN ('S','D','F') AND price BETWEEN 200 AND 1000);

--Part b
/* Can also: alter table hotel add unique(hoteName); */
ALTER TABLE Hotel ADD CONSTRAINT hotelName_unique UNIQUE(hotelName);

--Part c
ALTER TABLE Hotel ADD contactNo CHAR(11);
UPDATE Hotel SET contactNo = phoneNo;
ALTER TABLE Hotel DROP COLUMN phoneNo;

--Part d
/*
INSERT INTO hotel VALUES ('H4','Grosvenor','New York','4332133'); - because the hotelName has to be unique due to added constraint
INSERT INTO hotel VALUES ('H4',null,'San Francisco','4332133'); - because the hotelName cannot be null due to constraint
INSERT INTO room VALUES ('H2', '004','P',1000); - because the type has to be one of the categories (s,d,f) due to added constraint
INSERT INTO room VALUES ('H3', '004','S',100); - because the price has to be min 200 due to added constraint
INSERT INTO booking VALUES ('H3','G1','5 Oct 2014','10 Oct 2014',8); - There is no 8, FK violation
INSERT INTO booking VALUES ('H3','G1','4 Oct 2014','10 Oct 2014',1); - There is alr a booking for the same guest at the same hotel on the same day, FK violation
INSERT INTO booking VALUES ('H2','G2','15 Dec 2014','18 Dec 2002',3); - dateFrom can't be bigger than dateTo
INSERT INTO booking VALUES ('H2','G8','15 Dec 2014','18 Dec 2014',3); - There is no G8
*/


--Qn 1.4
DELETE FROM Booking WHERE YEAR(dateTo) < 2014;

--Qn 1.5
UPDATE Room
SET price = price * 0.9
WHERE price > 800;

--Qn 1.6
UPDATE Room
SET price = price * 1.1;

--Qn 1.7
UPDATE Hotel
SET contactNo = '+44' + contactNo
WHERE city = 'London';

UPDATE Hotel
SET contactNo = '+65' + contactNo
WHERE city = 'Singapore';


--Qn 1.8
/* Can also: insert into booking values ('H2', 'G1', '2015-01-15', null, '003'); */
INSERT INTO Booking (hotelNo, guestNo, dateFrom, roomNo) VALUES ('H2', 'G1', '2015-01-15', '003');

