//
//  NetworkRequest.swift
//  Users-Miho
//
//  Created by Mac Mini 2 on 9/8/20.
//  Copyright © 2020 Miho Puno. All rights reserved.
//

import Foundation
import UIKit
import CoreData

typealias Completion<T> = (Swift.Result<(T), Error>) -> Void
typealias Parameters = Dictionary<String, Any>
typealias HTTPHeaders = Dictionary<String, String>

enum HTTPMethod : String {
    
    case GET = "get"
    case POST = "post"
    case PUT = "put"
    case DELETE = "delete"
}

class NetworkRequest {
    
    private var sessionConfiguration : URLSessionConfiguration
    private var urlSession : URLSession

    public static let shared = NetworkRequest()
    var retries = 0
    
    init() {
        self.sessionConfiguration = URLSessionConfiguration.default
        self.urlSession = URLSession(configuration: sessionConfiguration)
    }
    
    private func request<T: Codable>(url: URL,
                                     httpMethod: HTTPMethod,
                                     timeout: TimeInterval,
                                     type: AppEndpoint<T>,
                                     handler: @escaping Completion<T>) {
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: timeout)
        request.httpMethod = httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        self.urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    handler(.failure(error))
                    return
                }

                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let context = type.managedObjectContext {
                    jsonDecoder.userInfo[CodingUserInfoKey.managedObjectContext!] = context
                }
                guard let data = data else { return }
                do {
                    let decoded = try jsonDecoder.decode(T.self, from: data)
                    handler(.success(decoded))
                } catch (let error) {
                    handler(.failure(error))
                }
            }
        }.resume()
    }
}

extension NetworkRequest {
    
    /// # Generic #
    /// T: Represents Codable Model
    /// - parameter type: SZEndpoint<T> contains url, httpMethod, paramaters,, encoding, headers, and headers.
    public func request<T: Codable>(type: AppEndpoint<T>, handler: @escaping Completion<T>) {
        self.request(url: type.url,
                     httpMethod: type.httpMethod,
                     timeout: type.timeout,
//                     dynamicKey: type.dynamicKey,
                     type: type,
                     handler: handler)
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
