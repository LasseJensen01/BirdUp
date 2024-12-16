//
//  MainPageView.swift
//  BirdUp
//
//  Created by dmu mac 26 on 12/12/2024.
//

import SwiftUI

struct MainPageView: View {
    @State var showContentView = false
    
    var body: some View {
        if showContentView {
            ContentView().environment(BirdController())
        } else {
            QuoteView()
            Button(action: bttAction){
                Text("See Some Birds")
                    .font(.title2)
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding()     }
    }
    func bttAction() {
        showContentView = true
    }
}
#Preview {
    MainPageView()
}
