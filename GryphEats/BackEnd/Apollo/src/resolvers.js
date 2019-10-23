//export default {
//const { PubSub } = require('apollo-server');

//const pubsub = new PubSub();
const POST_ADDED = 'POST_ADDED';
module.exports = {
    Query: {
        // foods: (parent, args, { dataSources }, info) => datasources.food.findAll(),
        foods: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllFood(),
        food: (_, { foodid }, { dataSources }, info) => dataSources.gryphAPI.getFoodByID({ foodid }),
        foodName: (_, { displayname }, { dataSources }, info) => dataSources.gryphAPI.getFoodByDisplayName({ displayname }),
        restaurants: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllRestaurants(),
        users: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllUsers(),
        menus: async (_, { restaurantid }, { dataSources }, info) => dataSources.gryphAPI.getMenusByID({ restaurantid }),
        menuitems: async (_, { menuid }, { dataSources }, info) => dataSources.gryphAPI.getMenuItemsByID({ menuid }),
        orderitems: async (_, { orderid }, { dataSources }, info) => dataSources.gryphAPI.getOrderItemsByID({ orderid }),
        ordersbyrest: async (_, { restaurantid }, { dataSources }, info) => dataSources.gryphAPI.getOrdersByRestaurant({ restaurantid })
    },
    Mutation: {
        completeOrder: async (_, { orderid }, { dataSources }) => dataSources.gryphAPI.completeOrder({ orderid }),
        updateFoodPriceByID: async (_, { foodid, price }, { dataSources }) => dataSources.gryphAPI.updateFoodPriceByID({ foodid, price }),
        createFood: async (_, { displayname, toppingtype, price, restaurantid, isavailable, description, foodgroup }, { dataSources }) =>
            dataSources.gryphAPI.createFood({ displayname, toppingtype, price, restaurantid, isavailable, description, foodgroup })
    },
    /*Subscription: {
        foodAdded: {
            // Additional event labels can be passed to asyncIterator creation
            subscribe: () => pubsub.asyncIterator([POST_ADDED]),
        },
    },*/
};

// parent: An object that contains the result returned from the resolver on the parent type
    //usually blank and refers to top of graph
// args: An object that contains the arguments passed to the field
// context: An object shared by all resolvers in a GraphQL operation. 
    // We use the context to contain per-request state such as authentication information and access our data sources.
// info: Information about the execution state of the operation which should only be used in advanced cases
