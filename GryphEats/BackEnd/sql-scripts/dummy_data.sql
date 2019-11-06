source static_topping.sql;

insert into restaurant values (null, 'moms kitchen', '905123456', '09:00:00', '21:00:00', 'TESTDATA', 1);

select @restaurant_id := restaurantid from restaurant where description = 'TESTDATA';

insert into user values (null, 'scott', 'riva', '905123456', 'home', 'a@a.com' , 'ewwt', 0);

select @user_id := userid from user where email = 'a@a.com';

insert into foodorder values (null, '2019-12-31 23:59:59', null, @restaurant_id, 0, @user_id);

select @order_id := orderid from foodorder where timeplaced ='2019-12-31 23:59:59';

insert into food values (null, 'chicken fingers', 0, 4.49, @restaurant_id, 1, 'TESTDATA', 1);

select @food_id := foodid from food where description = 'TESTDATA';

insert into orderitem values (@order_id, @food_id ,null);
insert into menu values (null, @restaurant_id, 'TESTMENU', 'cool foods', 1);

select @identifier := identifier from orderitem inner join foodorder where timeplaced = '2019-12-31 23:59:59';


insert into topping values (0, @identifier);

select @menu_id := menuid from menu where title = 'TESTMENU';

insert into menuitem values (@menu_id, @food_id);
