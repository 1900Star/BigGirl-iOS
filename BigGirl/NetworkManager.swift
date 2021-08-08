//
//  NetworkManager.swift
//  BigGirl
//
//  Created by 罗诗朋 on 2021/8/7.
//

import Foundation
import Alamofire


typealias NetwrokRequestResult = Result<Data,Error>
typealias NetworkRequestCompletion  = (NetwrokRequestResult) -> Void
private let BaseUrl = "https://raw.githubusercontent.com/xiaoyouxinqing/PostDemo/master/PostDemo/Resources/"
private let GankHostUrl = "https://gank.io/api/v2/"
class NetworkManager {

    static let shared = NetworkManager()
    
    var commonHeaders: HTTPHeaders { ["user_id":"123"] }
    
   
    // 获取妹子列表
    @discardableResult
    func requestGetGirl(path: String,parameter: Parameters?,completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(GankHostUrl + path,
                   parameters: parameter,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseData { response in
//                let responseModel = BaseResponseModel.deserialize(from: response) ?? BaseResponseModel()
//                for girl in responseModel.data
                
                print(GankHostUrl + path)
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(errno): completion(self.handleError(errno))
                }
            }
        
    }
    
    
    @discardableResult
    func requestGet(path: String,parameter: Parameters?,completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(BaseUrl + path,
                   parameters: parameter,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15 })
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(errno): completion(self.handleError(errno))
                }
            }
        
    }
    @discardableResult
    func requestPost(path: String,parameters: Parameters?,completion: @escaping NetworkRequestCompletion)-> DataRequest {
        
        AF.request(BaseUrl + path,method: .post,parameters: parameters,
                   encoding: JSONEncoding.prettyPrinted,
                   headers: commonHeaders
                   ,requestModifier: {$0.timeoutInterval = 15})
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(errno): completion(self.handleError(errno))
                }
            }
    }
    
    private func handleError(_ error: AFError) -> NetwrokRequestResult {
        if let underlyingError = error.underlyingError {
            let nserro = underlyingError as NSError
            let errorCode = nserro.code
            if errorCode == NSURLErrorNotConnectedToInternet || errorCode == NSURLErrorTimedOut || errorCode == NSURLErrorInternationalRoamingOff ||
                errorCode == NSURLErrorDataNotAllowed || errorCode == NSURLErrorCannotFindHost ||
            errorCode == NSURLErrorCannotConnectToHost || errorCode == NSURLErrorCannotConnectToHost {
                var userInfo = nserro.userInfo
                userInfo[NSLocalizedDescriptionKey] = "网络连接有问题哈～"
                let currentError = NSError(domain: nserro.domain, code: errorCode, userInfo: userInfo)
                return .failure(currentError)
            }
        }
        return .failure(error)
    }
    
}
