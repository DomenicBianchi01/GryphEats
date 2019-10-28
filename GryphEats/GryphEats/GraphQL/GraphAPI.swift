//  This file was automatically generated and should not be edited.

import Apollo

public final class PlaceOrderMutation: GraphQLMutation {
  /// mutation PlaceOrder($foodIDs: [ID]!, $restaurantID: ID!) {
  ///   placeOrder(foodids: $foodIDs, restaurantid: $restaurantID) {
  ///     __typename
  ///     success
  ///   }
  /// }
  public let operationDefinition =
    "mutation PlaceOrder($foodIDs: [ID]!, $restaurantID: ID!) { placeOrder(foodids: $foodIDs, restaurantid: $restaurantID) { __typename success } }"

  public let operationName = "PlaceOrder"

  public var foodIDs: [GraphQLID?]
  public var restaurantID: GraphQLID

  public init(foodIDs: [GraphQLID?], restaurantID: GraphQLID) {
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

public final class RestaurantMenusQuery: GraphQLQuery {
  /// query RestaurantMenus {
  ///   restaurants {
  ///     __typename
  ///     id: restaurantid
  ///     name: displayname
  ///     menu {
  ///       __typename
  ///       isActive: isactive
  ///       menuItems {
  ///         __typename
  ///         item {
  ///           __typename
  ///           id: foodid
  ///           restaurantID: restaurantid
  ///           displayName: displayname
  ///           price
  ///         }
  ///       }
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "query RestaurantMenus { restaurants { __typename id: restaurantid name: displayname menu { __typename isActive: isactive menuItems { __typename item { __typename id: foodid restaurantID: restaurantid displayName: displayname price } } } } }"

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
