insert into restaurant values (null, 'Burger Joint', '905123456', '09:00:00', '21:00:00', 'Best burgers in town', 1);


select @restaurant_id := restaurantid from restaurant where description = 'Best burgers in town';

insert into user values (null, 'Scott', 'Riva', '905123456', '10 Stone Rd', 'scott@mail.com' , 'ewr7wefh7', NULL, NULL, 0);
insert into user values (null, 'Domenic', 'Bianchi', '519654321', '3 Gordon St', 'dom@mail.com' , '217e177', NULL, NULL, 1);
insert into food values (null, 'Hamburger', 0, 8.49, @restaurant_id, 1, 'Plain Hamburger', 0);
insert into food values (null, 'Cheeseburger', 0, 8.99, @restaurant_id, 1, 'Burger with cheese', 0);
insert into food values (null, 'Bacon Cheeseburger', 0, 9.49, @restaurant_id, 1, 'Burger with bacon and cheese', 0);

select @food_id1 := foodid from food where displayname = 'Hamburger';
select @food_id2 := foodid from food where displayname = 'Cheeseburger';
select @food_id3 := foodid from food where displayname = 'Bacon Cheeseburger';

insert into menu values (null, @restaurant_id, 'The Classics ', 'Best burgers in town', 1);


select @menu_id := menuid from menu where title = 'The Classics';

insert into menuitem values (@menu_id, @food_id1);
insert into menuitem values (@menu_id, @food_id2);
insert into menuitem values (@menu_id, @food_id3);

