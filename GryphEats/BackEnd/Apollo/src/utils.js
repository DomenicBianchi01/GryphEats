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
            autoIncrement: true
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
            autoIncrement: true
        },
        timeplaced: SQL.DATE,
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
            autoIncrement: true
        },
        restaurantid: SQL.INTEGER,
        title: SQL.STRING,
        description: SQL.STRING,
        isactive: SQL.INTEGER
    },
        {
            freezeTableName: true
        }
    );

    const menuitem = db.define('menuitem', {
        menuid: {
            type: SQL.INTEGER,
            primaryKey: true,
        },
        foodid: {
            type: SQL.INTEGER,
            primaryKey: true
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
        orderid: SQL.INTEGER,
        foodid: SQL.INTEGER
    },
        {
            freezeTableName: true
        }
    );

    const restaurant = db.define('restaurant', {
        restaurantid: {
            type: SQL.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        displayname: SQL.STRING,
        phonenumber: SQL.STRING,
        openingtime: SQL.TIME,
        closingtime: SQL.TIME,
        isactive: SQL.INTEGER,
        description: SQL.STRING
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

    return { food, foodorder, menu, menuitem, orderitem, restaurant, user };
}