const { gql } = require('apollo-server');
const typeDefs = gql`

    scalar Date

    enum OrderStatus {
        neworder
        inprogress
        ready
        pickedup
    }

    type Query {
        foods: [Food]!
        getFoodByFoodID(foodid: ID!): Food
        getFoodByDisplayName(displayname:String!):Food
        restaurants: [Restaurant]!
        users: [User]!
        menus: [Menu]!
        getMenusByRestaurantID(restaurantid: ID!): [Menu]
        getMenuItemsByMenuID(menuid: ID!): [MenuItem]!
        getOrderItemsByOrderID(orderid: ID!): [OrderItem]
        getOrdersByRestaurantID(restaurantid: ID!): [FoodOrder]!
    }

    type Mutation {
        updateOrder(orderid:ID!, status:Int, restaurantid:ID!): Finish
        createOrder(restaurantid: ID!): FoodOrder
        placeOrder(foodids:[ID]!, restaurantid:ID!): Finish
        completeOrder(orderid: ID): Finish
        updateFoodPriceByFoodID(foodid:ID!, price:ID!): String
        createFood(displayname:String, toppingtype:ID, price:ID, restaurantid:ID, isavailable:ID, description:String, foodgroup:ID): String
        deleteFoodByFoodID(foodid:ID): String
    }

    type Subscription {
        foodAdded: Food
        # orderPlaced(restaurantid:ID!): [FoodOrder]
        orderUpdated(restaurantid:ID!): [FoodOrder]
    }

    type Food {
        foodid: ID!
        displayname: String
        toppingtype: ID
        price: Float
        restaurantid: ID
        isavailable: Boolean
        description: String
        foodgroup: ID
    }

    type Restaurant {
        restaurantid: ID!
        displayname: String!
        phonenumber: String
        openingtime: String
        closingtime: String
        isactive: Boolean
        description: String
        menu: [Menu]
    }

    type User {
        userid: ID!
        fname: String
        lname: String
        phonenum: String
        address: String
        email: String
        currentorderid: ID
        lastorderid: ID
    }

    type Menu {
        menuid: ID!
        restaurantid: ID!
        title: String
        description: String
        isactive: Boolean
        restaurant: Restaurant
        menuItems:[MenuItem]
    }

    type MenuItem {
        menuid: ID!
        foodid: ID!
        item: Food
    }

    type OrderItem {
        orderid: ID!
        foodid: ID!
        identifier: ID!
        foodorder: FoodOrder
        food: Food
    }

    type FoodOrder {
        orderid: ID!
        timeplaced: Date
        timecompleted: String
        restaurantid: ID!
        ordertype: Int
        orderitems: [OrderItem]
    }

    type Topping {
        toppingid: ID!
        identifier: ID!
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
