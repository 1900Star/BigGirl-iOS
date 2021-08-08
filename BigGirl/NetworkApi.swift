//
//  NetworkApi.swift
//  Pods
//
//  Created by 罗诗朋 on 2021/8/7.
//

import Foundation
private let urlCommonts = "PostListData_recommend_1.json"
private let urlHot = "PostListData_hot_1.json"

class NetworkApi {
    
    // GankGirl列表
    static func getGrilList(url: String,completion: @escaping (Result<GirlList,Error>) -> Void ) {
        
        NetworkManager.shared.requestGetGirl(path: url, parameter: nil) { result in
            switch result {
            case let .success(data):
            print("Aaaaaaaa")
                print(data.count)
                let parseResult: Result<GirlList,Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            
            }
        }
    }
    
 
    // 评论列表
    static func recommentPostList(completion: @escaping (Result<PostList,Error>) -> Void ) {
        
        NetworkManager.shared.requestGet(path: urlCommonts, parameter: nil) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<PostList,Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            
            }
        }
    }
    // 热闹列表
    static func hotPostList(completion: @escaping (Result<PostList,Error>) -> Void ){
        
        NetworkManager.shared.requestGet(path: urlHot, parameter: nil) { result in
            switch result {
            case let .success(data):
                let parseResult: Result<PostList,Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            
            }
        }
    }
    // 上传数据
    static func createPost(text: String,completion: @escaping (Result<PostBean,Error>) -> Void){
        
        NetworkManager.shared.requestPost(path: "createpost", parameters: ["text":text]) { result in
            
            switch result {
            case let .success(data):
                let parseResult: Result<PostBean,Error> = self.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            
            }
        }
    }
    
    // 解析数据
    private static func parseData<T: Decodable>(_ data: Data)-> Result <T,Error>{
        guard let decodeData = try? JSONDecoder().decode(T.self, from: data) else {
            let error = NSError(domain: "NetworkApiError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not parse data"])
            
            return .failure(error)
        }
        return .success(decodeData)
    }
    
}

