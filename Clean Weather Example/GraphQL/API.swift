//  This file was automatically generated and should not be edited.

import Apollo

public enum _ModelMutationType: RawRepresentable, Equatable, Hashable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case created
  case updated
  case deleted
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "CREATED": self = .created
      case "UPDATED": self = .updated
      case "DELETED": self = .deleted
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .created: return "CREATED"
      case .updated: return "UPDATED"
      case .deleted: return "DELETED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: _ModelMutationType, rhs: _ModelMutationType) -> Bool {
    switch (lhs, rhs) {
      case (.created, .created): return true
      case (.updated, .updated): return true
      case (.deleted, .deleted): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public final class GetAllPairsQuery: GraphQLQuery {
  public let operationDefinition =
    "query GetAllPairs {\n  allPairs {\n    __typename\n    id\n    first\n    second\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allPairs", type: .nonNull(.list(.nonNull(.object(AllPair.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allPairs: [AllPair]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allPairs": allPairs.map { (value: AllPair) -> ResultMap in value.resultMap }])
    }

    public var allPairs: [AllPair] {
      get {
        return (resultMap["allPairs"] as! [ResultMap]).map { (value: ResultMap) -> AllPair in AllPair(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllPair) -> ResultMap in value.resultMap }, forKey: "allPairs")
      }
    }

    public struct AllPair: GraphQLSelectionSet {
      public static let possibleTypes = ["Pair"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("first", type: .nonNull(.scalar(String.self))),
        GraphQLField("second", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, first: String, second: String) {
        self.init(unsafeResultMap: ["__typename": "Pair", "id": id, "first": first, "second": second])
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

      public var first: String {
        get {
          return resultMap["first"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "first")
        }
      }

      public var second: String {
        get {
          return resultMap["second"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "second")
        }
      }
    }
  }
}

public final class CreatePairMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation CreatePair($first: String!, $second: String!) {\n  createPair(first: $first, second: $second) {\n    __typename\n    id\n  }\n}"

  public var first: String
  public var second: String

  public init(first: String, second: String) {
    self.first = first
    self.second = second
  }

  public var variables: GraphQLMap? {
    return ["first": first, "second": second]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("createPair", arguments: ["first": GraphQLVariable("first"), "second": GraphQLVariable("second")], type: .object(CreatePair.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(createPair: CreatePair? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "createPair": createPair.flatMap { (value: CreatePair) -> ResultMap in value.resultMap }])
    }

    public var createPair: CreatePair? {
      get {
        return (resultMap["createPair"] as? ResultMap).flatMap { CreatePair(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "createPair")
      }
    }

    public struct CreatePair: GraphQLSelectionSet {
      public static let possibleTypes = ["Pair"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID) {
        self.init(unsafeResultMap: ["__typename": "Pair", "id": id])
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
    }
  }
}

public final class UpdatePairMutation: GraphQLMutation {
  public let operationDefinition =
    "mutation UpdatePair($id: ID!, $first: String!, $second: String!) {\n  updatePair(id: $id, first: $first, second: $second) {\n    __typename\n    id\n    first\n    second\n  }\n}"

  public var id: GraphQLID
  public var first: String
  public var second: String

  public init(id: GraphQLID, first: String, second: String) {
    self.id = id
    self.first = first
    self.second = second
  }

  public var variables: GraphQLMap? {
    return ["id": id, "first": first, "second": second]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updatePair", arguments: ["id": GraphQLVariable("id"), "first": GraphQLVariable("first"), "second": GraphQLVariable("second")], type: .object(UpdatePair.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updatePair: UpdatePair? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updatePair": updatePair.flatMap { (value: UpdatePair) -> ResultMap in value.resultMap }])
    }

    public var updatePair: UpdatePair? {
      get {
        return (resultMap["updatePair"] as? ResultMap).flatMap { UpdatePair(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updatePair")
      }
    }

    public struct UpdatePair: GraphQLSelectionSet {
      public static let possibleTypes = ["Pair"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        GraphQLField("first", type: .nonNull(.scalar(String.self))),
        GraphQLField("second", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, first: String, second: String) {
        self.init(unsafeResultMap: ["__typename": "Pair", "id": id, "first": first, "second": second])
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

      public var first: String {
        get {
          return resultMap["first"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "first")
        }
      }

      public var second: String {
        get {
          return resultMap["second"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "second")
        }
      }
    }
  }
}

public final class PairMutationSubscription: GraphQLSubscription {
  public let operationDefinition =
    "subscription PairMutation {\n  Pair(filter: {mutation_in: [UPDATED, CREATED, DELETED]}) {\n    __typename\n    node {\n      __typename\n      id\n      first\n      second\n    }\n    mutation\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Subscription"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("Pair", arguments: ["filter": ["mutation_in": ["UPDATED", "CREATED", "DELETED"]]], type: .object(Pair.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(pair: Pair? = nil) {
      self.init(unsafeResultMap: ["__typename": "Subscription", "Pair": pair.flatMap { (value: Pair) -> ResultMap in value.resultMap }])
    }

    public var pair: Pair? {
      get {
        return (resultMap["Pair"] as? ResultMap).flatMap { Pair(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "Pair")
      }
    }

    public struct Pair: GraphQLSelectionSet {
      public static let possibleTypes = ["PairSubscriptionPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("node", type: .object(Node.selections)),
        GraphQLField("mutation", type: .nonNull(.scalar(_ModelMutationType.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(node: Node? = nil, mutation: _ModelMutationType) {
        self.init(unsafeResultMap: ["__typename": "PairSubscriptionPayload", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }, "mutation": mutation])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var node: Node? {
        get {
          return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "node")
        }
      }

      public var mutation: _ModelMutationType {
        get {
          return resultMap["mutation"]! as! _ModelMutationType
        }
        set {
          resultMap.updateValue(newValue, forKey: "mutation")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes = ["Pair"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("first", type: .nonNull(.scalar(String.self))),
          GraphQLField("second", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, first: String, second: String) {
          self.init(unsafeResultMap: ["__typename": "Pair", "id": id, "first": first, "second": second])
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

        public var first: String {
          get {
            return resultMap["first"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "first")
          }
        }

        public var second: String {
          get {
            return resultMap["second"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "second")
          }
        }
      }
    }
  }
}