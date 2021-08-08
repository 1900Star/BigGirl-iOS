//
//  ContentView.swift
//  BigGirl
//
//  Created by 罗诗朋 on 2021/2/7.
//

import SwiftUI
struct ContentView: View {
    @State private var text = "Smartisan"
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
                self.getGirl()
            }){
                Text("Girl").font(.largeTitle)
            }
            TextField("输入",text:$text).padding(10)
        }
      
    }
    
    func startLoad(){
        NetworkApi.hotPostList { result in
            switch result{
            case let .success(list):
                self.updateText("Post conut \(list.list.count)")
                printData(list: list.list)
            case let .failure(error):  self.updateText(error.localizedDescription)
            }
        }
    }
    
    func getGirl() -> Void {
          let url = "data/category/Girl/type/Girl/page/1/count/10"
        NetworkApi.getGrilList(url: url) { result in
            switch result {
            case let .success(list):
                self.updateText("Post conut \(list.data.count)")
                printGirlData(list: list.data)
            case let .failure(error):  self.updateText(error.localizedDescription)
            }
        }
       
        
    }
    func printGirlData( list:[Girl]) -> Void {
        list.forEach { Girl in
            print(Girl.desc)
        }
        
    }
    
    
    func printData( list:[PostBean]) -> Void {
        list.forEach { PostBean in
            print(PostBean.avatar)
        }
        
    }
    
    func updateText(_ text: String){
        DispatchQueue.main.async {
            self.text = text
        }
        
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
