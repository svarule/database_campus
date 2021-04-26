use Campus_Eats_Fall2020;
select * from restaurant;

-- test delete
delete from restaurant where restaurant_id = 5;

-- test update view
update view_haps
Set restaurant_id=1;