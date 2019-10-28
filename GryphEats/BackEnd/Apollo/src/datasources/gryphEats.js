const { DataSource } = require('apollo-datasource');
//const { PubSub } = require('apollo-server');

//const pubsub = new PubSub();
const POST_ADDED = 'POST_ADDED';
const ORDER_PLACED = 'ORDER_PLACED';
class GryphAPIS extends DataSource {
    constructor({ database }) {
        super();
        this.database = database;
        // this.pubsub = pubsub;
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

    async getFoodByFoodID({ foodid }) {
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

    async updateFoodPriceByFoodID({ foodid, price }) {
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
    async createFood({ displayname, toppingtype, price, restaurantid, isavailable, description, foodgroup, pubsub }) {
        try {
            const result = await this.database.food.create({
                displayname, toppingtype, price, isavailable, restaurantid, description, foodgroup
            });
            //pubpubsub.publish(POST_ADDED, { postAdded: displayname });
            if (result) {
                await pubsub.publish(POST_ADDED, { foodAdded: result });
                return "Created";
            } else {
                // await pubsub.publish(POST_ADDED, { postAdded: "unable to create?" });
                return "failed to create";
            }
        } catch (e) {

        }
    }

    async deleteFoodByFoodID({ foodid }) {
        try {
            const result = await this.database.food.destroy({
                where: { foodid }
            });
            if (result) {
                return "foodid:" + foodid + " deleted";
            } else {
                return "foodid:" + foodid + " failed to deleted";
            }
        } catch (e) {
            return "Fail";
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
            const result = await this.database.restaurant.findAll({
                // include: [{
                //     model: this.database.menu,
                // }]
            });
            // console.log(result)
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

    async getOrderItemsByOrderID({ orderid }) {
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

    async getAllMenus() {
        try {
            const result = await this.database.menu.findAll();
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenus Failed: " + e.message;
        }
    }

    async getMenusByRestaurantID({ restaurantid }) {
        try {
            // console.log("help" + restaurantid);
            const result = await this.database.menu.findAll({
                where: { restaurantid },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenusFailed: " + e.message;
        }
    }

    async getMenuItemsByMenuID({ menuid }) {
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

    async getOrdersByRestaurantID({ restaurantid }) {
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

    /**
     * Place an order
     * An array of foodids will be passed
     * Assume userid is 1
     */
    async placeOrder({ foodids, restaurantid, pubsub }) {
        try {
            //create an order for restaurant
            const order = await this.createOrder({ restaurantid });
            if (order) {
                var orderid = order.dataValues.orderid;
                // console.log(orderid);
                for (var foodid in foodids) {
                    // console.log(foodids[foodid]);
                    var fid = foodids[foodid];
                    const result = await this.database.orderitem.create({
                        orderid: orderid, foodid: fid
                    });
                }
                var newOrders = await this.getOrdersByRestaurantID({ restaurantid });
                await pubsub.publish(ORDER_PLACED, { orderPlaced: newOrders });
                return {
                    success: true,
                    message: 'Order Completed',
                };
            }
            return {
                success: false,
                message: 'Order completing failed',
            };
        } catch (e) {
            return {
                success: false,
                message: "place order failed: " + e.message
            };
        }
    }

    /**
     * create an order for restaurant
     */

    async createOrder({ restaurantid }) {
        try {
            const result = await this.database.foodorder.create({
                restaurantid: restaurantid
            })
            return result;
        } catch (e) {
            return {
                success: false,
                message: "place order failed: " + e.message
            };
        }
    }
}

module.exports = GryphAPIS;
