//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct FoodWrapper: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(foodid: GraphQLID, toppingids: Swift.Optional<[GraphQLID]?> = nil) {
    graphQLMap = ["foodid": foodid, "toppingids": toppingids]
  }

  public var foodid: GraphQLID {
    get {
      return graphQLMap["foodid"] as! GraphQLID
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "foodid")
    }
  }

  public var toppingids: Swift.Optional<[GraphQLID]?> {
    get {
      return graphQLMap["toppingids"] as? Swift.Optional<[GraphQLID]?> ?? Swift.Optional<[GraphQLID]?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "toppingids")
    }
  }
}

public enum PaymentType: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case credit
  case oncampus
  case offcampus
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "credit": self = .credit
      case "oncampus": self = .oncampus
      case "offcampus": self = .offcampus
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .credit: return "credit"
      case .oncampus: return "oncampus"
      case .offcampus: return "offcampus"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: PaymentType, rhs: PaymentType) -> Bool {
    switch (lhs, rhs) {
      case (.credit, .credit): return true
      case (.oncampus, .oncampus): return true
      case (.offcampus, .offcampus): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [PaymentType] {
    return [
      .credit,
      .oncampus,
      .offcampus,
    ]
  }
}

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
    mutation PlaceOrder($items: [FoodWrapper!]!, $restaurantID: ID!, $userID: ID!, $instructions: String, $paymentMethod: PaymentType!) {
      placeOrder(userid: $userID, foodwrappers: $items, restaurantid: $restaurantID, instructions: $instructions, paymenttype: $paymentMethod) {
        __typename
        success
      }
    }
    """

  public let operationName = "PlaceOrder"

  public var items: [FoodWrapper]
  public var restaurantID: GraphQLID
  public var userID: GraphQLID
  public var instructions: String?
  public var paymentMethod: PaymentType

  public init(items: [FoodWrapper], restaurantID: GraphQLID, userID: GraphQLID, instructions: String? = nil, paymentMethod: PaymentType) {
    self.items = items
    self.restaurantID = restaurantID
    self.userID = userID
    self.instructions = instructions
    self.paymentMethod = paymentMethod
  }

  public var variables: GraphQLMap? {
    return ["items": items, "restaurantID": restaurantID, "userID": userID, "instructions": instructions, "paymentMethod": paymentMethod]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("placeOrder", arguments: ["userid": GraphQLVariable("userID"), "foodwrappers": GraphQLVariable("items"), "restaurantid": GraphQLVariable("restaurantID"), "instructions": GraphQLVariable("instructions"), "paymenttype": GraphQLVariable("paymentMethod")], type: .object(PlaceOrder.selections)),
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

public final class RegisterForPushNotificationsMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation RegisterForPushNotifications($userID: ID!, $uuid: String!, $token: String!) {
      didRegister: registerNotify(userid: $userID, uuid: $uuid, token: $token)
    }
    """

  public let operationName = "RegisterForPushNotifications"

  public var userID: GraphQLID
  public var uuid: String
  public var token: String

  public init(userID: GraphQLID, uuid: String, token: String) {
    self.userID = userID
    self.uuid = uuid
    self.token = token
  }

  public var variables: GraphQLMap? {
    return ["userID": userID, "uuid": uuid, "token": token]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("registerNotify", alias: "didRegister", arguments: ["userid": GraphQLVariable("userID"), "uuid": GraphQLVariable("uuid"), "token": GraphQLVariable("token")], type: .scalar(Bool.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(didRegister: Bool? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "didRegister": didRegister])
    }

    public var didRegister: Bool? {
      get {
        return resultMap["didRegister"] as? Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "didRegister")
      }
    }
  }
}

public final class UnregisterFromPushNotificationsMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation UnregisterFromPushNotifications($userID: ID!, $uuid: String!) {
      didUnregister: deleteNotifByUUID(userid: $userID, uuid: $uuid)
    }
    """

  public let operationName = "UnregisterFromPushNotifications"

  public var userID: GraphQLID
  public var uuid: String

  public init(userID: GraphQLID, uuid: String) {
    self.userID = userID
    self.uuid = uuid
  }

  public var variables: GraphQLMap? {
    return ["userID": userID, "uuid": uuid]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteNotifByUUID", alias: "didUnregister", arguments: ["userid": GraphQLVariable("userID"), "uuid": GraphQLVariable("uuid")], type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(didUnregister: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "didUnregister": didUnregister])
    }

    public var didUnregister: String? {
      get {
        return resultMap["didUnregister"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "didUnregister")
      }
    }
  }
}

public final class RegisterUserMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation RegisterUser($firstName: String!, $lastName: String!, $email: String!, $password: String!, $question: String!, $answer: String!) {
      createUser(fname: $firstName, lname: $lastName, email: $email, encryptedpw: $password, usertype: customer, securityq: $question, securitya: $answer) {
        __typename
        success
      }
    }
    """

  public let operationName = "RegisterUser"

  public var firstName: String
  public var lastName: String
  public var email: String
  public var password: String
  public var question: String
  public var answer: String

  public init(firstName: String, lastName: String, email: String, password: String, question: String, answer: String) {
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
    self.password = password
    self.question = question
    self.answer = answer
  }

  public var variables: GraphQLMap? {
    return ["firstName": firstName, "lastName": lastName, "email": email, "password": password, "question": question, "answer": answer]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createUser", arguments: ["fname": GraphQLVariable("firstName"), "lname": GraphQLVariable("lastName"), "email": GraphQLVariable("email"), "encryptedpw": GraphQLVariable("password"), "usertype": "customer", "securityq": GraphQLVariable("question"), "securitya": GraphQLVariable("answer")], type: .object(CreateUser.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createUser: CreateUser? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createUser": createUser.flatMap { (value: CreateUser) -> ResultMap in value.resultMap }])
    }

    public var createUser: CreateUser? {
      get {
        return (resultMap["createUser"] as? ResultMap).flatMap { CreateUser(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createUser")
      }
    }

    public struct CreateUser: GraphQLSelectionSet {
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

public final class UpdateFoodAvailableMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation UpdateFoodAvailable($foodID: ID!, $isAvailable: ID!) {
      didUpdate: updateFoodAvailabilityByFoodID(foodid: $foodID, isavailable: $isAvailable)
    }
    """

  public let operationName = "UpdateFoodAvailable"

  public var foodID: GraphQLID
  public var isAvailable: GraphQLID

  public init(foodID: GraphQLID, isAvailable: GraphQLID) {
    self.foodID = foodID
    self.isAvailable = isAvailable
  }

  public var variables: GraphQLMap? {
    return ["foodID": foodID, "isAvailable": isAvailable]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateFoodAvailabilityByFoodID", alias: "didUpdate", arguments: ["foodid": GraphQLVariable("foodID"), "isavailable": GraphQLVariable("isAvailable")], type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(didUpdate: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "didUpdate": didUpdate])
    }

    public var didUpdate: String? {
      get {
        return resultMap["didUpdate"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "didUpdate")
      }
    }
  }
}

public final class UpdateFoodPriceMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation UpdateFoodPrice($foodID: ID!, $price: ID!) {
      didUpdate: updateFoodPriceByFoodID(foodid: $foodID, price: $price)
    }
    """

  public let operationName = "UpdateFoodPrice"

  public var foodID: GraphQLID
  public var price: GraphQLID

  public init(foodID: GraphQLID, price: GraphQLID) {
    self.foodID = foodID
    self.price = price
  }

  public var variables: GraphQLMap? {
    return ["foodID": foodID, "price": price]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateFoodPriceByFoodID", alias: "didUpdate", arguments: ["foodid": GraphQLVariable("foodID"), "price": GraphQLVariable("price")], type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(didUpdate: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "didUpdate": didUpdate])
    }

    public var didUpdate: String? {
      get {
        return resultMap["didUpdate"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "didUpdate")
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

public final class UpdateRestaurantActiveMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation UpdateRestaurantActive($restaurantID: ID!, $isActive: Boolean!) {
      didUpdate: updateisActiveByRestID(restaurantid: $restaurantID, isactive: $isActive)
    }
    """

  public let operationName = "UpdateRestaurantActive"

  public var restaurantID: GraphQLID
  public var isActive: Bool

  public init(restaurantID: GraphQLID, isActive: Bool) {
    self.restaurantID = restaurantID
    self.isActive = isActive
  }

  public var variables: GraphQLMap? {
    return ["restaurantID": restaurantID, "isActive": isActive]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateisActiveByRestID", alias: "didUpdate", arguments: ["restaurantid": GraphQLVariable("restaurantID"), "isactive": GraphQLVariable("isActive")], type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(didUpdate: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "didUpdate": didUpdate])
    }

    public var didUpdate: String? {
      get {
        return resultMap["didUpdate"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "didUpdate")
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
      GraphQLField("getSecurityQuestionByEmail", alias: "question", arguments: ["email": GraphQLVariable("email")], type: .scalar(String.self)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(question: String? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "question": question])
    }

    public var question: String? {
      get {
        return resultMap["question"] as? String
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

public final class MenusByRestQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query MenusByRest($restID: ID!) {
      getMenusByRestaurantID(restaurantid: $restID) {
        __typename
        menuid
        title
        description
        isactive
        restaurant {
          __typename
          ...SimpleRestaurantDetails
        }
        menuItems {
          __typename
          item {
            __typename
            ...FoodItemDetails
          }
        }
      }
    }
    """

  public let operationName = "MenusByRest"

  public var queryDocument: String { return operationDefinition.appending(SimpleRestaurantDetails.fragmentDefinition).appending(FoodItemDetails.fragmentDefinition) }

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
      GraphQLField("getMenusByRestaurantID", arguments: ["restaurantid": GraphQLVariable("restID")], type: .nonNull(.list(.object(GetMenusByRestaurantId.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getMenusByRestaurantId: [GetMenusByRestaurantId?]) {
      self.init(unsafeResultMap: ["__typename": "Query", "getMenusByRestaurantID": getMenusByRestaurantId.map { (value: GetMenusByRestaurantId?) -> ResultMap? in value.flatMap { (value: GetMenusByRestaurantId) -> ResultMap in value.resultMap } }])
    }

    public var getMenusByRestaurantId: [GetMenusByRestaurantId?] {
      get {
        return (resultMap["getMenusByRestaurantID"] as! [ResultMap?]).map { (value: ResultMap?) -> GetMenusByRestaurantId? in value.flatMap { (value: ResultMap) -> GetMenusByRestaurantId in GetMenusByRestaurantId(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: GetMenusByRestaurantId?) -> ResultMap? in value.flatMap { (value: GetMenusByRestaurantId) -> ResultMap in value.resultMap } }, forKey: "getMenusByRestaurantID")
      }
    }

    public struct GetMenusByRestaurantId: GraphQLSelectionSet {
      public static let possibleTypes = ["Menu"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("menuid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .scalar(String.self)),
        GraphQLField("isactive", type: .nonNull(.scalar(Bool.self))),
        GraphQLField("restaurant", type: .nonNull(.object(Restaurant.selections))),
        GraphQLField("menuItems", type: .nonNull(.list(.object(MenuItem.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(menuid: GraphQLID, title: String, description: String? = nil, isactive: Bool, restaurant: Restaurant, menuItems: [MenuItem?]) {
        self.init(unsafeResultMap: ["__typename": "Menu", "menuid": menuid, "title": title, "description": description, "isactive": isactive, "restaurant": restaurant.resultMap, "menuItems": menuItems.map { (value: MenuItem?) -> ResultMap? in value.flatMap { (value: MenuItem) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var menuid: GraphQLID {
        get {
          return resultMap["menuid"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "menuid")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
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

      public var isactive: Bool {
        get {
          return resultMap["isactive"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "isactive")
        }
      }

      public var restaurant: Restaurant {
        get {
          return Restaurant(unsafeResultMap: resultMap["restaurant"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "restaurant")
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

      public struct Restaurant: GraphQLSelectionSet {
        public static let possibleTypes = ["Restaurant"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(SimpleRestaurantDetails.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, name: String, openingtime: String? = nil, closingtime: String? = nil, isOpen: Bool) {
          self.init(unsafeResultMap: ["__typename": "Restaurant", "id": id, "name": name, "openingtime": openingtime, "closingtime": closingtime, "isOpen": isOpen])
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

          public var simpleRestaurantDetails: SimpleRestaurantDetails {
            get {
              return SimpleRestaurantDetails(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
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
        instructions
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
          ingredientsWrapper: toppings {
            __typename
            ...Toppings
          }
        }
      }
    }
    """

  public let operationName = "OrdersByRest"

  public var queryDocument: String { return operationDefinition.appending(FoodItemDetails.fragmentDefinition).appending(Toppings.fragmentDefinition) }

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
        GraphQLField("instructions", type: .scalar(String.self)),
        GraphQLField("orderitems", type: .nonNull(.list(.nonNull(.object(Orderitem.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(orderid: GraphQLID, ordertype: OrderStatus, timeplaced: String, timecompleted: String? = nil, restaurantid: GraphQLID, instructions: String? = nil, orderitems: [Orderitem]) {
        self.init(unsafeResultMap: ["__typename": "FoodOrder", "orderid": orderid, "ordertype": ordertype, "timeplaced": timeplaced, "timecompleted": timecompleted, "restaurantid": restaurantid, "instructions": instructions, "orderitems": orderitems.map { (value: Orderitem) -> ResultMap in value.resultMap }])
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

      public var instructions: String? {
        get {
          return resultMap["instructions"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "instructions")
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
          GraphQLField("toppings", alias: "ingredientsWrapper", type: .list(.nonNull(.object(IngredientsWrapper.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(orderid: GraphQLID, foodid: GraphQLID, identifier: GraphQLID, item: Item, ingredientsWrapper: [IngredientsWrapper]? = nil) {
          self.init(unsafeResultMap: ["__typename": "OrderItem", "orderid": orderid, "foodid": foodid, "identifier": identifier, "item": item.resultMap, "ingredientsWrapper": ingredientsWrapper.flatMap { (value: [IngredientsWrapper]) -> [ResultMap] in value.map { (value: IngredientsWrapper) -> ResultMap in value.resultMap } }])
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

        public var ingredientsWrapper: [IngredientsWrapper]? {
          get {
            return (resultMap["ingredientsWrapper"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [IngredientsWrapper] in value.map { (value: ResultMap) -> IngredientsWrapper in IngredientsWrapper(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [IngredientsWrapper]) -> [ResultMap] in value.map { (value: IngredientsWrapper) -> ResultMap in value.resultMap } }, forKey: "ingredientsWrapper")
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

        public struct IngredientsWrapper: GraphQLSelectionSet {
          public static let possibleTypes = ["Topping"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(Toppings.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
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

            public var toppings: Toppings {
              get {
                return Toppings(unsafeResultMap: resultMap)
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
        ...RestaurantDetails
      }
    }
    """

  public let operationName = "RestaurantMenus"

  public var queryDocument: String { return operationDefinition.appending(RestaurantDetails.fragmentDefinition).appending(FoodItemDetails.fragmentDefinition) }

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
        GraphQLFragmentSpread(RestaurantDetails.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
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

        public var restaurantDetails: RestaurantDetails {
          get {
            return RestaurantDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
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
        restaurantName: restaurantname
        restaurantId: restaurantid
        timePlaced: timeplaced
        estimatedTimeRemaining: estimatedtime
        status: ordertype
        paymentType: paymenttype
        instructions
        items: orderitems {
          __typename
          item {
            __typename
            ...FoodItemDetails
          }
          ingredientsWrapper: toppings {
            __typename
            ...Toppings
          }
        }
      }
    }
    """

  public let operationName = "UserOrders"

  public var queryDocument: String { return operationDefinition.appending(FoodItemDetails.fragmentDefinition).appending(Toppings.fragmentDefinition) }

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
        GraphQLField("restaurantname", alias: "restaurantName", type: .scalar(String.self)),
        GraphQLField("restaurantid", alias: "restaurantId", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("timeplaced", alias: "timePlaced", type: .nonNull(.scalar(String.self))),
        GraphQLField("estimatedtime", alias: "estimatedTimeRemaining", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("ordertype", alias: "status", type: .nonNull(.scalar(OrderStatus.self))),
        GraphQLField("paymenttype", alias: "paymentType", type: .nonNull(.scalar(PaymentType.self))),
        GraphQLField("instructions", type: .scalar(String.self)),
        GraphQLField("orderitems", alias: "items", type: .nonNull(.list(.nonNull(.object(Item.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, restaurantName: String? = nil, restaurantId: GraphQLID, timePlaced: String, estimatedTimeRemaining: GraphQLID, status: OrderStatus, paymentType: PaymentType, instructions: String? = nil, items: [Item]) {
        self.init(unsafeResultMap: ["__typename": "FoodOrder", "id": id, "restaurantName": restaurantName, "restaurantId": restaurantId, "timePlaced": timePlaced, "estimatedTimeRemaining": estimatedTimeRemaining, "status": status, "paymentType": paymentType, "instructions": instructions, "items": items.map { (value: Item) -> ResultMap in value.resultMap }])
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

      public var restaurantName: String? {
        get {
          return resultMap["restaurantName"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "restaurantName")
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

      public var estimatedTimeRemaining: GraphQLID {
        get {
          return resultMap["estimatedTimeRemaining"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "estimatedTimeRemaining")
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

      public var paymentType: PaymentType {
        get {
          return resultMap["paymentType"]! as! PaymentType
        }
        set {
          resultMap.updateValue(newValue, forKey: "paymentType")
        }
      }

      public var instructions: String? {
        get {
          return resultMap["instructions"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "instructions")
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
          GraphQLField("toppings", alias: "ingredientsWrapper", type: .list(.nonNull(.object(IngredientsWrapper.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(item: Item, ingredientsWrapper: [IngredientsWrapper]? = nil) {
          self.init(unsafeResultMap: ["__typename": "OrderItem", "item": item.resultMap, "ingredientsWrapper": ingredientsWrapper.flatMap { (value: [IngredientsWrapper]) -> [ResultMap] in value.map { (value: IngredientsWrapper) -> ResultMap in value.resultMap } }])
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

        public var ingredientsWrapper: [IngredientsWrapper]? {
          get {
            return (resultMap["ingredientsWrapper"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [IngredientsWrapper] in value.map { (value: ResultMap) -> IngredientsWrapper in IngredientsWrapper(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [IngredientsWrapper]) -> [ResultMap] in value.map { (value: IngredientsWrapper) -> ResultMap in value.resultMap } }, forKey: "ingredientsWrapper")
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

        public struct IngredientsWrapper: GraphQLSelectionSet {
          public static let possibleTypes = ["Topping"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(Toppings.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
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

            public var toppings: Toppings {
              get {
                return Toppings(unsafeResultMap: resultMap)
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

public final class MenusUpdatedSubscription: GraphQLSubscription {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    subscription MenusUpdated {
      menuUpdated {
        __typename
        ...RestaurantDetails
      }
    }
    """

  public let operationName = "MenusUpdated"

  public var queryDocument: String { return operationDefinition.appending(RestaurantDetails.fragmentDefinition).appending(FoodItemDetails.fragmentDefinition) }

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("menuUpdated", type: .nonNull(.list(.object(MenuUpdated.selections)))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(menuUpdated: [MenuUpdated?]) {
      self.init(unsafeResultMap: ["__typename": "Subscription", "menuUpdated": menuUpdated.map { (value: MenuUpdated?) -> ResultMap? in value.flatMap { (value: MenuUpdated) -> ResultMap in value.resultMap } }])
    }

    public var menuUpdated: [MenuUpdated?] {
      get {
        return (resultMap["menuUpdated"] as! [ResultMap?]).map { (value: ResultMap?) -> MenuUpdated? in value.flatMap { (value: ResultMap) -> MenuUpdated in MenuUpdated(unsafeResultMap: value) } }
      }
      set {
        resultMap.updateValue(newValue.map { (value: MenuUpdated?) -> ResultMap? in value.flatMap { (value: MenuUpdated) -> ResultMap in value.resultMap } }, forKey: "menuUpdated")
      }
    }

    public struct MenuUpdated: GraphQLSelectionSet {
      public static let possibleTypes = ["Restaurant"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(RestaurantDetails.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
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

        public var restaurantDetails: RestaurantDetails {
          get {
            return RestaurantDetails(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
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
        instructions
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
          ingredientsWrapper: toppings {
            __typename
            ingredient: statictopping {
              __typename
              id: toppingid
              name: displayname
            }
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
        GraphQLField("instructions", type: .scalar(String.self)),
        GraphQLField("orderitems", type: .nonNull(.list(.nonNull(.object(Orderitem.selections))))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(orderid: GraphQLID, ordertype: OrderStatus, timeplaced: String, restaurantid: GraphQLID, instructions: String? = nil, orderitems: [Orderitem]) {
        self.init(unsafeResultMap: ["__typename": "FoodOrder", "orderid": orderid, "ordertype": ordertype, "timeplaced": timeplaced, "restaurantid": restaurantid, "instructions": instructions, "orderitems": orderitems.map { (value: Orderitem) -> ResultMap in value.resultMap }])
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

      public var instructions: String? {
        get {
          return resultMap["instructions"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "instructions")
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
          GraphQLField("toppings", alias: "ingredientsWrapper", type: .list(.nonNull(.object(IngredientsWrapper.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(orderid: GraphQLID, foodid: GraphQLID, identifier: GraphQLID, item: Item, ingredientsWrapper: [IngredientsWrapper]? = nil) {
          self.init(unsafeResultMap: ["__typename": "OrderItem", "orderid": orderid, "foodid": foodid, "identifier": identifier, "item": item.resultMap, "ingredientsWrapper": ingredientsWrapper.flatMap { (value: [IngredientsWrapper]) -> [ResultMap] in value.map { (value: IngredientsWrapper) -> ResultMap in value.resultMap } }])
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

        public var ingredientsWrapper: [IngredientsWrapper]? {
          get {
            return (resultMap["ingredientsWrapper"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [IngredientsWrapper] in value.map { (value: ResultMap) -> IngredientsWrapper in IngredientsWrapper(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [IngredientsWrapper]) -> [ResultMap] in value.map { (value: IngredientsWrapper) -> ResultMap in value.resultMap } }, forKey: "ingredientsWrapper")
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

        public struct IngredientsWrapper: GraphQLSelectionSet {
          public static let possibleTypes = ["Topping"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("statictopping", alias: "ingredient", type: .object(Ingredient.selections)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(ingredient: Ingredient? = nil) {
            self.init(unsafeResultMap: ["__typename": "Topping", "ingredient": ingredient.flatMap { (value: Ingredient) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var ingredient: Ingredient? {
            get {
              return (resultMap["ingredient"] as? ResultMap).flatMap { Ingredient(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "ingredient")
            }
          }

          public struct Ingredient: GraphQLSelectionSet {
            public static let possibleTypes = ["StaticTopping"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("toppingid", alias: "id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("displayname", alias: "name", type: .nonNull(.scalar(String.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: GraphQLID, name: String) {
              self.init(unsafeResultMap: ["__typename": "StaticTopping", "id": id, "name": name])
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
          }
        }
      }
    }
  }
}

public struct SimpleRestaurantDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition =
    """
    fragment SimpleRestaurantDetails on Restaurant {
      __typename
      id: restaurantid
      name: displayname
      openingtime
      closingtime
      isOpen: isactive
    }
    """

  public static let possibleTypes = ["Restaurant"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("restaurantid", alias: "id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("displayname", alias: "name", type: .nonNull(.scalar(String.self))),
    GraphQLField("openingtime", type: .scalar(String.self)),
    GraphQLField("closingtime", type: .scalar(String.self)),
    GraphQLField("isactive", alias: "isOpen", type: .nonNull(.scalar(Bool.self))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String, openingtime: String? = nil, closingtime: String? = nil, isOpen: Bool) {
    self.init(unsafeResultMap: ["__typename": "Restaurant", "id": id, "name": name, "openingtime": openingtime, "closingtime": closingtime, "isOpen": isOpen])
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

  public var openingtime: String? {
    get {
      return resultMap["openingtime"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "openingtime")
    }
  }

  public var closingtime: String? {
    get {
      return resultMap["closingtime"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "closingtime")
    }
  }

  public var isOpen: Bool {
    get {
      return resultMap["isOpen"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "isOpen")
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
      inStock: isavailable
      ingredients: toppings {
        __typename
        id: toppingid
        name: displayname
      }
    }
    """

  public static let possibleTypes = ["Food"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("foodid", alias: "id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("displayname", alias: "name", type: .nonNull(.scalar(String.self))),
    GraphQLField("price", type: .nonNull(.scalar(Double.self))),
    GraphQLField("isavailable", alias: "inStock", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("toppings", alias: "ingredients", type: .list(.nonNull(.object(Ingredient.selections)))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String, price: Double, inStock: Bool, ingredients: [Ingredient]? = nil) {
    self.init(unsafeResultMap: ["__typename": "Food", "id": id, "name": name, "price": price, "inStock": inStock, "ingredients": ingredients.flatMap { (value: [Ingredient]) -> [ResultMap] in value.map { (value: Ingredient) -> ResultMap in value.resultMap } }])
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

  public var inStock: Bool {
    get {
      return resultMap["inStock"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "inStock")
    }
  }

  public var ingredients: [Ingredient]? {
    get {
      return (resultMap["ingredients"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Ingredient] in value.map { (value: ResultMap) -> Ingredient in Ingredient(unsafeResultMap: value) } }
    }
    set {
      resultMap.updateValue(newValue.flatMap { (value: [Ingredient]) -> [ResultMap] in value.map { (value: Ingredient) -> ResultMap in value.resultMap } }, forKey: "ingredients")
    }
  }

  public struct Ingredient: GraphQLSelectionSet {
    public static let possibleTypes = ["StaticTopping"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("toppingid", alias: "id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("displayname", alias: "name", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, name: String) {
      self.init(unsafeResultMap: ["__typename": "StaticTopping", "id": id, "name": name])
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
  }
}

public struct RestaurantDetails: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition =
    """
    fragment RestaurantDetails on Restaurant {
      __typename
      id: restaurantid
      name: displayname
      isActive: isactive
      openingTime: openingtime
      closingTime: closingtime
      menu {
        __typename
        isActive: isactive
        menuItems {
          __typename
          item {
            __typename
            imageUrl: imageurl
            ...FoodItemDetails
          }
        }
      }
    }
    """

  public static let possibleTypes = ["Restaurant"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("restaurantid", alias: "id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("displayname", alias: "name", type: .nonNull(.scalar(String.self))),
    GraphQLField("isactive", alias: "isActive", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("openingtime", alias: "openingTime", type: .scalar(String.self)),
    GraphQLField("closingtime", alias: "closingTime", type: .scalar(String.self)),
    GraphQLField("menu", type: .nonNull(.list(.object(Menu.selections)))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String, isActive: Bool, openingTime: String? = nil, closingTime: String? = nil, menu: [Menu?]) {
    self.init(unsafeResultMap: ["__typename": "Restaurant", "id": id, "name": name, "isActive": isActive, "openingTime": openingTime, "closingTime": closingTime, "menu": menu.map { (value: Menu?) -> ResultMap? in value.flatMap { (value: Menu) -> ResultMap in value.resultMap } }])
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

  public var isActive: Bool {
    get {
      return resultMap["isActive"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "isActive")
    }
  }

  public var openingTime: String? {
    get {
      return resultMap["openingTime"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "openingTime")
    }
  }

  public var closingTime: String? {
    get {
      return resultMap["closingTime"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "closingTime")
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
          GraphQLField("imageurl", alias: "imageUrl", type: .nonNull(.scalar(String.self))),
          GraphQLFragmentSpread(FoodItemDetails.self),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var imageUrl: String {
          get {
            return resultMap["imageUrl"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "imageUrl")
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

public struct Toppings: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition =
    """
    fragment Toppings on Topping {
      __typename
      ingredient: statictopping {
        __typename
        id: toppingid
        name: displayname
      }
    }
    """

  public static let possibleTypes = ["Topping"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("statictopping", alias: "ingredient", type: .object(Ingredient.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(ingredient: Ingredient? = nil) {
    self.init(unsafeResultMap: ["__typename": "Topping", "ingredient": ingredient.flatMap { (value: Ingredient) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  public var ingredient: Ingredient? {
    get {
      return (resultMap["ingredient"] as? ResultMap).flatMap { Ingredient(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "ingredient")
    }
  }

  public struct Ingredient: GraphQLSelectionSet {
    public static let possibleTypes = ["StaticTopping"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("toppingid", alias: "id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("displayname", alias: "name", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(id: GraphQLID, name: String) {
      self.init(unsafeResultMap: ["__typename": "StaticTopping", "id": id, "name": name])
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
  }
}
