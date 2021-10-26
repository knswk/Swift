//
//  ContentView.swift
//  MyApp
//
//  Created by 國澤 on 2021/09/11.
//

import SwiftUI

struct hakariView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("100g")
                .font(.largeTitle)
                .padding()
            
            Image("hakari")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Spacer()
        }
    }
}

struct hakariView_Previews: PreviewProvider {
    static var previews: some View {
        hakariView()
    }
}
