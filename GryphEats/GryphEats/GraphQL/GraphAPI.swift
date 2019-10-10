//  This file was automatically generated and should not be edited.

import Apollo

public final class ResturantsQuery: GraphQLQuery {
  /// query Resturants {
  ///   foods {
  ///     __typename
  ///     foodid
  ///     displayname
  ///   }
  /// }
  public let operationDefinition =
    "query Resturants { foods { __typename foodid displayname } }"

  public let operationName = "Resturants"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("foods", type: .nonNull(.list(.nonNull(.object(Food.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(foods: [Food]) {
      self.init(unsafeResultMap: ["__typename": "Query", "foods": foods.map { (value: Food) -> ResultMap in value.resultMap }])
    }

    public var foods: [Food] {
      get {
        return (resultMap["foods"] as! [ResultMap]).map { (value: ResultMap) -> Food in Food(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Food) -> ResultMap in value.resultMap }, forKey: "foods")
      }
    }

    public struct Food: GraphQLSelectionSet {
      public static let possibleTypes = ["Food"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("foodid", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("displayname", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(foodid: GraphQLID, displayname: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Food", "foodid": foodid, "displayname": displayname])
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
    }
  }
}
