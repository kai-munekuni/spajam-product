//
//  APIClient.swift
//  spajam-product
//
//  Created by 張翔 on 2020/10/10.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift

enum APIClient {
    private static let baseUrl = "https://974fcda7d46f.ngrok.io/"
    
    static func request<Body: Encodable, Response: Decodable>(_ method: HTTPMethod, path: String, body: Body, response: Response.Type) -> Observable<Response> {
        guard let url = URL(string: baseUrl + path) else {
            return Observable.error(AppError.apiError)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        do {
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let jsonBody = try encoder.encode(body)
            request.httpBody = jsonBody
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch {
            return Observable<Response>.error(AppError.apiError)
        }
        print(request)
        return RxAlamofire.request(request)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .data()
            .map {
                let decoder: JSONDecoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(Response.self, from: $0)
            }
    }
}
