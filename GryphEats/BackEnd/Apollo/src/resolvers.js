//export default {
const { PubSub } = require('apollo-server');

const pubsub = new PubSub();
const POST_ADDED = 'POST_ADDED';
const ORDER_PLACED = 'ORDER_PLACED';
module.exports = {
    Query: {
        // foods: (parent, args, { dataSources }, info) => datasources.food.findAll(),
        foods: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllFood(),
        getFoodByFoodID: (_, { foodid }, { dataSources }, info) => dataSources.gryphAPI.getFoodByFoodID({ foodid }),
        getFoodByDisplayName: (_, { displayname }, { dataSources }, info) => dataSources.gryphAPI.getFoodByDisplayName({ displayname }),
        restaurants: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllRestaurants(),
        users: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllUsers(),
        menus: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllMenus(),
        getMenusByRestaurantID: async (_, { restaurantid }, { dataSources }, info) => dataSources.gryphAPI.getMenusByRestaurantID({ restaurantid }),
        getMenuItemsByMenuID: async (_, { menuid }, { dataSources }, info) => dataSources.gryphAPI.getMenuItemsByMenuID({ menuid }),
        getOrderItemsByOrderID: async (_, { orderid }, { dataSources }, info) => dataSources.gryphAPI.getOrderItemsByOrderID({ orderid }),
        getOrdersByRestaurantID: async (_, { restaurantid }, { dataSources }, info) => dataSources.gryphAPI.getOrdersByRestaurantID({ restaurantid })
    },
    Mutation: {
        createOrder: async (_, { restaurantid }, { dataSources }) => dataSources.gryphAPI.createOrder({ restaurantid }),
        placeOrder: async (_, { foodids, restaurantid }, { dataSources }) => dataSources.gryphAPI.placeOrder({ foodids, restaurantid, pubsub }),
        completeOrder: async (_, { orderid }, { dataSources }) => dataSources.gryphAPI.completeOrder({ orderid }),
        updateFoodPriceByFoodID: async (_, { foodid, price }, { dataSources }) => dataSources.gryphAPI.updateFoodPriceByFoodID({ foodid, price }),
        createFood: async (_, { displayname, toppingtype, price, restaurantid, isavailable, description, foodgroup }, { dataSources }) =>
            dataSources.gryphAPI.createFood({ displayname, toppingtype, price, restaurantid, isavailable, description, foodgroup, pubsub }),
        deleteFoodByFoodID: async (_, { foodid }, { dataSources }) => dataSources.gryphAPI.deleteFoodByFoodID({ foodid })

    },
    Subscription: {
        // foodAdded: async (_, _, { dataSources }) => dataSources.gryphAPI.foodAdded
        //     // Additional event labels can be passed to asyncIterator creation
        foodAdded: {
            subscribe: () => pubsub.asyncIterator([POST_ADDED])
        },
        orderPlaced: {
            subscribe: () => pubsub.asyncIterator([ORDER_PLACED])
        }
        // {
        //     subscribe: () => dataSources.gryphAPI.pubsub.asyncIterator([POST_ADDED]),
        // },
    },
    Restaurant: {
        menu: async (restaurant, _, { dataSources }) => dataSources.gryphAPI.getMenusByRestaurantID({ restaurantid: restaurant.restaurantid })
    },
    Menu: {
        menuItems: async (menu, _, { dataSources }) => dataSources.gryphAPI.getMenuItemsByMenuID({ menuid: menu.menuid })
    },
    MenuItem: {
        item: async (menuItem, _, { dataSources }) => dataSources.gryphAPI.getFoodByFoodID({ foodid: menuItem.foodid })
    }
};

// Subscription: {
//     info: {
//       subscribe: () => pubsub.asyncIterator([TOPIC]),
//     },
//   },
// parent: An object that contains the result returned from the resolver on the parent type
    //usually blank and refers to top of graph
// args: An object that contains the arguments passed to the field
// context: An object shared by all resolvers in a GraphQL operation. 
    // We use the context to contain per-request state such as authentication information and access our data sources.
// info: Information about the execution state of the operation which should only be used in advanced cases
