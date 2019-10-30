const { ApolloServer } = require('apollo-server');
const typeDefs = require('./schema');
const resolvers = require('./resolvers');
const { createDB } = require('./utils');

const GryphAPI = require('./datasources/gryphEats');
const database = createDB();

// const { PubSub } = require('apollo-server');
// const pubsub = new PubSub();

const dataSources = () => ({
    gryphAPI: new GryphAPI({ database }),
});

// context: ({req, connection}) => {
//     if (connection) {
//       return {
//         dataSources: {
//           LanguagesAPI: new LanguagesAPI(),
//        }
//     }
//     return {
//       // req context stuff
//     }
//   }
//called everytime something calls Graph
// const context = async ({ req }) => {
//     // simple auth check on every request
//     // console.log("\nReq\n" + req);
//     // console.log("\nConnection\n" + connection);
//     // return "IDK";
//     return {
//         dataSources: {
//             gryphAPI = new GryphAPI({ database }),
//         }
//     }
// }

// The ApolloServer constructor requires two parameters: 
// your schema = typeDefs
// definition and your set of resolvers.
const server = new ApolloServer({
    // context,
    context: ({ req, connection }) => {
        if (connection) {
            // console.log("\nReq\n" + req);
            // console.log("\nConnection\n" + connection);
            return {
                dataSources: {
                    gryphAPI: new GryphAPI({ database }),
                }
            }
        }
        return {
            req: req
        }
    },
    typeDefs,
    resolvers,
    dataSources,
});
const port = 4000;

// The `listen` method launches a web server.
server.listen({ port }).then(({ url, subscriptionsUrl }) => {
    console.log(`Server ready at ${url}`);
    console.log(`🚀 Subscriptions ready at ${subscriptionsUrl}`);
})//.catch(console.log("Already Running"));
