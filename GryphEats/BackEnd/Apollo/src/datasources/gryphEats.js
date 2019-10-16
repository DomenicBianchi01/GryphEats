const { DataSource } = require('apollo-datasource');

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

    /**
     * complete order restaurent calls
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