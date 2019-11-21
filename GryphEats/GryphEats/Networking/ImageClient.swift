//
//  ImageClient.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-20.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ImageClient

final class ImageClient {
    
    // MARK: ImageError
    
    enum ImageError: Error {
        case invalidURL
        case decodingError
    }
    
    // MARK: Internal
    
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, ImageError>) -> Void) {
        if let cachedImage = ImageCache.shared.image(for: url.absoluteString) {
            completion(.success(cachedImage))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidURL))
                return
            }
            
            guard let image = UIImage(data: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            ImageCache.shared.save(image: image, for: url.absoluteString)
            completion(.success(image))
        }
        
        task.resume()
    }
}

// MARK: - ImageCache

// https://stackoverflow.com/a/45183939

private final class ImageCache {
    
    // MARK: Lifecycle
    
    init() {}
    
    // MARK: Internal

    static let shared = ImageCache()

    func image(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    func save(image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    // MARK: Private
    
    private let cache = NSCache<NSString, UIImage>()
    
}
