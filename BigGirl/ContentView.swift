//
//  ContentView.swift
//  BigGirl
//
//  Created by 罗诗朋 on 2021/2/7.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""
    var body: some View {
        VStack{
            Text(text).font(.title)
                
            Button(action: {
                self.startLoad()
            }){
                Text("Start").font(.largeTitle)
            }
            Button(action: {
                self.text = ""
            }){
                Text("Clear").font(.largeTitle)
            }
            Button(action: {
                self.httpRequest()
            }){
                Text("Girl").font(.largeTitle)
            }
        }
      
    }
    
    func startLoad(){
        let url = URL(string: "https://raw.githubusercontent.com/xiaoyouxinqing/PostDemo/master/PostDemo/Resources/PostListData_recommend_1.json")!
//       var request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.updateText(error.localizedDescription)
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                DispatchQueue.main.async {
                    self.updateText("Invalid response")
                }
                return
            }
            
            guard let data = data else {
                self.updateText("No data")
                return
            }
            
            guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
                self.updateText("Can not parse  data")
                return
            }
            self.updateText("Post conut \(list.list.count)")
            
        }
        task.resume()
    }
    
    func updateText(_ text: String){
        DispatchQueue.main.async {
            self.text = text
        }
        
    }
    func httpRequest() -> Void {
            guard let url = URL(string: "https://gank.io/api/v2/data/category/Girl/type/Girl/page/1/count/10") else {
                return
            }
            
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            config.httpAdditionalHeaders = ["Content-Type":"application/json"]
            config.timeoutIntervalForRequest = 30
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            let session = URLSession(configuration: config)
            
            
            session.dataTask(with: urlRequest){
                (data,_,_) in
                if let resultData = data{
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: resultData, options:[.mutableContainers,.mutableLeaves])
                        print(jsonObject)
                    }catch{
                        print("error")
                    }
                }
            }.resume()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
