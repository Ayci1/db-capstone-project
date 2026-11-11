use LittleLemonDB;

insert into Bookings (BookingID, BookingDate, TableNumber, CustomerID)
values 
(1, '2022-10-10', 5, 1),
(2, '2022-11-12', 3, 3),
(3, '2022-10-11', 2, 2),
(4, '2022-10-13', 2, 1);
select * from Bookings;

drop procedure if exists CheckBooking;

DELIMITER //
create procedure CheckBooking(in BookingDateInput date, in TableNumberInput int)
begin
declare BookingCount int;
select count(*) into BookingCount
from Bookings
where date(BookingDate) = BookingDateInput and TableNumber = TableNumberInput;
if BookingCount > 0 then 
select concat('Table ', TableNumberInput, ' is already booked') as 'booking status';
else select concat('Table ', TableNumberInput, ' is available') as 'Booking status';
end if;
end //
DELIMITER ;

CALL CheckBooking('2022-11-12', 3);

drop procedure if exists AddValidBooking;

DELIMITER //

create procedure AddVAlidBooking(in BookingDateInput Date, in TableNumberInput int)
begin
declare BookingCount int;
start transaction;
select count(*) into BookingCount
from Bookings 
where date(BookingDate) = BookingDateInput and TableNumber = TableNumberInput;
if BookingCount > 0 then
rollback;
select concat('Table ', TableNumberInput, ' is already booked - booking cancelled') as 'booking status';
else insert into Bookings(BookingDate, TableNumber, CustomerID)
values (BookingDateInput, TableNumberInput, 1);
 commit;
 select 'Booking confirmed' as 'Booking status';
end if;
end //
DELIMITER ;

call AddValidBooking('2022-10-10', 5);