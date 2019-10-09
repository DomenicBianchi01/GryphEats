create table menuitem (menuid int not null, foodid int not null, primary key (menuid, foodid), foreign key (menuid) references menu(menuid), foreign key (foodid) references food(foodid));
