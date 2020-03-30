# GryphEats

GryphEats is an iOS app created for the capstone project in Software Design IV (CIS*4250). This was a group project that included four students and required us to create requirements and mockups, as well as provide weekly demos to the professor throughout development.

Students on campus at the University of Guelph could use this app to order food ahead of time. For example, a pizza from Creelman Hall usually takes about 10 minutes to make after ordering. Instead of having to wait in the cafeteria area, a student would use this app to order their pizza and once it is ready for pick up a push notification would be sent to their device. The student can select which ingredients they want included, use Apple Pay or their credit card to pay (for the purposes of the project, credit card payment was mocked) and check to see the status of their order.

GryphEats also has an iPad version of the app meant to be used by staff that work on the food station. Once a student places an order, the order will instantly appear on the iPad app where the staff member will press a button to acknowledge and order and later indicate when the order is ready for pickup.

There were a total of four group members for this project. Two worked on the backend, the third member worked on the iPad version of the app, and I worked on the student facing portion of the app (some of the screens are shown above).

Since this project started in September 2019 and SwiftUI was recently announced, we decided to learn SwiftUI and avoid using UIKit as much as possible. We also used GraphQL for communication between the servers and app. I had learned about GraphQL during my co-op work terms at ecobee; however, at the time ecobee wasn't using any GraphQL "subscriptions". As a result, my group learned how to implement "subscriptions" for two features:

- Have the iPad app listen for new orders
- Staff members could use the iPad to app to mark a menu item "out of stock". If an item is marked out of stock, the student facing app would immediately remove the item from the menu to prevent students from ordering that item.

## Roles/Contributors

Domenic Bianchi: iOS app - Student facing (iPhone)

Matthew Bebis: iOS app - Restaurant/staff facing (iPad)

Scott Riva: Backend - SQL

Shuaib Solker: Backend - GraphQL

## Demo

The iPhone on the left is the student facing version of the app. The iPad on the right is the restaurant/staff facing app.

### Placing An Order

After a student places an order, it appears immediately on to the restaurant/staff (on the iPad app). This is accomplished by using a GraphQL subscription.

![Place-Order](https://github.com/DomenicBianchi01/GryphEats/blob/master/Videos/PlaceOrder.gif)

### Order Updates

After placing an order, the student will receive two notifications:

1. Once the restaurant/staff members acknowledges the order and taps the "Begin Order" button.
2. Once the order is ready for pick up and the restaurant/staff member taps on the "Complete Order" button.

![Order-Notifications](https://github.com/DomenicBianchi01/GryphEats/blob/master/Videos/OrderStatusNotifications.gif)
