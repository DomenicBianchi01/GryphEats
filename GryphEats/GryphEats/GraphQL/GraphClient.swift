//
//  GraphClient.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Apollo
import ApolloWebSocket
import Foundation

// MARK: - GraphClient

final class GraphClient {
    
    // MARK: ApolloError
    
    enum ApolloError: Error {
        case noData
        case other(Error)
    }
    
    // MARK: Internal
    
    static let shared = GraphClient()
    
    func fetch<Query: GraphQLQuery>(
        query: Query,
        completion: @escaping (Result<Query.Data, ApolloError>) -> Void)
    {
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
        completion: @escaping (Result<Subscription.Data, ApolloError>) -> Void) -> Cancellable
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
    
    private lazy var webSocketTransport = WebSocketTransport(
        request: URLRequest(
            url: URL(string: "ws://131.104.48.253:4000/graphql")!))
    
    private lazy var httpTransport = HTTPNetworkTransport(url: URL(string: "http://131.104.48.253:4000")!)
    
    private lazy var splitNetworkTransport = SplitNetworkTransport(
        httpNetworkTransport: httpTransport,
        webSocketNetworkTransport: webSocketTransport)
    
    private lazy var client = ApolloClient(networkTransport: splitNetworkTransport)
    
}
