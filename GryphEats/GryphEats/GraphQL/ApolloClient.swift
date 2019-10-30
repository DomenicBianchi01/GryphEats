//
//  ApolloClient.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Apollo
import ApolloWebSocket
import Foundation

// MARK: - Apollo

class Apollo {
    
    // MARK: ApolloError
    
    enum ApolloError: Error {
        case noData
        case other(Error)
    }
    
    // MARK: Internal
    
    private lazy var webSocketTransport: WebSocketTransport = {
      let url = URL(string: "ws://131.104.48.253:4000/graphql")!
      let request = URLRequest(url: url)
      return WebSocketTransport(request: request)
    }()
    
    /// An HTTP transport to use for queries and mutations
    private lazy var httpTransport: HTTPNetworkTransport = {
      let url = URL(string: "http://131.104.48.253:4000")!
      return HTTPNetworkTransport(url: url)
    }()
    
    private lazy var splitNetworkTransport = SplitNetworkTransport(
      httpNetworkTransport: self.httpTransport,
      webSocketNetworkTransport: self.webSocketTransport
    )
    
    private(set) lazy var client = ApolloClient(networkTransport: self.splitNetworkTransport)
    
    static let shared = Apollo()
    
    func fetch<Query: GraphQLQuery>(query: Query, completion: @escaping (Result<Query.Data, ApolloError>) -> Void) {
        client.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely) { result in
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data else {
                    completion(.failure(.noData))
                    return
                }
                
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.other(error)))
            }
        }
    }

    func perform<Mutation: GraphQLMutation>(
        mutation: Mutation,
        completion: @escaping (Result<Mutation.Data, ApolloError>) -> Void)
    {
        client.perform(mutation: mutation) { result in
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data else {
                    completion(.failure(.noData))
                    return
                }
                
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.other(error)))
            }
        }
    }
    
    func subscribe<Subscription: GraphQLSubscription>(
        subscription: Subscription,
        completion: @escaping (Result<Subscription.Data, ApolloError>) -> Void)
    {
        client.subscribe(subscription: subscription) { result in
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data else {
                    completion(.failure(.noData))
                    return
                }
                
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.other(error)))
            }
        }
    }
    
    // MARK: Private
    
//    private lazy var client = ApolloClient(url: URL(string: "http://131.104.48.253:4000")!)
//    
}
