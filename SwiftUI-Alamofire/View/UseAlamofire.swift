//
//  UseAlamofire.swift
//  SwiftUI-Alamofire
//
//  Created by Kritchanat on 26/8/2567 BE.
//

import SwiftUI
import Alamofire

struct UseAlamofire: View {
    
    @State var items: [OsmItem] = []
    
    var body: some View {
        
        List {
            ForEach(items, id: \.place_id) { item in
                Text(item.display_name)
            }
        }
        .onAppear {
            Alamofire()
        }
    }
        
    func Alamofire() {
        
        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
            
        AF.request("https://nominatim.openstreetmap.org/search?city=paris&format=json")
          .validate(statusCode: 200..<300)
          .responseDecodable(of: [OsmItem].self) { response in
          switch response.result {
            case .success(let items):
                print("items", items)
                self.items = items
            case .failure(let error):
                print("Decoding Error: \(error)")
          }
        }
    }
}


#Preview {
    UseAlamofire()
}
