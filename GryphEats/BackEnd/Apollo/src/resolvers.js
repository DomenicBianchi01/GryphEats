
//export default {
const { withFilter } = require('apollo-server');

// const pubsub = new PubSub();
const ps = require('./pubsub');
const pubsub = ps.pubsub;
const POST_ADDED = 'POST_ADDED';
const ORDER_UPDATED = 'ORDER_UPDATED';

module.exports = {
    OrderStatus: {
        neworder: 0,
        inprogress: 1,
        ready: 2,
        pickedup: 3,
        cancelled: 4,
    },
    UserType: {
        customer: 0,
        restaurant: 1,
    },
    PaymentType: {
        credit: 0,
        oncampus: 1,
        offcampus: 2,
    },
    Query: {
        // foods: (parent, args, { dataSources }, info) => datasources.food.findAll(),
        customTest: async (_, { foodwrappers }, { dataSources }, info) => dataSources.gryphAPI.customTest({ foodwrappers }),
        foods: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllFood(),
        getFoodByFoodID: (_, { foodid }, { dataSources }, info) => dataSources.gryphAPI.getFoodByFoodID({ foodid }),
        getFoodByDisplayName: (_, { displayname }, { dataSources }, info) => dataSources.gryphAPI.getFoodByDisplayName({ displayname }),
        restaurants: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllRestaurants(),
        users: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllUsers(),
        menus: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllMenus(),
        getStaticToppingsByFoodGroup: async (_, { foodgroup }, { dataSources }, info) => dataSources.gryphAPI.getStaticToppingsByFoodGroup({ foodgroup }),
        getStaticToppingByID: async (_, { toppingid }, { dataSources }, info) => dataSources.gryphAPI.getStaticToppingByID({ toppingid }),
        getSecurityQuestionByEmail: async (_, { email }, { dataSources }, info) => dataSources.gryphAPI.getSecurityQuestionByEmail({ email }),
        getMenusByRestaurantID: async (_, { restaurantid }, { dataSources }, info) => dataSources.gryphAPI.getMenusByRestaurantID({ restaurantid }),
        getRestaurantByRestaurantID: async (_, { restaurantid }, { dataSources }, info) => dataSources.gryphAPI.getRestaurantByRestaurantID({ restaurantid }),
        getMenuItemsByMenuID: async (_, { menuid }, { dataSources }, info) => dataSources.gryphAPI.getMenuItemsByMenuID({ menuid }),
        getOrderItemsByOrderID: async (_, { orderid }, { dataSources }, info) => dataSources.gryphAPI.getOrderItemsByOrderID({ orderid }),
        getOrdersByRestaurantID: async (_, { restaurantid }, { dataSources }, info) => dataSources.gryphAPI.getOrdersByRestaurantID({ restaurantid }),
        getOrdersByUserID: async (_, { userid }, { dataSources }, info) => dataSources.gryphAPI.getOrdersByUserID({ userid }),
        getToppingsByIdentifier: async (_, { identifier }, { dataSources }, info) => dataSources.gryphAPI.getToppingsByIdentifier({ identifier }),
        validateUser: async (_, { email, pass }, { dataSources }, info) => dataSources.gryphAPI.validateUser({ email, pass }),
        validateSecurityQuestion: async (_, { email, securitya }, { dataSources }, info) => dataSources.gryphAPI.validateSecurityQuestion({ email, securitya })
    },
    Mutation: {
        updateOrder: async (_, { orderid, status, restaurantid }, { dataSources }) => dataSources.gryphAPI.updateOrder({ orderid, status, restaurantid }),
        createOrder: async (_, { userid, restaurantid }, { dataSources }) => dataSources.gryphAPI.createOrder({ userid, restaurantid }),
        createOrderItem: async (_, { orderid, foodid }, { dataSources }) => dataSources.gryphAPI.createOrderItem({ orderid, foodid }),
        placeOrder: async (_, { userid, foodwrappers, restaurantid, instructions, paymenttype }, { dataSources }) => dataSources.gryphAPI.placeOrder({ userid, foodwrappers, restaurantid, instructions, paymenttype }),
        createTopping: async (_, { toppingid, identifier }, { dataSources }) => dataSources.gryphAPI.createTopping({ toppingid, identifier }),
        completeOrder: async (_, { orderid }, { dataSources }) => dataSources.gryphAPI.completeOrder({ orderid }),
        updateFoodPriceByFoodID: async (_, { foodid, price }, { dataSources }) => dataSources.gryphAPI.updateFoodPriceByFoodID({ foodid, price }),
        updateFoodAvailabilityByFoodID: async (_, { foodid, isavailable }, { dataSources }) => dataSources.gryphAPI.updateFoodAvailabilityByFoodID({ foodid, isavailable }),
        updatePasswordByEmail: async (_, { email, encryptedpw }, { dataSources }) => dataSources.gryphAPI.updatePasswordByEmail({ email, encryptedpw }),
        updateisActiveByRestID: async (_, { restaurantid, isactive }, { dataSources }) => dataSources.gryphAPI.updateisActiveByRestID({ restaurantid, isactive }),
        createFood: async (_, { displayname, toppingtype, price, restaurantid, isavailable, description, foodgroup }, { dataSources }) =>
            dataSources.gryphAPI.createFood({ displayname, toppingtype, price, restaurantid, isavailable, description, foodgroup }),
        createUser: async (_, { fname, lname, phonenum, address, email, encryptedpw, usertype, securityq, securitya }, { dataSources }) =>
            dataSources.gryphAPI.createUser({ fname, lname, phonenum, address, email, encryptedpw, usertype, securityq, securitya }),
        deleteFoodByFoodID: async (_, { foodid }, { dataSources }) => dataSources.gryphAPI.deleteFoodByFoodID({ foodid }),
        registerNotify: async (_, { userid, uuid, token }, { dataSources }) => dataSources.gryphAPI.registerNotify({ userid, uuid, token }),
        deleteNotifByUUID: async (_, { userid, uuid }, { dataSources }) => dataSources.gryphAPI.deleteNotifByUUID({ userid, uuid })
    },
    Subscription: {
        //     // Additional event labels can be passed to asyncIterator creation
        foodAdded: {
            subscribe: () => pubsub.asyncIterator([POST_ADDED])
        },
        // orderPlaced: {
        //     subscribe: withFilter(() => pubsub.asyncIterator([ORDER_PLACED]), (payload, { restaurantid }) => {
        //         return payload.orderPlaced === restaurantid;
        //     }),
        //     // subscribe: () => pubsub.asyncIterator([ORDER_PLACED]),
        //     resolve: (payload, { restaurantid }, { dataSources }, info) => {
        //         return dataSources.gryphAPI.getOrdersByRestaurantID({ restaurantid })
        //     }
        // },
        orderUpdated: {
            subscribe: withFilter(() => pubsub.asyncIterator([ORDER_UPDATED]), (payload, { restaurantid }) => {
                // console.log({ payload });
                return payload.orderUpdated === restaurantid;
            }),
            resolve: (payload, { restaurantid }, { dataSources }, info) => {
                return dataSources.gryphAPI.getOrdersByRestaurantID({ restaurantid })
            }
        }
        // export const resolvers = {
        //     Subscription: {
        //       somethingChanged: {
        //         subscribe: withFilter(() => pubsub.asyncIterator(SOMETHING_CHANGED_TOPIC), (payload, variables) => {
        //           return payload.somethingChanged.id === variables.relevantId;
        //         }),
        //       },
        //     },
        //   }
    },
    Restaurant: {
        menu: async (restaurant, _, { dataSources }) => dataSources.gryphAPI.getMenusByRestaurantID({ restaurantid: restaurant.restaurantid })
    },
    Menu: {
        restaurant: async (menu, _, { dataSources }) => dataSources.gryphAPI.getRestaurantByRestaurantID({ restaurantid: menu.restaurantid }),
        menuItems: async (menu, _, { dataSources }) => dataSources.gryphAPI.getMenuItemsByMenuID({ menuid: menu.menuid })
    },
    MenuItem: {
        item: async (menuItem, _, { dataSources }) => dataSources.gryphAPI.getFoodByFoodID({ foodid: menuItem.foodid })
    },
    FoodOrder: {
        orderitems: async (FoodOrder, _, { dataSources }) => dataSources.gryphAPI.getOrderItemsByOrderID({ orderid: FoodOrder.orderid })
    },
    OrderItem: {
        item: async (OrderItem, _, { dataSources }) => dataSources.gryphAPI.getFoodByFoodID({ foodid: OrderItem.foodid }),
        toppings: async (OrderItem, _, { dataSources }) => dataSources.gryphAPI.getToppingsByIdentifier({ identifier: OrderItem.identifier })
    },
    Topping: {
        statictopping: async (Topping, _, { dataSources }) => dataSources.gryphAPI.getStaticToppingByID({ toppingid: Topping.toppingid })
    },
    Food: {
        toppings: async (Food, _, { dataSources }) => dataSources.gryphAPI.getStaticToppingsByFoodGroup({ foodgroup: Food.foodgroup })
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
