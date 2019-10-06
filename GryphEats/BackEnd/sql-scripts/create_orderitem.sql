create table orderitem (orderid int, foodid int, quantity int, primary key (orderid, foodid), foreign key (orderid) references foodorder(orderid), foreign key (foodid) references food(foodid));
