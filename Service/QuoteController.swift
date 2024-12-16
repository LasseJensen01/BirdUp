//
//  QuoteController.swift
//  BirdUp
//
//  Created by dmu mac 26 on 12/12/2024.
//

import Foundation
import SwiftUI

@MainActor
class QuoteController: ObservableObject {
    @Published var quote: Quote?
    private let lastQuoteID = "lastQuoteID"
    init() {
        Task{
            await fetchQuote()
            // print(getLastQuoteID()) //Too see the currently saved ID in UserDefault
            }
        }
    
    private func getLastQuoteID() -> Int{
        UserDefaults.standard.integer(forKey: lastQuoteID)
    }
    private func saveLastQuoteID(_ id: Int) {
        UserDefaults.standard.set(id, forKey: lastQuoteID)
    }
    private func fetchQuote() async{
        Task{
            let lastID = getLastQuoteID()
            let data = try! await fetchData()
            if let data = data {
                let decoder = JSONDecoder()
                let randomQuote = try! decoder.decode(Quote.self, from: data)
                if (randomQuote.id == lastID){
                    await self.fetchQuote()
                } else {
                    saveLastQuoteID(randomQuote.id)
                    quote = randomQuote
                }
            }
        }
    }
    
    private func fetchData() async throws -> Data? {
        let url = URL(string: "https://dummyjson.com/quotes/random")!
        let session = URLSession.shared
        let (data, response) = try await session.data(from: url)
        let httpResponse = response as! HTTPURLResponse
        if httpResponse.statusCode == 200 {
            print("Fetched Quote")
            return data
        }
        else {
            print("Error fetching quote...")
            return nil
        }
        
    }
}
