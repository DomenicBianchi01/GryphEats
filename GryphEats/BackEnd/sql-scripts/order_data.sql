/*
For use in conjuction with the alpha_data.sql file
*/

select @restaurant_id := restaurantid from restaurant where description = 'Best burgers in town';

insert into foodorder values (null, '2019-12-31 23:59:59', null, @restaurant_id, 0);
insert into foodorder values (null, '2019-12-31 23:59:59', null, @restaurant_id, 1);
insert into foodorder values (null, '2019-12-31 23:59:59', null, @restaurant_id, 2);
insert into foodorder values (null, '2019-12-31 23:59:59', null, @restaurant_id, 3);