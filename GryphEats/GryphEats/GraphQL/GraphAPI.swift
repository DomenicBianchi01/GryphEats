//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum OrderStatus: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case neworder
  case inprogress
  case ready
  case pickedup
  case cancelled
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "neworder": self = .neworder
      case "inprogress": self = .inprogress
      case "ready": self = .ready
      case "pickedup": self = .pickedup
      case "cancelled": self = .cancelled
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .neworder: return "neworder"
      case .inprogress: return "inprogress"
      case .ready: return "ready"
      case .pickedup: return "pickedup"
      case .cancelled: return "cancelled"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: OrderStatus, rhs: OrderStatus) -> Bool {
    switch (lhs, rhs) {
      case (.neworder, .neworder): return true
      case (.inprogress, .inprogress): return true
      case (.ready, .ready): return true
      case (.pickedup, .pickedup): return true
      case (.cancelled, .cancelled): return true
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
      .cancelled,
    ]
  }
}

public enum UserType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case customer
  case restaurant
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "customer": self = .customer
      case "restaurant": self = .restaurant
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .customer: return "customer"
      case .restaurant: return "restaurant"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: UserType, rhs: UserType) -> Bool {
    switch (lhs, rhs) {
      case (.customer, .customer): return true
      case (.restaurant, .restaurant): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [UserType] {
    return [
      .customer,
      .restaurant,
    ]
  }
}

public final class PlaceOrderMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation PlaceOrder($foodIDs: [ID!]!, $restaurantID: ID!, $userID: ID!) {
      placeOrder(userid: $userID, foodids: $foodIDs, restaurantid: $restaurantID) {
        __typename
        success
      }
    }
    """

  public let operationName = "PlaceOrder"

  public var foodIDs: [GraphQLID]
  public var restaurantID: GraphQLID
  public var userID: GraphQLID

  public init(foodIDs: [GraphQLID], restaurantID: GraphQLID, userID: GraphQLID) {
    self.foodIDs = foodIDs
    self.restaurantID = restaurantID
    self.userID = userID
  }

  public var variables: GraphQLMap? {
    return ["foodIDs": foodIDs, "restaurantID": restaurantID, "userID": userID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("placeOrder", arguments: ["userid": GraphQLVariable("userID"), "foodids": GraphQLVariable("foodIDs"), "restaurantid": GraphQLVariable("restaurantID")], type: .object(PlaceOrder.selections)),
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
    mutation UpdateOrder($orderID: ID!, $status: OrderStatus!, $restaurantID: ID!) {
      updateOrder(orderid: $orderID, status: $status, restaurantid: $restaurantID) {
        __typename
        success
      }
    }
    """

  public let operationName = "UpdateOrder"

  public var orderID: GraphQLID
  public var status: OrderStatus
  public var restaurantID: GraphQLID

  public init(orderID: GraphQLID, status: OrderStatus, restaurantID: GraphQLID) {
    self.orderID = orderID
    self.status = status
    self.restaurantID = restaurantID
  }

  public var variables: GraphQLMap? {
    return ["orderID": orderID, "status": status, "restaurantID": restaurantID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateOrder", arguments: ["orderid": GraphQLVariable("orderID"), "status": GraphQLVariable("status"), "restaurantid": GraphQLVariable("restaurantID")], type: .object(UpdateOrder.selections)),
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

public final class SecurityQuestionQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query SecurityQuestion($email: String!) {
      question: getSecurityQuestionByEmail(email: $email)
    }
    """

  public let operationName = "SecurityQuestion"

  public var email: String

  public init(email: String) {
    self.email = email
  }

  public var variables: GraphQLMap? {
    return ["email": email]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getSecurityQuestionByEmail", alias: "question", arguments: ["email": GraphQLVariable("email")], type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(question: String) {
      self.init(unsafeResultMap: ["__typename": "Query", "question": question])
    }

    public var question: String {
      get {
        return resultMap["question"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "question")
      }
    }
  }
}

public final class ValidateSecurityAnswerQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query ValidateSecurityAnswer($email: String!, $answer: String!) {
      isCorrect: validateSecurityQuestion(email: $email, securitya: $answer)
    }
    """

  public let operationName = "ValidateSecurityAnswer"

  public var email: String
  public var answer: String

  public init(email: String, answer: String) {
    self.email = email
    self.answer = answer
  }

  public var variables: GraphQLMap? {
    return ["email": email, "answer": answer]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("validateSecurityQuestion", alias: "isCorrect", arguments: ["email": GraphQLVariable("email"), "securitya": GraphQLVariable("answer")], type: .nonNull(.scalar(Bool.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(isCorrect: Bool) {
      self.init(unsafeResultMap: ["__typename": "Query", "isCorrect": isCorrect])
    }

    public var isCorrect: Bool {
      get {
        return resultMap["isCorrect"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "isCorrect")
      }
    }
  }
}

public final class UpdatePasswordMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation UpdatePassword($email: String!, $password: String!) {
      success: updatePasswordByEmail(email: $email, encryptedpw: $password)
    }
    """

  public let operationName = "UpdatePassword"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updatePasswordByEmail", alias: "success", arguments: ["email": GraphQLVariable("email"), "encryptedpw": GraphQLVariable("password")], type: .scalar(Bool.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(success: Bool? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "success": success])
    }

    public var success: Bool? {
      get {
        return resultMap["success"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "success")
      }
    }
  }
}

public final class LoginUserQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query LoginUser($email: String!, $password: String!) {
      validateUser(email: $email, pass: $password) {
        __typename
        isValid
        account {
          __typename
          userID: userid
          userType: usertype
        }
      }
    }
    """

  public let operationName = "LoginUser"

  public var email: String
  public var password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("validateUser", arguments: ["email": GraphQLVariable("email"), "pass": GraphQLVariable("password")], type: .nonNull(.object(ValidateUser.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(validateUser: ValidateUser) {
      self.init(unsafeResultMap: ["__typename": "Query", "validateUser": validateUser.resultMap])
    }

    public var validateUser: ValidateUser {
      get {
        return ValidateUser(unsafeResultMap: resultMap["validateUser"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "validateUser")
      }
    }

    public struct ValidateUser: GraphQLSelectionSet {
      public static let possibleTypes = ["Auth"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("isValid", type: .scalar(Bool.self)),
        GraphQLField("account", type: .object(Account.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(isValid: Bool? = nil, account: Account? = nil) {
        self.init(unsafeResultMap: ["__typename": "Auth", "isValid": isValid, "account": account.flatMap { (value: Account) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var isValid: Bool? {
        get {
          return resultMap["isValid"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isValid")
        }
      }

      public var account: Account? {
        get {
          return (resultMap["account"] as? ResultMap).flatMap { Account(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "account")
        }
      }

      public struct Account: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("userid", alias: "userID", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("usertype", alias: "userType", type: .nonNull(.scalar(UserType.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(userId: GraphQLID, userType: UserType) {
          self.init(unsafeResultMap: ["__typename": "User", "userID": userId, "userType": userType])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var userId: GraphQLID {
          get {
            return resultMap["userID"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "userID")
          }
        }

        public var userType: UserType {
          get {
            return resultMap["userType"]! as! UserType
          }
          set {
            resultMap.updateValue(newValue, forKey: "userType")
          }
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
        ordertype
        timeplaced
        timecompleted
        restaurantid
        orderitems {
          __typename
          orderid
          foodid
          identifier
          item {
            __typename
            ...FoodItemDetails
            description
          }
        }
      }
    }
    """

  public let operationName = "OrdersByRest"

  public var queryDocument: String { return operationDefinition.appending(FoodItemDetails.fragmentDefinition) }

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
        GraphQLField("ordertype", type: .nonNull(.scalar(OrderStatus.self))),
        GraphQLField("timeplaced", type: .nonNull(.scalar(String.self))),
        GraphQLField("timecompleted", type: .scalar(String.self)),
        GraphQLField("restaurantid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("orderitems", type: .nonNull(.list(.nonNull(.object(Orderitem.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(orderid: GraphQLID, ordertype: OrderStatus, timeplaced: String, timecompleted: String? = nil, restaurantid: GraphQLID, orderitems: [Orderitem]) {
        self.init(unsafeResultMap: ["__typename": "FoodOrder", "orderid": orderid, "ordertype": ordertype, "timeplaced": timeplaced, "timecompleted": timecompleted, "restaurantid": restaurantid, "orderitems": orderitems.map { (value: Orderitem) -> ResultMap in value.resultMap }])
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

      public var ordertype: OrderStatus {
        get {
          return resultMap["ordertype"]! as! OrderStatus
        }
        set {
          resultMap.updateValue(newValue, forKey: "ordertype")
        }
      }

      public var timeplaced: String {
        get {
          return resultMap["timeplaced"]! as! String
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

      public var orderitems: [Orderitem] {
        get {
          return (resultMap["orderitems"] as! [ResultMap]).map { (value: ResultMap) -> Orderitem in Orderitem(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Orderitem) -> ResultMap in value.resultMap }, forKey: "orderitems")
        }
      }

      public struct Orderitem: GraphQLSelectionSet {
        public static let possibleTypes = ["OrderItem"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("orderid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("foodid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("identifier", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("item", type: .nonNull(.object(Item.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(orderid: GraphQLID, foodid: GraphQLID, identifier: GraphQLID, item: Item) {
          self.init(unsafeResultMap: ["__typename": "OrderItem", "orderid": orderid, "foodid": foodid, "identifier": identifier, "item": item.resultMap])
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

        public var item: Item {
          get {
            return Item(unsafeResultMap: resultMap["item"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "item")
          }
        }

        public struct Item: GraphQLSelectionSet {
          public static let possibleTypes = ["Food"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(FoodItemDetails.self),
            GraphQLField("description", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, price: Double, description: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Food", "id": id, "name": name, "price": price, "description": description])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var foodItemDetails: FoodItemDetails {
              get {
                return FoodItemDetails(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
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
              ...FoodItemDetails
            }
          }
        }
      }
    }
    """

  public let operationName = "RestaurantMenus"

  public var queryDocument: String { return operationDefinition.appending(FoodItemDetails.fragmentDefinition) }

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
        GraphQLField("menu", type: .nonNull(.list(.object(Menu.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, name: String, menu: [Menu?]) {
        self.init(unsafeResultMap: ["__typename": "Restaurant", "id": id, "name": name, "menu": menu.map { (value: Menu?) -> ResultMap? in value.flatMap { (value: Menu) -> ResultMap in value.resultMap } }])
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

      public var menu: [Menu?] {
        get {
          return (resultMap["menu"] as! [ResultMap?]).map { (value: ResultMap?) -> Menu? in value.flatMap { (value: ResultMap) -> Menu in Menu(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Menu?) -> ResultMap? in value.flatMap { (value: Menu) -> ResultMap in value.resultMap } }, forKey: "menu")
        }
      }

      public struct Menu: GraphQLSelectionSet {
        public static let possibleTypes = ["Menu"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("isactive", alias: "isActive", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("menuItems", type: .nonNull(.list(.object(MenuItem.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(isActive: Bool, menuItems: [MenuItem?]) {
          self.init(unsafeResultMap: ["__typename": "Menu", "isActive": isActive, "menuItems": menuItems.map { (value: MenuItem?) -> ResultMap? in value.flatMap { (value: MenuItem) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var isActive: Bool {
          get {
            return resultMap["isActive"]! as! Bool
          }
          set {
            resultMap.updateValue(newValue, forKey: "isActive")
          }
        }

        public var menuItems: [MenuItem?] {
          get {
            return (resultMap["menuItems"] as! [ResultMap?]).map { (value: ResultMap?) -> MenuItem? in value.flatMap { (value: ResultMap) -> MenuItem in MenuItem(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.map { (value: MenuItem?) -> ResultMap? in value.flatMap { (value: MenuItem) -> ResultMap in value.resultMap } }, forKey: "menuItems")
          }
        }

        public struct MenuItem: GraphQLSelectionSet {
          public static let possibleTypes = ["MenuItem"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("item", type: .nonNull(.object(Item.selections))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(item: Item) {
            self.init(unsafeResultMap: ["__typename": "MenuItem", "item": item.resultMap])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var item: Item {
            get {
              return Item(unsafeResultMap: resultMap["item"]! as! ResultMap)
            }
            set {
              resultMap.updateValue(newValue.resultMap, forKey: "item")
            }
          }

          public struct Item: GraphQLSelectionSet {
            public static let possibleTypes = ["Food"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLFragmentSpread(FoodItemDetails.self),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, name: String, price: Double) {
              self.init(unsafeResultMap: ["__typename": "Food", "id": id, "name": name, "price": price])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var fragments: Fragments {
              get {
                return Fragments(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }

            public struct Fragments {
              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public var foodItemDetails: FoodItemDetails {
                get {
                  return FoodItemDetails(unsafeResultMap: resultMap)
                }
                set {
                  resultMap += newValue.resultMap
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class UserOrdersQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query UserOrders($userID: ID!) {
      getOrdersByUserID(userid: $userID) {
        __typename
        id: orderid
        restaurantId: restaurantid
        timePlaced: timeplaced
        status: ordertype
        items: orderitems {
          __typename
          item {
            __typename
            ...FoodItemDetails
          }
        }
      }
    }
    """

  public let operationName = "UserOrders"

  public var queryDocument: String { return operationDefinition.appending(FoodItemDetails.fragmentDefinition) }

  public var userID: GraphQLID

  public init(userID: GraphQLID) {
    self.userID = userID
  }

  public var variables: GraphQLMap? {
    return ["userID": userID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getOrdersByUserID", arguments: ["userid": GraphQLVariable("userID")], type: .nonNull(.list(.object(GetOrdersByUserId.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getOrdersByUserId: [GetOrdersByUserId?]) {
      self.init(unsafeResultMap: ["__typename": "Query", "getOrdersByUserID": getOrdersByUserId.map { (value: GetOrdersByUserId?) -> ResultMap? in value.flatMap { (value: GetOrdersByUserId) -> ResultMap in value.resultMap } }])
    }

    public var getOrdersByUserId: [GetOrdersByUserId?] {
      get {
        return (resultMap["getOrdersByUserID"] as! [ResultMap?]).map { (value: ResultMap?) -> GetOrdersByUserId? in value.flatMap { (value: ResultMap) -> GetOrdersByUserId in GetOrdersByUserId(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GetOrdersByUserId?) -> ResultMap? in value.flatMap { (value: GetOrdersByUserId) -> ResultMap in value.resultMap } }, forKey: "getOrdersByUserID")
      }
    }

    public struct GetOrdersByUserId: GraphQLSelectionSet {
      public static let possibleTypes = ["FoodOrder"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("orderid", alias: "id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("restaurantid", alias: "restaurantId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("timeplaced", alias: "timePlaced", type: .nonNull(.scalar(String.self))),
        GraphQLField("ordertype", alias: "status", type: .nonNull(.scalar(OrderStatus.self))),
        GraphQLField("orderitems", alias: "items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, restaurantId: GraphQLID, timePlaced: String, status: OrderStatus, items: [Item]) {
        self.init(unsafeResultMap: ["__typename": "FoodOrder", "id": id, "restaurantId": restaurantId, "timePlaced": timePlaced, "status": status, "items": items.map { (value: Item) -> ResultMap in value.resultMap }])
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

      public var restaurantId: GraphQLID {
        get {
          return resultMap["restaurantId"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "restaurantId")
        }
      }

      public var timePlaced: String {
        get {
          return resultMap["timePlaced"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "timePlaced")
        }
      }

      public var status: OrderStatus {
        get {
          return resultMap["status"]! as! OrderStatus
        }
        set {
          resultMap.updateValue(newValue, forKey: "status")
        }
      }

      public var items: [Item] {
        get {
          return (resultMap["items"] as! [ResultMap]).map { (value: ResultMap) -> Item in Item(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Item) -> ResultMap in value.resultMap }, forKey: "items")
        }
      }

      public struct Item: GraphQLSelectionSet {
        public static let possibleTypes = ["OrderItem"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("item", type: .nonNull(.object(Item.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(item: Item) {
          self.init(unsafeResultMap: ["__typename": "OrderItem", "item": item.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var item: Item {
          get {
            return Item(unsafeResultMap: resultMap["item"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "item")
          }
        }

        public struct Item: GraphQLSelectionSet {
          public static let possibleTypes = ["Food"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(FoodItemDetails.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, price: Double) {
            self.init(unsafeResultMap: ["__typename": "Food", "id": id, "name": name, "price": price])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var foodItemDetails: FoodItemDetails {
              get {
                return FoodItemDetails(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class OrderUpdatedSubscription: GraphQLSubscription {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    subscription OrderUpdated($restaurantID: ID!) {
      orderUpdated(restaurantid: $restaurantID) {
        __typename
        orderid
        ordertype
        timeplaced
        restaurantid
        orderitems {
          __typename
          orderid
          foodid
          identifier
          item {
            __typename
            ...FoodItemDetails
            description
          }
        }
      }
    }
    """

  public let operationName = "OrderUpdated"

  public var queryDocument: String { return operationDefinition.appending(FoodItemDetails.fragmentDefinition) }

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
      GraphQLField("orderUpdated", arguments: ["restaurantid": GraphQLVariable("restaurantID")], type: .list(.object(OrderUpdated.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(orderUpdated: [OrderUpdated?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Subscription", "orderUpdated": orderUpdated.flatMap { (value: [OrderUpdated?]) -> [ResultMap?] in value.map { (value: OrderUpdated?) -> ResultMap? in value.flatMap { (value: OrderUpdated) -> ResultMap in value.resultMap } } }])
    }

    public var orderUpdated: [OrderUpdated?]? {
      get {
        return (resultMap["orderUpdated"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [OrderUpdated?] in value.map { (value: ResultMap?) -> OrderUpdated? in value.flatMap { (value: ResultMap) -> OrderUpdated in OrderUpdated(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [OrderUpdated?]) -> [ResultMap?] in value.map { (value: OrderUpdated?) -> ResultMap? in value.flatMap { (value: OrderUpdated) -> ResultMap in value.resultMap } } }, forKey: "orderUpdated")
      }
    }

    public struct OrderUpdated: GraphQLSelectionSet {
      public static let possibleTypes = ["FoodOrder"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("orderid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("ordertype", type: .nonNull(.scalar(OrderStatus.self))),
        GraphQLField("timeplaced", type: .nonNull(.scalar(String.self))),
        GraphQLField("restaurantid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("orderitems", type: .nonNull(.list(.nonNull(.object(Orderitem.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(orderid: GraphQLID, ordertype: OrderStatus, timeplaced: String, restaurantid: GraphQLID, orderitems: [Orderitem]) {
        self.init(unsafeResultMap: ["__typename": "FoodOrder", "orderid": orderid, "ordertype": ordertype, "timeplaced": timeplaced, "restaurantid": restaurantid, "orderitems": orderitems.map { (value: Orderitem) -> ResultMap in value.resultMap }])
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

      public var ordertype: OrderStatus {
        get {
          return resultMap["ordertype"]! as! OrderStatus
        }
        set {
          resultMap.updateValue(newValue, forKey: "ordertype")
        }
      }

      public var timeplaced: String {
        get {
          return resultMap["timeplaced"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "timeplaced")
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

      public var orderitems: [Orderitem] {
        get {
          return (resultMap["orderitems"] as! [ResultMap]).map { (value: ResultMap) -> Orderitem in Orderitem(unsafeResultMap: value) }
        }
        set {
          resultMap.updateValue(newValue.map { (value: Orderitem) -> ResultMap in value.resultMap }, forKey: "orderitems")
        }
      }

      public struct Orderitem: GraphQLSelectionSet {
        public static let possibleTypes = ["OrderItem"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("orderid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("foodid", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("identifier", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("item", type: .nonNull(.object(Item.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(orderid: GraphQLID, foodid: GraphQLID, identifier: GraphQLID, item: Item) {
          self.init(unsafeResultMap: ["__typename": "OrderItem", "orderid": orderid, "foodid": foodid, "identifier": identifier, "item": item.resultMap])
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

        public var item: Item {
          get {
            return Item(unsafeResultMap: resultMap["item"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "item")
          }
        }

        public struct Item: GraphQLSelectionSet {
          public static let possibleTypes = ["Food"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(FoodItemDetails.self),
            GraphQLField("description", type: .scalar(String.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String, price: Double, description: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Food", "id": id, "name": name, "price": price, "description": description])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
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

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var foodItemDetails: FoodItemDetails {
              get {
                return FoodItemDetails(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public struct FoodItemDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition =
    """
    fragment FoodItemDetails on Food {
      __typename
      id: foodid
      name: displayname
      price
    }
    """

  public static let possibleTypes = ["Food"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("foodid", alias: "id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("displayname", alias: "name", type: .nonNull(.scalar(String.self))),
    GraphQLField("price", type: .nonNull(.scalar(Double.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String, price: Double) {
    self.init(unsafeResultMap: ["__typename": "Food", "id": id, "name": name, "price": price])
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

  public var price: Double {
    get {
      return resultMap["price"]! as! Double
    }
    set {
      resultMap.updateValue(newValue, forKey: "price")
    }
  }
}
