# Alamofire Vs URLSession

## URLSession Example
let url = URL(string: "https://api.example.com/data")!
let task = URLSession.shared.dataTask(with: url) { data, response, error in
    if let error = error {
        print("Error: \(error.localizedDescription)")
        return
    }
    guard let data = data else {
        print("No data received")
        return
    }
    do {
        let decodedData = try JSONDecoder().decode([MyModel].self, from: data)
        print(decodedData)
    } catch {
        print("Decoding error: \(error)")
    }
}
task.resume()


## Alamofire Example
AF.request("https://api.example.com/data").responseDecodable(of: [MyModel].self) { response in
    switch response.result {
    case .success(let decodedData):
        print(decodedData)
    case .failure(let error):
        print("Error: \(error.localizedDescription)")
    }
}

## Summary
**URLSession:** 
  - Built-in, flexible, requires more code, More control but requires more setup, good for custom and low-level network tasks
**Alamofire:**
  -Third-party, simplifies networking, includes features like JSON decoding, Simplifies requests and response handling with concise syntax, error handling, and easier syntax, ideal for complex tasks and quick development. 
