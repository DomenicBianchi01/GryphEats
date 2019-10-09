create table topping (toppingid int not null default 0, identifier int not null, primary key (toppingid, identifier), foreign key (identifier) references orderitem(identifier));
