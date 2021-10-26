//
//  Tab.swift
//  MyApp
//
//  Created by 國澤 on 2021/09/19.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            MemoListView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("リスト")
                }
                .tag(1)
            
            //hakariView()
              //  .tabItem {
                //    Image(systemName: "gauge")
                  //  Text("はかり")
                //}
                //.tag(2)
            
            TimerView()
                .tabItem {
                    Image(systemName: "timer")
                    Text("タイマー")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
