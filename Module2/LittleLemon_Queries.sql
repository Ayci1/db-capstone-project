use LittleLemonDB;
create or replace view OrdersView AS
select OrderID, Quantity, TotalCost as Cost
from Orders
where Quantity > 2;
select * from OrdersView;

select CustomerID, CustomerName, OrderID, TotalCost, MenuName, MenuItemName, Category
from Orders
join Customerdetails using (CustomerID)
join Menus using (MenuID)
join Menuitems using (MenuItemID)
where TotalCost > 150
order by TotalCost ASC;

select MenuName
from Menus
where MenuID = any (select MenuID from Orders where Quantity > 2);