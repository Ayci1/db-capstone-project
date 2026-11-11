use LittleLemonDB;
drop procedure if exists GetMaxQuantity;
DELIMITER //
create procedure GetMaxQuantity()
begin
    select MAX(Quantity) as 'Max Quantity in Order'
    from Orders;
end //
DELIMITER ;
call GetMaxQuantity();

prepare GetOrderDetail from 
'select OrderID, Quantity, TotalCost as Cost from Orders where CustomerID = ?';
set @id = 1;
execute GetOrderDetail using @id;

DELIMITER //
create procedure CancelOrder(IN OrderIDToCancel INT)
begin
    delete from Orders where OrderID = OrderIDToCancel;
    select concat('Order ', OrderIDToCancel, ' is cancelled')
    as Confirmation;
    end //
DELIMITER ;
call CancelOrder(5);