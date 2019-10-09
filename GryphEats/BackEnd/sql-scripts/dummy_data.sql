insert into foodorder values (null, 'oct3TEST', null);
insert into restaurant values (null, 'moms kitchen', '905123456', '9am', '9pm', 'TESTDATA', 1);


select @restaurant_id := restaurantid from restaurant where description = 'TESTDATA';
select @order_id := orderid from foodorder where timeplaced ='oct3TEST';

insert into user values (null, 'scott', 'riva', '905123456', 'home', 'a@a.com' , 'ewwt', @order_id, @order_id);
insert into food values (null, 'chicken fingers', 0, 4.49, @restaurant_id, 1, 'TESTDATA', 1);

select @food_id := foodid from food where description = 'TESTDATA';

insert into orderitem values (@order_id, @food_id ,null);
insert into menu values (10, @restaurant_id, 'TESTMENU', 'cool foods', 1);

select @identifier := identifier from orderitem inner join foodorder where timeplaced = 'oct3TEST';


insert into topping values (0, @identifier);

select @menu_id := menuid from menu where title = 'TESTMENU';

insert into menuitem values (@menu_id, @food_id);
