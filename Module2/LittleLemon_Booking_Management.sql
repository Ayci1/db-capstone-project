use LittleLemonDB;

drop procedure if exists AddBooking;
DELIMITER //
create procedure AddBooking(in BookingIDInput int, in CustomerIDInput int, in TableNumberInput int, in BookingDateInput date)
begin
insert into Bookings (BookingID, CustomerID, TableNumber, BookingDate)
values (BookingIDInput, CustomerIDInput, TableNumberInput, BookingDateInput);
select 'New booking added' as Confirmation;
end //
DELIMITER ;

call AddBooking(9, 3, 4, '2022-12-30');

drop procedure if exists UpdateBooking;
DELIMITER //
create procedure UpdateBooking(in BookingIDInput int, in BookingDateInput date)
begin
update Bookings
set BookingDate = BookingDateInput where BookingID = BookingIDInput;
select concat('Booking ', BookingIDInput, ' updated') as Confirmation;
end //
DELIMITER ;

call UpdateBooking(9, '2022-12-17');

drop procedure if exists CancelBooking;

DELIMITER //
create procedure CancelBooking(in BookingIDInput int)
begin
delete from Bookings
where BookingID = BookingIDInput;
select concat('Booking ', BookingIDInput, ' cancelled') as Confirmation;
end //
DELIMITER ;

call CancelBooking(9);