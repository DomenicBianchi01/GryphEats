const { DataSource } = require('apollo-datasource');
const { ApolloError } = require("apollo-server");
const ps = require('../pubsub');
const pubsub = ps.pubsub;
const Sequelize = require('sequelize');
const apn = require('@parse/node-apn');
const bcrypt = require("bcrypt");
const Op = Sequelize.Op;
const POST_ADDED = 'POST_ADDED';
// const ORDER_PLACED = 'ORDER_PLACED';
const ORDER_UPDATED = 'ORDER_UPDATED';
const MENU_UPDATED = 'MENU_UPDATED';

class GryphAPIS extends DataSource {
    constructor({ database }) {
        super();
        this.database = database;
    }

    /**
     * Called when ApolloServer is being setup
     * gets called with datasource, includes info about requestor
     */
    initialize(config) {
        this.config = config.context;
    }

    /**
     * Functions
     */


    async customTest({ foodwrappers }) {
        try {
            const result = await this.database.food.findAll();
            return result;
        } catch (e) {
            console.log(e.message);
            return "fail";
        }
    }

    async getAllFood() {
        try {
            // console.log(this.config);
            // const fid = this.context.food.foodid;
            const result = await this.database.food.findAll();
            // console.log(result);
            return result;
        } catch (e) {
            console.log(e.message);
            return "getAllFood Failed: " + e.message;
        }
    }

    async getFoodByFoodID({ foodid }) {
        try {
            const result = await this.database.food.findOne({
                where: { foodid },
            });
            return result;
        } catch (e) {

        }
    }

    async getFoodByDisplayName({ displayname }) {
        try {
            const result = await this.database.food.findOne({
                where: { displayname },
            });
            return result;
        } catch (e) {

        }
    }

    async updateFoodPriceByFoodID({ foodid, price }) {
        try {
            const result = await this.database.food.update({ price }, {
                where: { foodid }
            });
            console.log(result);
            if (result) {
                return "true";
            } else {
                return "false";
            }
        } catch (e) {

        }
    }

    async updateisActiveByRestID({ restaurantid, isactive }) {
        try {
            const result = await this.database.restaurant.update({ isactive }, {
                where: { restaurantid }
            });
            console.log(result);
            await pubsub.publish(MENU_UPDATED, { menuUpdated: result });

            if (result) {
                return "true";
            } else {
                return "false";
            }
        } catch (e) {

        }
    }
    // foodid: ID!
    // displayname: String
    // toppingtype: ID
    // price: ID
    // restaurantid: ID
    // isavailable: ID
    // description: String
    // foodgroup: ID

    async updateFoodAvailabilityByFoodID({ foodid, isavailable }) {
        try {
            const result = await this.database.food.update({ isavailable }, {
                where: { foodid }
            });
            console.log(result);
            await pubsub.publish(MENU_UPDATED, { menuUpdated: result });

            if (result) {
                return "true";
            } else {
                return "false";
            }
        } catch (e) {

        }
    }

    async updatePasswordByEmail({ email, encryptedpw }) {
        try {
            encryptedpw = await this.generateHash(encryptedpw);
            const result = await this.database.user.update({ encryptedpw }, {
                where: { email }
            });
            // console.log(result);
            if (result) {
                return true;
            } else {
                return false;
            }
        } catch (e) {

        }
    }

    async createFood({ displayname, toppingtype, price, restaurantid, isavailable, description, foodgroup }) {
        try {
            const result = await this.database.food.create({
                displayname, toppingtype, price, isavailable, restaurantid, description, foodgroup
            });
            //pubpubsub.publish(POST_ADDED, { postAdded: displayname });
            if (result) {
                await pubsub.publish(POST_ADDED, { foodAdded: result });
                return "Created";
            } else {
                // await pubsub.publish(POST_ADDED, { postAdded: "unable to create?" });
                return "failed to create";
            }
        } catch (e) {

        }
    }

    async generateHash(encryptedpw) {
        return bcrypt.hash(encryptedpw, bcrypt.genSaltSync(8));
    }

    async createUser({ fname, lname, phonenum, address, email, encryptedpw, usertype, securityq, securitya }) {
        try {
            // console.log(await this.generateHash(encryptedpw));
            encryptedpw = await this.generateHash(encryptedpw);
            if (securitya) {
                securitya = await this.generateHash(securitya);
            }
            const result = await this.database.user.create({
                fname, lname, phonenum, address, email, encryptedpw, usertype, securityq, securitya
            });
            if (result) {
                await pubsub.publish(POST_ADDED, { userAdded: result });
                return {
                    success: true,
                    message: 'User created',
                }
            } else {
                return {
                    success: true,
                    message: 'Could not create user',
                }
            }
        } catch (e) {
            return {
                success: false,
                message: e,
            }
        }
    }

    async deleteFoodByFoodID({ foodid }) {
        try {
            const result = await this.database.food.destroy({
                where: { foodid }
            });
            if (result) {
                return "foodid:" + foodid + " deleted";
            } else {
                return "foodid:" + foodid + " failed to deleted";
            }
        } catch (e) {
            return "Fail";
        }
    }

    async registerNotify({ userid, uuid, token }) {
        try {
            const result = await this.database.notif.create({
                userid, uuid, token
            });
            if (result) {
                return true;
            } else {
                return false;
            }
        } catch (e) {
            return false;
        }
    }

    async deleteNotifByUUID({ userid, uuid }) {
        try {
            const result = await this.database.notif.destroy({
                where: { userid, uuid }
            });
            if (result) {
                return true;
            } else {
                return false;
            }
        } catch (e) {
            return false;
        }
    }

    // Post.update({
    //     updatedAt: null,
    //   }, {
    //     where: {
    //       deletedAt: {
    //         [Op.ne]: null
    //       }
    //     }
    //   });

    // User.create({ username: 'fnord', job: 'omnomnom' })

    // get all restaurant names
    async getAllRestaurants() {
        try {
            // console.log(this.config);
            // const fid = this.context.food.foodid;
            const result = await this.database.restaurant.findAll({
                // include: [{
                //     model: this.database.menu,
                // }]
            });
            // console.log(result)
            // console.log(result);
            return result;
        } catch (e) {
            console.log(e.message);
            return "getAllRestaurants Failed: " + e.message;
        }
    }

    async getAllUsers() {
        try {
            // console.log(this.config);
            // const fid = this.context.food.foodid;
            const result = await this.database.user.findAll();
            // console.log(result);
            return result;
        } catch (e) {
            console.log(e.message);
            return "getAllUsers Failed: " + e.message;
        }
    }

    async getUserNotif({ userid }) {
        try {
            const result = await this.database.notif.findOne({
                where: { userid }
            })
            return result;
        } catch (e) {
            console.log(e.message);
            return null;
        }
    }

    async getOrders() {
        try {
            const result = await this.database.foodorder.findAll();
            return result;
        } catch (e) {
            console.log(e.message);
            return "getOrders Failed: " + e.message;
        }
    }

    async getOrderItemsByOrderID({ orderid }) {
        try {
            const result = await this.database.orderitem.findAll({
                where: { orderid },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getOrderItemsFailed: " + e.message;

        }
    }

    async getToppingsByIdentifier({ identifier }) {
        try {
            const result = await this.database.topping.findAll({
                where: { identifier },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getToppingsByIdentifier: " + e.message;
        }
    }

    async getStaticToppingByID({ toppingid }) {
        try {
            const result = await this.database.statictopping.findOne({
                where: { toppingid },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getStaticToppingByID: " + e.message;
        }
    }

    async getStaticToppingsByFoodGroup({ foodgroup }) {
        if (foodgroup != null) {
            try {
                const result = await this.database.statictopping.findAll({
                    where: { foodgroup },
                });
                return result;
            } catch (e) {
                console.log(e.message);
                return "getStaticToppingByID: " + e.message;
            }
        }
    }

    async getStaticToppingsByFoodGroup({ foodgroup }) {
        try {
            const result = await this.database.statictopping.findAll({
                where: { foodgroup },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getOrderItemsFailed: " + e.message;

        }

    }

    async getSecurityQuestionByEmail({ email }) {
        try {
            const result = await this.database.user.findAll({
                where: { email },
            });

            if (result[0] != null) {
                return result[0].dataValues.securityq;
            }
        } catch (e) {
            console.log(e.message);
            return null;
        }

        throw new ApolloError("No email found", 404);
    }

    async validateSecurityQuestion({ email, securitya }) {
        try {
            const result = await this.database.user.findOne({
                where: { email },
            });
            // if (result[0] != null) {
            //     return true;
            // }
            // else {
            //     return false;
            // }
            // console.log(securitya);
            // console.log(result);
            // console.log(result.validAnswer(securitya));

            if (result && await result.validAnswer(securitya)) {
                return true;
            } else {
                return false;
            }
        } catch (e) {
            console.log(e.message);
            return false;

        }
    }

    async getAllMenus() {
        try {
            const result = await this.database.menu.findAll();
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenus Failed: " + e.message;
        }
    }

    async getMenusByRestaurantID({ restaurantid }) {
        try {
            // console.log("help" + restaurantid);
            const result = await this.database.menu.findAll({
                where: { restaurantid },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenusFailed: " + e.message;
        }
    }

    async getRestaurantByRestaurantID({ restaurantid }) {
        try {
            // console.log(restaurantid);
            const result = await this.database.restaurant.findOne({
                where: { restaurantid },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenusFailed: " + e.message;
        }
    }

    async getMenuItemsByMenuID({ menuid }) {
        try {
            const result = await this.database.menuitem.findAll({
                where: { menuid },
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenuItemsFailed: " + e.message;
        }
    }

    async getOrdersByRestaurantID({ restaurantid }) {
        try {
            const result = await this.database.foodorder.findAll({
                where: {
                    restaurantid, ordertype: [0, 1, 2]
                }
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenuItemsFailed: " + e.message;
        }
    }

    async getOrdersByUserID({ userid }) {
        try {
            const result = await this.database.foodorder.findAll({
                where: {
                    // restaurantid, ordertype: [0, 1, 2, 3]
                    userid
                }
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenuItemsFailed: " + e.message;
        }
    }

    async getOrderByOrderID({ orderid }) {
        try {
            const result = await this.database.foodorder.findOne({
                where: {
                    orderid
                }
            });
            return result;
        } catch (e) {
            console.log(e.message);
            return "getMenuItemsFailed: " + e.message;
        }
    }

    /**
     * complete order restaurant calls
     * Calls markorderdone and send notification
     */
    async completeOrder({ orderid }) {
        try {
            console.log(orderid);
            // return "orderid:" + orderid;
            return {
                success: true,
                message: 'Order Completed',
            };
        } catch (e) {
            console.log(e.message);
            return {
                success: false,
                message: "completeOrder Failed: " + e.message,
            };
        }
    }

    /*
    * marks an order with the current time
    */
    async markOrderDone() {
        try {

        } catch (e) {
            console.log(e.message);
            return "markOrderDone Failed: " + e.message;
        }
    }

    /**
     * Place an order
     * An array of foodids will be passed
     * Assume userid is 1
     */
    async placeOrder({ userid, foodwrappers, restaurantid, instructions, paymenttype }) {
        try {
            //create an order for restaurant
            const order = await this.createOrder({ userid, restaurantid, instructions, paymenttype });
            if (order) {
                var orderid = order.dataValues.orderid;
                // console.log(orderid);
                for (var foodwrapper in foodwrappers) {
                    // console.log(foodids[foodid]);
                    var thisFood = foodwrappers[foodwrapper];
                    var fid = thisFood.foodid;
                    const food = await this.createOrderItem({
                        orderid: orderid, foodid: fid
                    });
                    if (food) {
                        for (var i = 0; i < thisFood.toppingids.length; i++) {
                            console.log(i);
                            var toppingid = thisFood.toppingids[i];
                            var identifier = food.identifier
                            const result = await this.createTopping({ toppingid, identifier });
                        }
                    }
                }
                // var newOrders = await this.getOrdersByRestaurantID({ restaurantid });
                // console.log(newOrders);
                await pubsub.publish(ORDER_UPDATED, { orderUpdated: restaurantid });
                // await pubsub.publish(ORDER_PLACED, { orderPlaced: restaurantid });
                return {
                    success: true,
                    message: 'Order Completed',
                };
            }
            return {
                success: false,
                message: 'Order completing failed',
            };
        } catch (e) {
            return {
                success: false,
                message: "place order failed: " + e.message
            };
        }
    }

    async createTopping({ toppingid, identifier }) {
        try {
            const result = await this.database.topping.create({
                toppingid: toppingid, identifier: identifier
            });
            return "success";
        } catch (e) {
            return {
                success: false,
                message: "create topping failed: " + e.message
            };
        }
    }

    /**
     * create an order for restaurant
     */

    async createOrder({ userid, restaurantid, instructions, paymenttype }) {
        try {

            const restaurant = await this.database.restaurant.findOne({
                where: {
                    restaurantid: restaurantid
                },
            });

            const result = await this.database.foodorder.create({
                userid: userid, restaurantid: restaurantid, instructions: instructions, estimatedtime: 30, restaurantname: restaurant.displayname, paymenttype: paymenttype
            })
            return result;
        } catch (e) {
            return {
                success: false,
                message: "place order failed: " + e.message
            };
        }
    }

    async createOrderItem({ orderid, foodid }) {
        try {
            const result = await this.database.orderitem.create({
                orderid: orderid, foodid: foodid
            });
            return result;
        } catch (e) {
            return null;
        }
    }

    /**
     * Update an order, return updated ordered
     */
    async updateOrder({ orderid, status, restaurantid }) {
        console.log("Runnign!");
        try {
            // console.log("ordertype" + status);
            var result;
            if (status == 3) {
                result = await this.database.foodorder.update({ ordertype: status, timecompleted: this.database.db.fn('NOW'), estimatedtime: 0 }, {
                    where: { orderid }
                });
            } else if (status == 4) {
                result = await this.database.foodorder.update({ ordertype: status, timecompleted: this.database.db.fn('NOW'), estimatedtime: 0 }, {
                    where: { orderid, ordertype: 0 }
                });
            } else if (status == 2) {
                result = await this.database.foodorder.update({ ordertype: status, timecompleted: null, estimatedtime: 0 }, {
                    where: { orderid }
                });
            }
            else {
                result = await this.database.foodorder.update({ ordertype: status, timecompleted: null, estimatedtime: 20 }, {
                    where: { orderid }
                });
            }
            // console.log(result);
            // var newOrders = await this.getOrdersByRestaurantID({ restaurantid });
            // await pubsub.publish(ORDER_PLACED, { orderPlaced: restaurantid });
            await pubsub.publish(ORDER_UPDATED, { orderUpdated: restaurantid });

            var options = {
                token: {
                    key: "/home/cis4250-1/cis-4250-the-subway-squad/GryphEats/BackEnd/Apollo/src/datasources/AuthKey_R7H2UN93CJ.p8",
                    keyId: "R7H2UN93CJ",
                    teamId: "667D8S5SPP"
                },
                production: false
            };

            var apnProvider = new apn.Provider(options);
            var note = new apn.Notification();
            var body = ""

            if (status == 1) {
                body = "Your order is now being made!"
            } else if (status == 2) {
                body = "Your order is ready for pickup!"
            }

            if (body != "") {
                note.expiry = Math.floor(Date.now() / 1000) + 3600; // Expires 1 hour from now.
                note.title = "Order Update"
                note.body = body;
                note.topic = "ca.thesubwaysquad.GryphEats"

                console.log(note);
                const currentOrder = await this.getOrderByOrderID({ orderid });
                const userid = currentOrder.dataValues.userid;
                const userNotif = await this.getUserNotif({ userid });
                const token = userNotif.dataValues.token;
                //TODO: This token is currently hardcoded. What needs to be done is the following: Given the `orderid`, you need to figure out which user to send the push notification to.
                // apnProvider.send(note, "0373d6d1cfc3ed2fe261460f541a9fa1cd5c966e5e8200c3777cb1e33e310333").then((result) => {
                apnProvider.send(note, token).then((result) => {
                    console.log(result.failed);
                    apnProvider.shutdown();
                }).catch((ex) => {
                    apn.Provider.shutdown();
                });
            }
            console.log(result);
            if (result) {
                return {
                    success: true,
                    message: 'Order update done',
                };
            } else {
                return {
                    success: false,
                    message: 'Order update failed',
                };
            }
        } catch (e) {
            console.log(e)
            return {
                success: false,
                message: "update order failed: " + e.message,
            };
        }
    }

    async validateUser({ email, pass }) {
        try {
            //check
            //return auth = 
            // console.log(email);
            const result = await this.database.user.findOne({
                where: {
                    email: email
                },
            });
            // console.log(result);
            if (result && await result.validPassword(pass)) {
                return {
                    isValid: true,
                    account: result,
                    token: "yee"
                };
            } else {
                return {
                    isValid: false,
                    account: null,
                    token: "no"
                };
            }
        } catch (e) {
            return {
                isValid: false,
                account: null,
                token: "error--" + e.message + "\n" + e.stacktrace
            };
        }
    }
}
// https://stackoverflow.com/questions/34120548/using-bcrypt-with-sequelize-model
module.exports = GryphAPIS;
