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
        foods: [Food]!
        getFoodByFoodID(foodid: ID!): Food
        getFoodByDisplayName(displayname:String!):Food
        restaurants: [Restaurant]!
        users: [User]!
        menus: [Menu]!
        getMenusByRestaurantID(restaurantid: ID!): [Menu]!
        getMenuItemsByMenuID(menuid: ID!): [MenuItem]!
        getOrderItemsByOrderID(orderid: ID!): [OrderItem]!
        getOrdersByRestaurantID(restaurantid: ID!): [FoodOrder]!
        getOrdersByUserID(userid: ID!): [FoodOrder]!
        getStaticToppingsByFoodGroup(foodgroup: ID!): [StaticTopping]!
        validateUser(email:String!, pass:String!): Auth!
    }

    type Mutation {
        updateOrder(orderid:ID!, status:OrderStatus!, restaurantid:ID!): Finish
        createOrder(userid:ID!, restaurantid: ID!): FoodOrder
        placeOrder(userid:ID!, foodids:[ID]!, restaurantid:ID!): Finish
        completeOrder(orderid: ID): Finish
        updateFoodPriceByFoodID(foodid:ID!, price:ID!): String
        createFood(displayname:String, toppingtype:ID, price:ID, restaurantid:ID, isavailable:ID, description:String, foodgroup:ID): String
        createUser(fname:String, lname:String, phonenum:String, address:String, email:String, encryptedpw:String, usertype:ID): String
        deleteFoodByFoodID(foodid:ID): String
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
    }

    type FoodOrder {
        orderid: ID!
        timeplaced: Date!
        timecompleted: Date
        restaurantid: ID!
        ordertype: OrderStatus!
        userid: ID!
        orderitems: [OrderItem!]!
    }

    type Topping {
        toppingid: ID!
        identifier: ID!
    }

    type StaticTopping {
        toppingid: ID!
        foodgroup: ID!
        displayname: ID!
        price: ID
    }

    type Finish {
        success: Boolean!
        message: String
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
