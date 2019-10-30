insert into restaurant values (null, 'Burger Joint', '905123456', '11:00:00', '21:00:00', 'Best burgers in town', 1);
insert into restaurant values (null, 'Mom''s Kitchen', '519123456', '08:00:00', '20:00:00', 'Homecooked food', 1);

select @restaurant_id := restaurantid from restaurant where description = 'Best burgers in town';
select @restaurant_id2 := restaurantid from restaurant where description = 'Homecooked food';

insert into user values (null, 'Scott', 'Riva', '905123456', '10 Stone Rd', 'scott@mail.com' , 'ewr7wefh7', NULL, NULL, 0);
insert into user values (null, 'Domenic', 'Bianchi', '519654321', '3 Gordon St', 'dom@mail.com' , '217e177', NULL, NULL, 1);

insert into food values (null, 'Hamburger', 0, 8.49, @restaurant_id, 1, 'Plain Hamburger', 0);
insert into food values (null, 'Cheeseburger', 0, 8.99, @restaurant_id, 1, 'Burger with cheese', 0);
insert into food values (null, 'Bacon Cheeseburger', 0, 9.49, @restaurant_id, 1, 'Burger with bacon and cheese', 0);

insert into food values (null, 'Grilled Cheese', 0, 4.49, @restaurant_id2, 1, 'Grilled cheese sandwich', 0);
insert into food values (null, 'Pasta', 0, 6.99, @restaurant_id, 1, 'Penne with red sauce', 0);
insert into food values (null, 'Chicken Wrap', 0, 5.49, @restaurant_id, 1, 'Fried Chicken Wrap', 0);

select @food_id1 := foodid from food where displayname = 'Hamburger';
select @food_id2 := foodid from food where displayname = 'Cheeseburger';
select @food_id3 := foodid from food where displayname = 'Bacon Cheeseburger';

select @food_id4 := foodid from food where displayname = 'Grilled Cheese';
select @food_id5 := foodid from food where displayname = 'Pasta';
select @food_id6 := foodid from food where displayname = 'Chicken Wrap';

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

