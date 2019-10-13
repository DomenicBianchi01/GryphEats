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
            return -1;
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
            return -1;
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
            return -1;
        }
    }
}

module.exports = GryphAPIS;