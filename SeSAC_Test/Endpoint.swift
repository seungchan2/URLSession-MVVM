//
//  Endpoint.swift
//  SeSAC_Test
//
//  Created by 김승찬 on 2021/12/29.
//

import Foundation

enum Endpoint {
    case signup
    case login
    case boards
    case boardDetail(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signup:
            return .makeEndpoint("auth/local/register")
        case .login:
            return .makeEndpoint("auth/local")
        case .boards:
            return .makeEndpoint("boards")
        case .boardDetail(let id):
            return .makeEndpoint("boards/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com/"
    
    static func makeEndpoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
            session.dataTask(endpoint) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failed)
                    return
                    
                }
                guard let data = data else {
                    completion(nil, .noData)
                    return
                    
                }
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidData)
                    return
                }
                
                guard response.statusCode == 200 else {
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let userData = try decoder.decode(T.self, from: data)
                    completion(userData, nil) //성공적으로 통신에 성공한 경우
                } catch {
                    completion(nil, .invalidData)
                }
            }
        }
    }
}
