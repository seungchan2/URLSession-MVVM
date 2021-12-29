//
//  APIService.swift
//  1227
//
//  Created by 김승찬 on 2021/12/27.
//

import Foundation

enum APIError: Error {
    case invalid
    case noData
    case failed
    case invalidData
}

class APIService {
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        //GET이 아닌 POST로 통신해야 된다.
        var request = URLRequest(url: Endpoint.login.url)
        request.httpMethod = "POST"
        //string -> Data , Didc -> Json 두 가지 방법존재
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
        
    }
    
    
    static func lotto(number: Int, completion: @escaping (Lotto?, APIError?) -> Void) {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
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
                    let userData = try decoder.decode(Lotto.self, from: data)
                    completion(userData, nil) //성공적으로 통신에 성공한 경우
                } catch {
                    completion(nil, .invalidData)
                }
            }
          
        }.resume()
        
    }
    
    static func person(text: String, page: Int, completion: @escaping (Person?, APIError?) -> Void) {
        
        let scheme = "https"
        let host = "api.themoviedb.org"
        let path = "/3/search/person"
        let language = "ko-KR"
        let key = "26f86956890fd5c2c8e65d242970dc30"
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "api_key", value: key),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "language", value: language)
        ]
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            
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
                    let userData = try decoder.decode(Person.self, from: data)
                    completion(userData, nil) //성공적으로 통신에 성공한 경우
                } catch {
                    completion(nil, .invalidData)
                }
            }
          
        }.resume()
        
    }
    
}
