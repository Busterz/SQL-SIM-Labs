--Lab 3
--Qn 1.1
SELECT hotelName from Hotel
WHERE hotelNo NOT IN (SELECT hotelNo FROM Booking WHERE '25 December 2014' BETWEEN dateFrom AND dateTo);

--Qn 1.2
SELECT hotelName, COUNT(dateFrom) AS 'Most bookings' FROM Hotel, Booking
WHERE Hotel.hotelNo = Booking.hotelNo
GROUP BY hotelName
HAVING COUNT(dateFrom) >= ALL (SELECT COUNT(dateFrom) FROM Booking, Hotel WHERE Hotel.hotelNo = Booking.hotelNo GROUP BY hotelName);

--Qn 1.3
SELECT roomNo FROM Room, Hotel
WHERE Hotel.hotelNo = Room.hotelNo AND hotelName = 'Grosvenor'
EXCEPT 
SELECT roomNo FROM Hotel, Booking
WHERE Hotel.hotelNo = Booking.hotelNo AND Hotel.hotelName = 'Grosvenor'

--Qn 1.4
SELECT Room.roomNo, type, price, guestName, dateFrom, dateTo FROM Room, Hotel, Booking, Guest
WHERE Room.hotelNo = Hotel.hotelNo AND Room.hotelNo = Booking.hotelNo AND Room.roomNo = Booking.roomNo AND Guest.guestNo = Booking.guestNo
AND hotelName = 'Grosvenor'
UNION
SELECT roomNo, type, price, 'Unoccupied' AS Guest_Name, NULL 'Date From', NULL 'Date To' FROM Hotel, Room
WHERE hotelName = 'Grosvenor' AND Hotel.hotelNo = Room.hotelNo AND
Room.roomNo NOT IN (SELECT roomNo FROM Booking WHERE hotelNo = Hotel.hotelNo)

--Qn 1.5
SELECT hotelName 'Hotel', guestName 'Guest', dateFrom 'From', dateTo 'To', DATEDIFF(day,datefrom,dateto) 'Number of Days', DATEDIFF(day,datefrom,dateto)*price 'Amount Payable'
FROM Hotel, Guest, Booking, Room
WHERE Hotel.hotelNo = Booking.hotelNo AND
Booking.hotelNo = Room.hotelNo AND Booking.roomNo = Room.roomNo AND
Booking.guestNo = Guest.guestNo AND
YEAR(dateFrom) = 2014 AND YEAR(dateTo) = 2014

--Qn 1.7
SELECT SUM(price*(DATEDIFF(day,dateFrom,dateTo))) 'Total Income', COUNT(*) 'Total Bookings'
FROM Hotel, Booking, Room
WHERE hotelName = 'Grosvenor' AND
Room.hotelNo = Booking.hotelNo AND Room.roomNo = Booking.roomNo AND
Hotel.hotelNo = Room.hotelNo

--Qn 1.8
SELECT hotelName, Room.type FROM Hotel, Booking, Room
WHERE 
