const { gql } = require('apollo-server');
const typeDefs = gql`
    type Query {
        foods: [Food]!
        restaurants: [Restaurant]!
        users: [User]!
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
        displayname: String
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