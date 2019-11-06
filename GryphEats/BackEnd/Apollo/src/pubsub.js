const { PubSub } = require('apollo-server');
const pubsub = new PubSub();
exports.pubsub = pubsub;