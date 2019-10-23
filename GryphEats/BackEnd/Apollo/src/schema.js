const { gql } = require('apollo-server');
const typeDefs = gql`
    type Query {
        foods: [Food]!
        food(foodid: ID!): [Food]
        foodName(displayname:String!):[Food]
        restaurants: [Restaurant]!
        users: [User]!
        menus(restaurantid: ID!): [Menu]
        menuitems(menuid: ID!): [MenuItem]!
        orderitems(orderid: ID!): [OrderItem]
        ordersbyrest(restaurantid: ID!): [FoodOrder]!
    }

    type Mutation {
        completeOrder(orderid: ID): Finish
        updateFoodPriceByID(foodid:ID!, price:ID!): String
        createFood(displayname:String, toppingtype:ID, price:ID, restaurantid:ID, isavailable:ID, description:String, foodgroup:ID): String
    }

    type Subscription {
        foodAdded: Food
    }

    type Food {
        foodid: ID!
        displayname: String
        toppingtype: ID
        price: ID
        restaurantid: ID
        isavailable: ID
        description: String
        foodgroup: ID
    }

    type Restaurant {
        restaurantid: ID!
        displayname: String!
        phonenumber: String
        openingtime: String
        closingtime: String
        isactive: ID
        description: String
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
        isactive: ID
    }

    type MenuItem {
        menuid: ID!
        foodid: ID!
    }

    type OrderItem {
        orderid: ID!
        foodid: ID!
        identifier: ID!
    }

    type FoodOrder {
        orderid: ID!
        timeplaced: String
        timecompleted: String
        restaurantid: ID!
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
