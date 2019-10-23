const { DataSource } = require('apollo-datasource');
//const { PubSub } = require('apollo-server');

//const pubsub = new PubSub();

class GryphAPIS extends DataSource {
    constructor({ database }) {
        super();
        this.database = database;
    }

    /**
     * Called when ApolloServer is being setup
     * gets called with datasource, includes info about requestor
     */
    initialize(config) {
        this.config = config.context;
    }

    /**
     * Functions
     */
    async getAllFood() {
        try {
            // console.log(this.config);
            // const fid = this.context.food.foodid;
            const result = await this.database.food.findAll();
            // console.log(result);
            return result;
        } catch (e) {
            console.log(e.message);
            return "getAllFood Failed: " + e.message;
        }
    }

    async getFoodByID({ foodid }) {
        try {
            const result = await this.database.food.findAll({
                where: { foodid },
            });
            return result;
        } catch (e) {

        }
    }

    async getFoodByDisplayName({ displayname }) {
        try {
            const result = await this.database.food.findAll({
                where: { displayname },
            });
            return result;
        } catch (e) {

        }
    }

    async updateFoodPriceByID({ foodid, price }) {
        try {
            const result = await this.database.food.update({ price }, {
                where: { foodid }
            });
            console.log(result);
            if (result) {
                return "true";
            } else {
                return "false";
            }
        } catch (e) {

        }
    }
    // foodid: ID!
    // displayname: String
    // toppingtype: ID
    // price: ID
    // restaurantid: ID
    // isavailable: ID
    // description: String
    // foodgroup: ID
    async createFood({ displayname, toppingtype, price, restaurantid, isavailable, description, foodgroup }) {
        try {
            const result = await this.database.food.create({
                displayname, toppingtype, price, isavailable, restaurantid, description, foodgroup
            });
            //pubpubsub.publish(POST_ADDED, { postAdded: displayname });
            if (result) {
                return "Created";
            } else {
                return "failed to create";
            }
        } catch (e) {

        }
    }

    // Post.update({
    //     updatedAt: null,
    //   }, {
    //     where: {
    //       deletedAt: {
    //         [Op.ne]: null
    //       }
    //     }
    //   });

    // User.create({ username: 'fnord', job: 'omnomnom' })

    // get all restaurant names
    async getAllRestaurants() {
        try {
            // console.log(this.config);
            // const fid = this.context.food.foodid;
            const result = await this.database.restaurant.findAll();
            // console.log(result);
            return result;
        } catch (e) {
            console.log(e.message);
            return "getAllRestaurants Failed: " + e.message;
        }
    }

    async getAllUsers() {
        try {
            // console.log(this.config);
            // const fid = this.context.food.foodid;
            const result = await this.database.user.findAll();
            // console.log(result);
            return result;
        } catch (e) {
            console.log(e.message);
            return "getAllUsers Failed: " + e.message;
        }
    }


    async getOrders() {
        try {
            const result = await this.database.foodorder.findAll();
            return result;
        } catch (e) {
            console.log(e.message);
            return "getOrders Failed: " + e.message;
        }

    }

    async getOrderItemsByID({ orderid }) {
        try {
            const result = await this.database.orderitem.findAll({
                where: { orderid },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getOrderItemsFailed: " + e.message;

        }

    }

    async getMenusByID({ restaurantid }) {
        try {
            const result = await this.database.menu.findAll({
                where: { restaurantid },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenusFailed: " + e.message;
        }
    }

    async getMenuItemsByID({ menuid }) {
        try {
            const result = await this.database.menuitem.findAll({
                where: { menuid },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenuItemsFailed: " + e.message;
        }
    }

    async getOrdersByRestaurant({ restaurantid }) {
        try {
            const result = await this.database.foodorder.findAll({
                where: { restaurantid },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenuItemsFailed: " + e.message;
        }
    }

    /**
     * complete order restaurant calls
     * Calls markorderdone and send notification
     */
    async completeOrder({ orderid }) {
        try {
            console.log(orderid);
            // return "orderid:" + orderid;
            return {
                success: true,
                message: 'Order Completed',
            };
        } catch (e) {
            console.log(e.message);
            return {
                success: false,
                message: "completeOrder Failed: " + e.message,
            };
        }
    }

    /*
    * marks an order with the current time
    */
    async markOrderDone() {
        try {

        } catch (e) {
            console.log(e.message);
            return "markOrderDone Failed: " + e.message;
        }
    }

}

module.exports = GryphAPIS;
