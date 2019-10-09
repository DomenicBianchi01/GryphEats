create table user (userid int not null primary key auto_increment, fname varchar(255) not null default '', lname varchar(255) not null default '', phonenum varchar(10) not null default '', address varchar(255) not null default '', email varchar(255) not null default 'INV_EMAIL', encryptedpw varchar(255) not null default 'INV_PW', currentorderid int, lastorderid int, foreign key (lastorderid) references foodorder(orderid), foreign key (currentorderid) references foodorder(orderid));
