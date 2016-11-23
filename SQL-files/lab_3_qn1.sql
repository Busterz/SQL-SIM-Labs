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
SELECT Booking.roomNo, type, price,guestName, dateFrom, dateTo FROM Room, Hotel, Booking, Guest
WHERE Room.hotelNo = Hotel.hotelNo AND Hotel.hotelNo = Booking.hotelNo AND Room.roomNo = Booking.roomNo AND Guest.guestNo = Booking.guestNo
AND hotelName = 'Grosvenor'
UNION ALL
SELECT * FROM
(
SELECT Room.roomNo, type, price, NULL 'dateFrom', NULL 'dateTo' FROM Room, Hotel
WHERE Hotel.hotelNo = Room.hotelNo AND hotelName = 'Grosvenor'
EXCEPT 
SELECT Booking.roomNo, type, price, NULL 'dateFrom', NULL 'dateTo' FROM Hotel, Booking, Room
WHERE Room.hotelNo = Hotel.hotelNo AND Hotel.hotelNo = Booking.hotelNo AND Room.roomNo = Booking.roomNo
AND hotelName = 'Grosvenor'
) AS a
