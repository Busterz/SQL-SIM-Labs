-Lab 2
--Qn 1.1
SELECT hotelNo, hotelName, contactNo FROM Hotel WHERE city = 'London';

--Qn 1.2
SELECT hotelNo, roomNo, type, price FROM Room WHERE type = 'D' AND price < 400;

--Qn 1.3
SELECT guestNo, guestname, guestAddress FROM Guest WHERE guestAddress LIKE '%Singapore';

--Qn 1.4
SELECT dateFrom, roomNo, guestNo FROM Booking WHERE hotelNo = 'H2' AND '10 October 2014' BETWEEN dateFrom AND dateTo;

--Qn 1.5
SELECT guestNo, guestName, guestAddress FROM Guest WHERE guestName LIKE '%Lee%' AND guestAddress NOT LIKE '%Singapore';

--Qn 1.6
SELECT DISTINCT hotelName, guestName FROM Hotel, Guest, Booking WHERE Hotel.hotelNo = Booking.hotelNo AND Guest.guestNo = Booking.guestNo
ORDER BY hotelName ASC, guestName DESC;

--Qn 1.7
SELECT type AS 'Type of Room', COUNT(type) FROM Room, Hotel WHERE Room.hotelNo = Hotel.hotelNo AND Hotel.hotelName = 'Grosvenor' GROUP BY type;

--Qn 1.8
SELECT guestName, COUNT(Booking.hotelNo) AS 'Number of Bookings' FROM Guest, Booking, Hotel
WHERE Guest.guestNo = Booking.guestNo AND Booking.hotelNo = Hotel.hotelNo AND hotelName = 'Grosvenor' 
Group By guestName, Guest.guestNo
HAVING COUNT(Booking.hotelNo) > 1;

--Qn 1.9
SELECT Room.roomNo, dateFrom, dateTo, DATEDIFF(day, dateFrom, dateTo) AS 'Number of Days', price, DATEDIFF(day, dateFrom, dateTo)*price AS 'TotalRevenue'
FROM Room, Booking, Hotel
WHERE Hotel.hotelNo = Room.hotelNo AND Hotel.hotelNo = Booking.hotelNo AND Room.roomNo = Booking.roomNo
AND type = 'S' AND (dateFrom >= '2014-10-01' AND dateTo <= '2014-10-31') AND Hotel.hotelName = 'Grosvenor';

--Qn 1.10
SELECT hotelName, SUM(DATEDIFF(day, dateFrom, dateTo)*price) AS 'TotalRevenue'
FROM Hotel, Room, Booking
WHERE Hotel.hotelNo = Room.hotelNo AND Hotel.hotelNo = Booking.hotelNo AND Room.roomNo = Booking.roomNo
AND '2014' BETWEEN YEAR(dateFrom) AND YEAR(dateTo)
GROUP BY hotelName;
