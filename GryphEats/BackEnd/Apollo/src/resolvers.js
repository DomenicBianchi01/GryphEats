//export default {
module.exports = {
    Query: {
        // foods: (parent, args, { datasources }, info) => datasources.food.findAll(),
        foods: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllFood(),
        restaurants: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllRestaurants(),
        users: async (_, args, { dataSources }, info) => dataSources.gryphAPI.getAllUsers(),
    }
};

// parent: An object that contains the result returned from the resolver on the parent type
    //usually blank and refers to top of graph
// args: An object that contains the arguments passed to the field
// context: An object shared by all resolvers in a GraphQL operation. 
    // We use the context to contain per-request state such as authentication information and access our data sources.
// info: Information about the execution state of the operation which should only be used in advanced cases