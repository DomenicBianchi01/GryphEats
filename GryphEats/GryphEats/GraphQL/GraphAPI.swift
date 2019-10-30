//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum OrderStatus: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case neworder
  case inprogress
  case ready
  case pickedup
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "neworder": self = .neworder
      case "inprogress": self = .inprogress
      case "ready": self = .ready
      case "pickedup": self = .pickedup
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .neworder: return "neworder"
      case .inprogress: return "inprogress"
      case .ready: return "ready"
      case .pickedup: return "pickedup"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: OrderStatus, rhs: OrderStatus) -> Bool {
    switch (lhs, rhs) {
      case (.neworder, .neworder): return true
      case (.inprogress, .inprogress): return true
      case (.ready, .ready): return true
      case (.pickedup, .pickedup): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [OrderStatus] {
    return [
      .neworder,
      .inprogress,
      .ready,
      .pickedup,
    ]
  }
}

public final class PlaceOrderMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation PlaceOrder($foodIDs: [ID!]!, $restaurantID: ID!) {
      placeOrder(foodids: $foodIDs, restaurantid: $restaurantID) {
        __typename
        success
      }
    }
    """

  public let operationName = "PlaceOrder"

  public var foodIDs: [GraphQLID]
  public var restaurantID: GraphQLID

  public init(foodIDs: [GraphQLID], restaurantID: GraphQLID) {
    self.foodIDs = foodIDs
    self.restaurantID = restaurantID
  }

  public var variables: GraphQLMap? {
    return ["foodIDs": foodIDs, "restaurantID": restaurantID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("placeOrder", arguments: ["foodids": GraphQLVariable("foodIDs"), "restaurantid": GraphQLVariable("restaurantID")], type: .object(PlaceOrder.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(placeOrder: PlaceOrder? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "placeOrder": placeOrder.flatMap { (value: PlaceOrder) -> ResultMap in value.resultMap }])
    }

    public var placeOrder: PlaceOrder? {
      get {
        return (resultMap["placeOrder"] as? ResultMap).flatMap { PlaceOrder(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "placeOrder")
      }
    }

    public struct PlaceOrder: GraphQLSelectionSet {
      public static let possibleTypes = ["Finish"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("success", type: .nonNull(.scalar(Bool.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(success: Bool) {
        self.init(unsafeResultMap: ["__typename": "Finish", "success": success])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var success: Bool {
        get {
          return resultMap["success"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "success")
        }
      }
    }
  }
}

public final class UpdateOrderMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation UpdateOrder($orderID: ID!, $status: OrderStatus!, $res: ID!) {
      updateOrder(orderid: $orderID, status: $status, restaurantid: $res) {
        __typename
        orderid
      }
    }
    """

  public let operationName = "UpdateOrder"

  public var orderID: GraphQLID
  public var status: OrderStatus
  public var res: GraphQLID

  public init(orderID: GraphQLID, status: OrderStatus, res: GraphQLID) {
    self.orderID = orderID
    self.status = status
    self.res = res
  }

  public var variables: GraphQLMap? {
    return ["orderID": orderID, "status": status, "res": res]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateOrder", arguments: ["orderid": GraphQLVariable("orderID"), "status": GraphQLVariable("status"), "restaurantid": GraphQLVariable("res")], type: .object(UpdateOrder.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateOrder: UpdateOrder? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateOrder": updateOrder.flatMap { (value: UpdateOrder) -> ResultMap in value.resultMap }])
    }

    public var updateOrder: UpdateOrder? {
      get {
        return (resultMap["updateOrder"] as? ResultMap).flatMap { UpdateOrder(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateOrder")
      }
    }

    public struct UpdateOrder: GraphQLSelectionSet {
      public static let possibleTypes = ["FoodOrder"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("orderid", type: .nonNull(.scalar(GraphQLID.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(orderid: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "FoodOrder", "orderid": orderid])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var orderid: GraphQLID {
        get {
          return resultMap["orderid"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "orderid")
        }
      }
    }
  }
}

public final class OrdersByRestQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query OrdersByRest($restID: ID!) {
      getOrdersByRestaurantID(restaurantid: $restID) {
        __typename
        orderid
        timeplaced
        timecompleted
        restaurantid
        orderitems {
          __typename
          orderid
          foodid
          identifier
          food {
            __typename
            foodid
            displayname
            description
          }
        }
      }
    }
    """

  public let operationName = "OrdersByRest"

  public var restID: GraphQLID

  public init(restID: GraphQLID) {
    self.restID = restID
  }

  public var variables: GraphQLMap? {
    return ["restID": restID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getOrdersByRestaurantID", arguments: ["restaurantid": GraphQLVariable("restID")], type: .nonNull(.list(.object(GetOrdersByRestaurantId.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getOrdersByRestaurantId: [GetOrdersByRestaurantId?]) {
      self.init(unsafeResultMap: ["__typename": "Query", "getOrdersByRestaurantID": getOrdersByRestaurantId.map { (value: GetOrdersByRestaurantId?) -> ResultMap? in value.flatMap { (value: GetOrdersByRestaurantId) -> ResultMap in value.resultMap } }])
    }

    public var getOrdersByRestaurantId: [GetOrdersByRestaurantId?] {
      get {
        return (resultMap["getOrdersByRestaurantID"] as! [ResultMap?]).map { (value: ResultMap?) -> GetOrdersByRestaurantId? in value.flatMap { (value: ResultMap) -> GetOrdersByRestaurantId in GetOrdersByRestaurantId(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GetOrdersByRestaurantId?) -> ResultMap? in value.flatMap { (value: GetOrdersByRestaurantId) -> ResultMap in value.resultMap } }, forKey: "getOrdersByRestaurantID")
      }
    }

    public struct GetOrdersByRestaurantId: GraphQLSelectionSet {
      public static let possibleTypes = ["FoodOrder"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("orderid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("timeplaced", type: .scalar(String.self)),
        GraphQLField("timecompleted", type: .scalar(String.self)),
        GraphQLField("restaurantid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("orderitems", type: .list(.object(Orderitem.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(orderid: GraphQLID, timeplaced: String? = nil, timecompleted: String? = nil, restaurantid: GraphQLID, orderitems: [Orderitem?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "FoodOrder", "orderid": orderid, "timeplaced": timeplaced, "timecompleted": timecompleted, "restaurantid": restaurantid, "orderitems": orderitems.flatMap { (value: [Orderitem?]) -> [ResultMap?] in value.map { (value: Orderitem?) -> ResultMap? in value.flatMap { (value: Orderitem) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var orderid: GraphQLID {
        get {
          return resultMap["orderid"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "orderid")
        }
      }

      public var timeplaced: String? {
        get {
          return resultMap["timeplaced"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "timeplaced")
        }
      }

      public var timecompleted: String? {
        get {
          return resultMap["timecompleted"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "timecompleted")
        }
      }

      public var restaurantid: GraphQLID {
        get {
          return resultMap["restaurantid"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "restaurantid")
        }
      }

      public var orderitems: [Orderitem?]? {
        get {
          return (resultMap["orderitems"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Orderitem?] in value.map { (value: ResultMap?) -> Orderitem? in value.flatMap { (value: ResultMap) -> Orderitem in Orderitem(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Orderitem?]) -> [ResultMap?] in value.map { (value: Orderitem?) -> ResultMap? in value.flatMap { (value: Orderitem) -> ResultMap in value.resultMap } } }, forKey: "orderitems")
        }
      }

      public struct Orderitem: GraphQLSelectionSet {
        public static let possibleTypes = ["OrderItem"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("orderid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("foodid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("identifier", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("food", type: .object(Food.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(orderid: GraphQLID, foodid: GraphQLID, identifier: GraphQLID, food: Food? = nil) {
          self.init(unsafeResultMap: ["__typename": "OrderItem", "orderid": orderid, "foodid": foodid, "identifier": identifier, "food": food.flatMap { (value: Food) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var orderid: GraphQLID {
          get {
            return resultMap["orderid"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "orderid")
          }
        }

        public var foodid: GraphQLID {
          get {
            return resultMap["foodid"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "foodid")
          }
        }

        public var identifier: GraphQLID {
          get {
            return resultMap["identifier"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "identifier")
          }
        }

        public var food: Food? {
          get {
            return (resultMap["food"] as? ResultMap).flatMap { Food(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "food")
          }
        }

        public struct Food: GraphQLSelectionSet {
          public static let possibleTypes = ["Food"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("foodid", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("displayname", type: .scalar(String.self)),
            GraphQLField("description", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(foodid: GraphQLID, displayname: String? = nil, description: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Food", "foodid": foodid, "displayname": displayname, "description": description])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var foodid: GraphQLID {
            get {
              return resultMap["foodid"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "foodid")
            }
          }

          public var displayname: String? {
            get {
              return resultMap["displayname"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "displayname")
            }
          }

          public var description: String? {
            get {
              return resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }
        }
      }
    }
  }
}

public final class RestaurantMenusQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query RestaurantMenus {
      restaurants {
        __typename
        id: restaurantid
        name: displayname
        menu {
          __typename
          isActive: isactive
          menuItems {
            __typename
            item {
              __typename
              id: foodid
              restaurantID: restaurantid
              displayName: displayname
              price
            }
          }
        }
      }
    }
    """

  public let operationName = "RestaurantMenus"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("restaurants", type: .nonNull(.list(.object(Restaurant.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(restaurants: [Restaurant?]) {
      self.init(unsafeResultMap: ["__typename": "Query", "restaurants": restaurants.map { (value: Restaurant?) -> ResultMap? in value.flatMap { (value: Restaurant) -> ResultMap in value.resultMap } }])
    }

    public var restaurants: [Restaurant?] {
      get {
        return (resultMap["restaurants"] as! [ResultMap?]).map { (value: ResultMap?) -> Restaurant? in value.flatMap { (value: ResultMap) -> Restaurant in Restaurant(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Restaurant?) -> ResultMap? in value.flatMap { (value: Restaurant) -> ResultMap in value.resultMap } }, forKey: "restaurants")
      }
    }

    public struct Restaurant: GraphQLSelectionSet {
      public static let possibleTypes = ["Restaurant"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("restaurantid", alias: "id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("displayname", alias: "name", type: .nonNull(.scalar(String.self))),
        GraphQLField("menu", type: .list(.object(Menu.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, menu: [Menu?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Restaurant", "id": id, "name": name, "menu": menu.flatMap { (value: [Menu?]) -> [ResultMap?] in value.map { (value: Menu?) -> ResultMap? in value.flatMap { (value: Menu) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var menu: [Menu?]? {
        get {
          return (resultMap["menu"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Menu?] in value.map { (value: ResultMap?) -> Menu? in value.flatMap { (value: ResultMap) -> Menu in Menu(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Menu?]) -> [ResultMap?] in value.map { (value: Menu?) -> ResultMap? in value.flatMap { (value: Menu) -> ResultMap in value.resultMap } } }, forKey: "menu")
        }
      }

      public struct Menu: GraphQLSelectionSet {
        public static let possibleTypes = ["Menu"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("isactive", alias: "isActive", type: .scalar(Bool.self)),
          GraphQLField("menuItems", type: .list(.object(MenuItem.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(isActive: Bool? = nil, menuItems: [MenuItem?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Menu", "isActive": isActive, "menuItems": menuItems.flatMap { (value: [MenuItem?]) -> [ResultMap?] in value.map { (value: MenuItem?) -> ResultMap? in value.flatMap { (value: MenuItem) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var isActive: Bool? {
          get {
            return resultMap["isActive"] as? Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isActive")
          }
        }

        public var menuItems: [MenuItem?]? {
          get {
            return (resultMap["menuItems"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [MenuItem?] in value.map { (value: ResultMap?) -> MenuItem? in value.flatMap { (value: ResultMap) -> MenuItem in MenuItem(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [MenuItem?]) -> [ResultMap?] in value.map { (value: MenuItem?) -> ResultMap? in value.flatMap { (value: MenuItem) -> ResultMap in value.resultMap } } }, forKey: "menuItems")
          }
        }

        public struct MenuItem: GraphQLSelectionSet {
          public static let possibleTypes = ["MenuItem"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("item", type: .object(Item.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(item: Item? = nil) {
            self.init(unsafeResultMap: ["__typename": "MenuItem", "item": item.flatMap { (value: Item) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var item: Item? {
            get {
              return (resultMap["item"] as? ResultMap).flatMap { Item(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "item")
            }
          }

          public struct Item: GraphQLSelectionSet {
            public static let possibleTypes = ["Food"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("foodid", alias: "id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("restaurantid", alias: "restaurantID", type: .scalar(GraphQLID.self)),
              GraphQLField("displayname", alias: "displayName", type: .scalar(String.self)),
              GraphQLField("price", type: .scalar(Double.self)),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, restaurantId: GraphQLID? = nil, displayName: String? = nil, price: Double? = nil) {
              self.init(unsafeResultMap: ["__typename": "Food", "id": id, "restaurantID": restaurantId, "displayName": displayName, "price": price])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: GraphQLID {
              get {
                return resultMap["id"]! as! GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var restaurantId: GraphQLID? {
              get {
                return resultMap["restaurantID"] as? GraphQLID
              }
              set {
                resultMap.updateValue(newValue, forKey: "restaurantID")
              }
            }

            public var displayName: String? {
              get {
                return resultMap["displayName"] as? String
              }
              set {
                resultMap.updateValue(newValue, forKey: "displayName")
              }
            }

            public var price: Double? {
              get {
                return resultMap["price"] as? Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "price")
              }
            }
          }
        }
      }
    }
  }
}

public final class OrderPlacedSubscription: GraphQLSubscription {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    subscription OrderPlaced($restaurantID: ID!) {
      orderPlaced(restaurantid: $restaurantID) {
        __typename
        orderid
        timeplaced
        orderitems {
          __typename
          orderid
          foodid
          identifier
          food {
            __typename
            foodid
            displayname
            description
          }
        }
      }
    }
    """

  public let operationName = "OrderPlaced"

  public var restaurantID: GraphQLID

  public init(restaurantID: GraphQLID) {
    self.restaurantID = restaurantID
  }

  public var variables: GraphQLMap? {
    return ["restaurantID": restaurantID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("orderPlaced", arguments: ["restaurantid": GraphQLVariable("restaurantID")], type: .list(.object(OrderPlaced.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(orderPlaced: [OrderPlaced?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Subscription", "orderPlaced": orderPlaced.flatMap { (value: [OrderPlaced?]) -> [ResultMap?] in value.map { (value: OrderPlaced?) -> ResultMap? in value.flatMap { (value: OrderPlaced) -> ResultMap in value.resultMap } } }])
    }

    public var orderPlaced: [OrderPlaced?]? {
      get {
        return (resultMap["orderPlaced"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [OrderPlaced?] in value.map { (value: ResultMap?) -> OrderPlaced? in value.flatMap { (value: ResultMap) -> OrderPlaced in OrderPlaced(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [OrderPlaced?]) -> [ResultMap?] in value.map { (value: OrderPlaced?) -> ResultMap? in value.flatMap { (value: OrderPlaced) -> ResultMap in value.resultMap } } }, forKey: "orderPlaced")
      }
    }

    public struct OrderPlaced: GraphQLSelectionSet {
      public static let possibleTypes = ["FoodOrder"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("orderid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("timeplaced", type: .scalar(String.self)),
        GraphQLField("orderitems", type: .list(.object(Orderitem.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(orderid: GraphQLID, timeplaced: String? = nil, orderitems: [Orderitem?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "FoodOrder", "orderid": orderid, "timeplaced": timeplaced, "orderitems": orderitems.flatMap { (value: [Orderitem?]) -> [ResultMap?] in value.map { (value: Orderitem?) -> ResultMap? in value.flatMap { (value: Orderitem) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var orderid: GraphQLID {
        get {
          return resultMap["orderid"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "orderid")
        }
      }

      public var timeplaced: String? {
        get {
          return resultMap["timeplaced"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "timeplaced")
        }
      }

      public var orderitems: [Orderitem?]? {
        get {
          return (resultMap["orderitems"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Orderitem?] in value.map { (value: ResultMap?) -> Orderitem? in value.flatMap { (value: ResultMap) -> Orderitem in Orderitem(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Orderitem?]) -> [ResultMap?] in value.map { (value: Orderitem?) -> ResultMap? in value.flatMap { (value: Orderitem) -> ResultMap in value.resultMap } } }, forKey: "orderitems")
        }
      }

      public struct Orderitem: GraphQLSelectionSet {
        public static let possibleTypes = ["OrderItem"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("orderid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("foodid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("identifier", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("food", type: .object(Food.selections)),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(orderid: GraphQLID, foodid: GraphQLID, identifier: GraphQLID, food: Food? = nil) {
          self.init(unsafeResultMap: ["__typename": "OrderItem", "orderid": orderid, "foodid": foodid, "identifier": identifier, "food": food.flatMap { (value: Food) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var orderid: GraphQLID {
          get {
            return resultMap["orderid"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "orderid")
          }
        }

        public var foodid: GraphQLID {
          get {
            return resultMap["foodid"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "foodid")
          }
        }

        public var identifier: GraphQLID {
          get {
            return resultMap["identifier"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "identifier")
          }
        }

        public var food: Food? {
          get {
            return (resultMap["food"] as? ResultMap).flatMap { Food(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "food")
          }
        }

        public struct Food: GraphQLSelectionSet {
          public static let possibleTypes = ["Food"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("foodid", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("displayname", type: .scalar(String.self)),
            GraphQLField("description", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(foodid: GraphQLID, displayname: String? = nil, description: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Food", "foodid": foodid, "displayname": displayname, "description": description])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var foodid: GraphQLID {
            get {
              return resultMap["foodid"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "foodid")
            }
          }

          public var displayname: String? {
            get {
              return resultMap["displayname"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "displayname")
            }
          }

          public var description: String? {
            get {
              return resultMap["description"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "description")
            }
          }
        }
      }
    }
  }
}
