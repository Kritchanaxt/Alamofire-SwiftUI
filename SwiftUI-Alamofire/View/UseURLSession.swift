//
//  UseURLSession.swift
//  SwiftUI-Alamofire
//
//  Created by Kritchanat on 26/8/2567 BE.
//

import SwiftUI

struct UseURLSession: View {
    
    @State private var items: [OsmItem] = []
        
        var body: some View {
            
            List {
                ForEach(items, id: \.place_id) { item in
                    Text(item.display_name.isEmpty ? "Unknown" : item.display_name)
                }
            }
            .onAppear {
                fetchData()
            }
        }
        
    func fetchData() {
        
        let urlString = "https://nominatim.openstreetmap.org/search?city=paris&format=json"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Response: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let items = try decoder.decode([OsmItem].self, from: data)
                DispatchQueue.main.async {
                    self.items = items
                }
            } catch let decodingError {
                print("Decoding error: \(decodingError)")
            }
        }.resume()
    }

}

#Preview {
    UseURLSession()
}
