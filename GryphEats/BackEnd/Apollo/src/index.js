const { ApolloServer } = require('apollo-server');
const typeDefs = require('./schema');
const resolvers = require('./resolvers');
const { createDB } = require('./utils');

const GryphAPI = require('./datasources/gryphEats');
const database = createDB();

const dataSources = () => ({
    gryphAPI: new GryphAPI({ database }),
});

//called everytime something calls Graph
const context = async ({ req }) => {
    // simple auth check on every request
    // console.log(req.headers);
    return "IDK";
}

// The ApolloServer constructor requires two parameters: 
// your schema = typeDefs
// definition and your set of resolvers.
const server = new ApolloServer({
    context,
    typeDefs,
    resolvers,
    dataSources,
    // context: { gryphAPI }
});
const port = 4000;

// The `listen` method launches a web server.
server.listen({ port }).then(({ url }) => {
    console.log(`Server ready at ${url}`);
}).catch(console.log("Already Running"));
