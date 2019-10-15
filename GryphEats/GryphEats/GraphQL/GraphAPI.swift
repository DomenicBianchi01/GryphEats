//  This file was automatically generated and should not be edited.

import Apollo

public final class RestaurantsQuery: GraphQLQuery {
  /// query Restaurants {
  ///   restaurants {
  ///     __typename
  ///     restaurantid
  ///     displayname
  ///   }
  /// }
  public let operationDefinition =
    "query Restaurants { restaurants { __typename restaurantid displayname } }"

  public let operationName = "Restaurants"

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
        GraphQLField("restaurantid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("displayname", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(restaurantid: GraphQLID, displayname: String) {
        self.init(unsafeResultMap: ["__typename": "Restaurant", "restaurantid": restaurantid, "displayname": displayname])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var displayname: String {
        get {
          return resultMap["displayname"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "displayname")
        }
      }
    }
  }
}
