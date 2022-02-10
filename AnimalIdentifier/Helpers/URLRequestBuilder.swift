//
//  URLRequestBuilder.swift
//  AnimalIdentifier
//
//  Created by Kirill Presnyakov on 09.02.2022.
//

import Foundation

final class URLRequestBuilder {
    enum URLRequestError: Error {
        case WrongURL
    }
    
    let stringURL: String
    let headers: [String: String]
    let method: String
    
    init(
        stringURL: String,
        headers: [String: String],
        method: String = "GET"
    ) {
        self.stringURL = stringURL
        self.headers = headers
        self.method = method
    }
    
    func makeRequest() throws -> URLRequest {
        guard let url = URL(string: stringURL) else { throw URLRequestError.WrongURL }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
