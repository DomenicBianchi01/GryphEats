const { gql } = require('apollo-server');

const typeDefs = gql`

    scalar Date

    enum OrderStatus {
        neworder
        inprogress
        ready
        pickedup
        cancelled
    }

    enum UserType {
        customer
        restaurant
    }

    type Query {
        customTest(foodwrappers:[FoodWrapper!]): [Food]!
        foods: [Food]!
        getFoodByFoodID(foodid: ID!): Food
        getFoodByDisplayName(displayname:String!):Food
        restaurants: [Restaurant]!
        users: [User]!
        menus: [Menu]!
        getRestaurantByRestaurantID(restaurantid:ID!):Restaurant!
        getMenusByRestaurantID(restaurantid: ID!): [Menu]!
        getMenuItemsByMenuID(menuid: ID!): [MenuItem]!
        getOrderItemsByOrderID(orderid: ID!): [OrderItem]!
        getOrdersByRestaurantID(restaurantid: ID!): [FoodOrder]!
        getOrdersByUserID(userid: ID!): [FoodOrder]!
        getSecurityQuestionByEmail(email: String!): String
        getStaticToppingsByFoodGroup(foodgroup: ID!): [StaticTopping]!
        getStaticToppingByID(toppingid: ID!): StaticTopping
        getToppingsByIdentifier(identifier: ID!): [Topping!]
        validateUser(email:String!, pass:String!): Auth!
        validateSecurityQuestion(email:String!, securitya:String!): Boolean!
    }

    type Mutation {
        updateOrder(orderid:ID!, status:OrderStatus!, restaurantid:ID!): Finish
        createOrder(userid:ID!, restaurantid: ID!): FoodOrder
        createOrderItem(orderid: ID!, foodid: ID!): OrderItem
        placeOrder(userid:ID!, foodwrappers:[FoodWrapper]!, restaurantid:ID!, instructions: String): Finish
        createTopping(toppingid:ID!, identifier: ID!): String
        completeOrder(orderid: ID): Finish
        updateFoodPriceByFoodID(foodid:ID!, price:ID!): String
        updateFoodAvailabilityByFoodID(foodid:ID!, isavailable:ID!): String
        updatePasswordByEmail(email:String!, encryptedpw:String!): Boolean
        updateisActiveByRestID(restaurantid:ID!, isactive:Boolean!):String
        createFood(displayname:String, toppingtype:ID, price:ID, restaurantid:ID, isavailable:ID, description:String, foodgroup:ID): String
        createUser(fname:String!, lname:String!, phonenum:String, address:String, email:String!, encryptedpw:String!, usertype:UserType!, securityq: String!, securitya: String!): Finish
        deleteFoodByFoodID(foodid:ID): String
        registerNotify(userid:ID!, uuid:String!, token: String!): Boolean
        deleteNotifByUUID(userid:ID!, uuid:String!): String
        # createUser(fname:String, lname:String, phonenum:String, address:String, email:String!, pass:String!, usertype:Int!): Finish
    }

    type Subscription {
        foodAdded: Food
        # orderPlaced(restaurantid:ID!): [FoodOrder]
        orderUpdated(restaurantid:ID!): [FoodOrder]
    }

    type Food {
        foodid: ID!
        displayname: String!
        toppingtype: ID!
        price: Float!
        restaurantid: ID!
        isavailable: Boolean!
        description: String
        foodgroup: ID!
        toppings: [StaticTopping!]
    }

    type Restaurant {
        restaurantid: ID!
        displayname: String!
        phonenumber: String
        openingtime: String
        closingtime: String
        isactive: Boolean!
        description: String
        menu: [Menu]!
    }

    type Auth {
        isValid:Boolean
        account:User
        token:String
    }

    type User {
        userid: ID!
        fname: String
        lname: String
        phonenum: String
        address: String
        email: String
        usertype: UserType!
        securityq: String
        securitya: String
        foodorders: [FoodOrder]!
    }

    type Menu {
        menuid: ID!
        restaurantid: ID!
        title: String!
        description: String
        isactive: Boolean!
        restaurant: Restaurant!
        menuItems:[MenuItem]!
    }

    type MenuItem {
        menuid: ID!
        foodid: ID!
        item: Food!
    }

    type OrderItem {
        orderid: ID!
        foodid: ID!
        identifier: ID!
        foodorder: FoodOrder!
        item: Food!
        toppings: [Topping!]
    }

    type FoodOrder {
        orderid: ID!
        timeplaced: Date!
        timecompleted: Date
        restaurantid: ID!
        ordertype: OrderStatus!
        userid: ID!
        instructions: String
        orderitems: [OrderItem!]!
    }

    type Topping {
        toppingid: ID!
        identifier: ID!
        statictopping: StaticTopping
    }

    type StaticTopping {
        toppingid: ID!
        foodgroup: ID!
        displayname: String!
        price: ID
    }

    type Notif {
        userid: ID!
        uuid: String!
        token: String!
    }

    type Finish {
        success: Boolean!
        message: String
    }

    input FoodWrapper {
        foodid: ID!
        toppingids: [ID!]
    }
`;

module.exports = typeDefs;

// const typeDefs = gql`
//   # Comments in GraphQL strings (such as this one) start with the hash (#) symbol.

//   # This "Book" type defines the queryable fields for every book in our data source.
//   type Book {
//     title: String
//     author: String
//   }

//   # The "Query" type is special: it lists all of the available queries that
//   # clients can execute, along with the return type for each. In this
//   # case, the "books" query returns an array of zero or more Books (defined above).
//   type Query {
//     books: [Book]}`
//     ;

// A schema is a collection of type definitions (hence "typeDefs")
// that together define the "shape" of queries that are executed against
// your data.

// const books = [
//     {
//         title: 'Harry Potter and the Chamber of Secrets',
//         author: 'J.K. Rowling',
//     },
//     {
//         title: 'Jurassic Pak',
//         author: 'Michael Crichton',
//     },
// ];
