//
//  QuoteView.swift
//  BirdUp
//
//  Created by dmu mac 26 on 12/12/2024.
//

import SwiftUI

struct QuoteView: View {
    @StateObject private var quoteController = QuoteController()
    public var body: some View {
        VStack(alignment: .center){
            Text("Bird Up!")
                .font(.largeTitle)
                .bold()
                .fontWeight(.heavy)
                .padding()
            Divider()
            Image(systemName: "bird")
                .resizable()
                .frame(width: 250, height: 250)
                .shadow(radius: 10)
                .padding()
            Spacer()
            if let quote = quoteController.quote {
                Text(quote.quote)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding()
                    
                Text(quote.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
                
            }
            else {
                ProgressView("Fetching Quote")
            }
        }
    }
}

#Preview {
    QuoteView()
}
