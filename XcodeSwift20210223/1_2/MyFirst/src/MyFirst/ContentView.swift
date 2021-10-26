//
//  ContentView.swift
//  MyFirst
//
//  Created by Swift-Beginners. on 2019/12/08.
//  Copyright © 2019 Swift-Beginners. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var outputText = "Hello, World!"
    
    var body: some View {
        VStack() {
            Text(outputText)
                .font(.largeTitle)
                .padding(.bottom)
            
            Button(action: {
                self.outputText = "Hi, Swift!"
            }) {
                Text("切り替えボタン")
                    .foregroundColor(Color.white)
                    .padding(.all)
                    .background(Color.blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
