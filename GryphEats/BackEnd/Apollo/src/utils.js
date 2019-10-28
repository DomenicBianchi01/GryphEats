const SQL = require('sequelize');

module.exports.createDB = () => {
    const db = new SQL('test', 'root', 'ResinMotion', {
        host: "131.104.48.253",
        dialect: 'mysql',
        logging: false,
        define: {
            timestamps: false
        }
    });
    db.authenticate().then(() => {
        console.log('Connection has been established successfully.');
    }).catch(err => {
        console.error('Unable to connect to the database:', err);
    });

    const food = db.define('food', {
        foodid: {
            type: SQL.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            references: {
                model: 'menuitem', // name of Target model
                key: 'foodid', // key in Target model that we're referencing
            },
        },
        displayname: SQL.STRING,
        toppingtype: SQL.INTEGER,
        price: SQL.DECIMAL,
        restaurantid: SQL.INTEGER,
        isavailable: SQL.INTEGER,
        description: SQL.STRING,
        foodgroup: SQL.INTEGER
    },
        {
            freezeTableName: true
        }
    );

    const foodorder = db.define('foodorder', {
        orderid: {
            type: SQL.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            references: {
                model: 'orderitem', // name of Target model
                key: 'orderid', // key in Target model that we're referencing
            },
        },
        timeplaced: {
            type: SQL.DATE,
            defaultValue: SQL.NOW
        },
        timecompleted: SQL.DATE,
        restaurantid: SQL.INTEGER
    },
        {
            freezeTableName: true
        }
    );

    const menu = db.define('menu', {
        menuid: {
            type: SQL.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            references: {
                model: 'menuitem', // name of Target model
                key: 'menuid', // key in Target model that we're referencing
            },
        },
        restaurantid: {
            type: SQL.INTEGER,
            references: {
                model: 'restaurant', // name of Target model
                key: 'restaurantid', // key in Target model that we're referencing
            },
            //references: 'restaurant',
            //referencesKey: 'restaurantid'
        },
        title: SQL.STRING,
        description: SQL.STRING,
        isactive: SQL.INTEGER
    },
        {
            freezeTableName: true
        }
    );

    const restaurant = db.define('restaurant', {
        restaurantid: {
            type: SQL.INTEGER,
            primaryKey: true,
            autoIncrement: true,
            references: {
                model: 'menu', // name of Target model
                key: 'restaurantid', // key in Target model that we're referencing
            },
            // references: 'menu',
            // referencesKey: 'restaurantid'
        },
        displayname: SQL.STRING,
        phonenumber: SQL.STRING,
        openingtime: SQL.TIME,
        closingtime: SQL.TIME,
        isactive: SQL.INTEGER,
        description: SQL.STRING,
    },
        {
            freezeTableName: true
        }
    );

    const menuitem = db.define('menuitem', {
        menuid: {
            type: SQL.INTEGER,
            primaryKey: true,
            references: {
                model: 'menu', // name of Target model
                key: 'menuid', // key in Target model that we're referencing
            },
        },
        foodid: {
            type: SQL.INTEGER,
            primaryKey: true,
            references: {
                model: 'food', // name of Target model
                key: 'foodid', // key in Target model that we're referencing
            },
        }
    },
        {
            freezeTableName: true
        }
    );

    const orderitem = db.define('orderitem', {
        identifier: {
            type: SQL.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        orderid: {
            type: SQL.INTEGER,
            references: {
                model: 'foodorder', // name of Target model
                key: 'orderid', // key in Target model that we're referencing
            },
        },
        foodid: SQL.INTEGER,
    },
        {
            freezeTableName: true
        }
    );

    const user = db.define('user', {
        userid: {
            type: SQL.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        fname: SQL.STRING,
        lname: SQL.STRING,
        phonenum: SQL.STRING,
        address: SQL.STRING,
        email: SQL.STRING,
        currentorderid: SQL.INTEGER,
        lastorderid: SQL.INTEGER,
        usertype: SQL.INTEGER
    },
        {
            freezeTableName: true
        }
    );

    restaurant.hasMany(menu, { foreignKey: 'restaurantid', sourceKey: 'restaurantid' });
    menu.belongsTo(restaurant, { foreignKey: 'restaurantid', sourceKey: 'restaurantid' });

    menu.hasMany(menuitem, { foreignKey: 'menuid', sourceKey: 'menuid' });
    menuitem.belongsTo(menu, { foreignKey: 'menuid', sourceKey: 'menuid' });

    menuitem.hasOne(food, { foreignKey: 'foodid', sourceKey: 'foodid' });
    food.belongsTo(menuitem, { foreignKey: 'foodid', sourceKey: 'foodid' });

    foodorder.hasMany(orderitem, { foreignKey: 'orderid', sourceKey: 'orderid' });
    orderitem.belongsTo(foodorder, { foreignKey: 'orderid', sourceKey: 'orderid' });

    return { food, foodorder, menu, menuitem, orderitem, restaurant, user };
}