//
//  Girl.swift
//  BigGirl
//
//  Created by 罗诗朋 on 2021/8/8.
//

import Foundation
struct GirlList:Decodable {
    let data:[Girl]
//    let page:Int
//    let page_count:Int
//    let status:Int
//    let total_counts:Int
}
struct Girl: Decodable {
    let _id:Int
    let author:String
    let category:String
    let cratedAt:String
    let desc:String
    let images:[String]
    let likeCounts:Int
    let publishedAt:String
    let stars:Int
    let title:String
    let type:String
    let url: String
    let views:Int
    
}
