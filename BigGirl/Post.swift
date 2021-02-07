//
//  Girl.swift
//  BigGirl
//
//  Created by 罗诗朋 on 2021/2/7.
//

import Foundation

struct PostList :Codable {
    var list:[PostBean]
}

struct PostBean :Codable ,Identifiable{
    let id:Int
    let avatar:String
    let vip:Bool
    let name:String
    let date:String
    var isFollowed:Bool
    let text:String
    let images:[String]
    var commentCount:Int
    var likeCount:Int
    var isLiked:Bool
    
  
}
