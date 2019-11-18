source static_topping.sql;

/*insert into restaurant values (null, 'moms kitchen', '905123456', '09:00:00', '21:00:00', 'TESTDATA', 1);

select @restaurant_id := restaurantid from restaurant where description = 'TESTDATA';*/

/*insert into food values (null, 'chicken fingers', 0, 4.49, @restaurant_id, 1, 'TESTDATA', 1);

select @food_id := foodid from food where description = 'TESTDATA';

select @menu_id := menuid from menu where title = 'TESTMENU';

insert into menuitem values (@menu_id, @food_id);*/

insert into user values (null, 'scott', 'riva', '905123456', 'home', 'a@a.com' , 'ewwt', 0, 'What is your dogs name?', 'Spot');

select @user_id := userid from user where email = 'a@a.com';

insert into notif values(@user_id, 'HF66GG5G8JVX5O0', '#token');

insert into restaurant values (null, 'Some place', '519123456', '08:00:00', '20:00:00', 'idk', 1);
insert into restaurant values (null, 'Mom''s Kitchen', '519123456', '08:00:00', '20:00:00', 'Homecooked food', 1);

select @restaurant_id := restaurantid from restaurant where description = 'idk';
select @restaurant_id2 := restaurantid from restaurant where description = 'Homecooked food';

insert into user values (null, 'Scott', 'Riva', '905123456', '10 Stone Rd', 'scott@mail.com' , 'ewr7wefh7', 0, '', '');
insert into user values (null, 'Domenic', 'Bianchi', '519654321', '3 Gordon St', 'dom@mail.com' , '217e177', 1, '', '');

insert into food values (null, 'Hamburger', 0, 8.49, @restaurant_id, 1, 'Plain Hamburger', 0);
insert into food values (null, 'Cheeseburger', 0, 8.99, @restaurant_id, 1, 'Burger with cheese', 0);
insert into food values (null, 'Bacon Cheeseburger', 0, 9.49, @restaurant_id, 1, 'Burger with bacon and cheese', 0);

insert into food values (null, 'Chicken fingers', 0, 4.49, @restaurant_id2, 1, 'chicken fingers with choice of sauce', 2);
insert into food values (null, 'Pizza', 0, 6.99, @restaurant_id, 1, 'Penne with red sauce', 1);
insert into food values (null, 'Chicken tenders', 0, 5.49, @restaurant_id, 1, 'chicken fingers with choice of sauce', 2);

select @food_id1 := foodid from food where displayname = 'Hamburger';
select @food_id2 := foodid from food where displayname = 'Cheeseburger';
select @food_id3 := foodid from food where displayname = 'Bacon Cheeseburger';

select @food_id4 := foodid from food where displayname = 'Chicken fingers';
select @food_id5 := foodid from food where displayname = 'Pizza';
select @food_id6 := foodid from food where displayname = 'Chicken tenders';

insert into foodorder values (null, '2019-12-31 23:59:59', null, @restaurant_id, 0, @user_id, 'Peanut allergy!!!');

select @order_id := orderid from foodorder where timeplaced = '2019-12-31 23:59:59';


insert into orderitem values (@order_id, @food_id1 ,null);
insert into menu values (null, @restaurant_id, 'TESTMENU', 'cool foods', 0);

select @identifier := identifier from orderitem inner join foodorder where timeplaced = '2019-12-31 23:59:59';


insert into topping values (0, @identifier);

insert into menu values (null, @restaurant_id, 'The Classics', 'Best burgers in town', 1);
insert into menu values (null, @restaurant_id2, 'All Day Menu', 'Moms Kitchen All Day Menu', 1);

select @menu_id := menuid from menu where title = 'The Classics';
select @menu_id2 := menuid from menu where title = 'All Day Menu';

insert into menuitem values (@menu_id, @food_id1);
insert into menuitem values (@menu_id, @food_id2);
insert into menuitem values (@menu_id, @food_id3);

insert into menuitem values (@menu_id2, @food_id4);
insert into menuitem values (@menu_id2, @food_id5);
insert into menuitem values (@menu_id2, @food_id6);


