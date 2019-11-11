const { ApolloServer } = require('apollo-server');
const typeDefs = require('./schema');
const resolvers = require('./resolvers');
const { createDB } = require('./utils');

const GryphAPI = require('./datasources/gryphEats');
const database = createDB();

const dataSources = () => ({
    gryphAPI: new GryphAPI({ database }),
});

// The ApolloServer constructor requires two parameters: 
// your schema = typeDefs
// definition and your set of resolvers.
const server = new ApolloServer({
    // context,
    context: async ({ connection, payload }) => {
        if (connection) {
            // console.log("\nConnection\n");
            // console.log(connection);
            // console.log("\npayload\n");
            // console.log(payload);
            // console.log(payload.query);
            // var query = JSON.stringify(payload.query);
            // var subscription = false;
            // console.log(query);
            // if (JSON.stringify(payload.query).includes('orderUpdated')) {
            //     console.log("orderUpdated");
            //     subscription = "orderUpdated"
            // }
            return {
                dataSources: {
                    gryphAPI: new GryphAPI({ database }),
                }
            }
        }
        return {
            paylaod: payload
        }
    },
    typeDefs,
    resolvers,
    dataSources,
});
const port = 4040;

// The `listen` method launches a web server.
server.listen({ port }).then(({ url, subscriptionsUrl }) => {
    console.log(`Server ready at ${url}`);
    console.log(`🚀 Subscriptions ready at ${subscriptionsUrl}`);
})//.catch(console.log("Already Running"));

module.exports = {
    server
}
