import Foundation

class APIService{
    // singleton
    static var shared = APIService()
    // URLsession to perform http requests
    let session = URLSession(configuration: .default)
    
    func getMovies(for Query: String,completion:@escaping([Title]?,Error?)->Void){
        guard let FormatedQuery = Query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)  else { return }
        
        guard let  SEARCH_URL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=fe9e80d1fa637ea530b765d6ab39a6ec&query=\(FormatedQuery)")
        else {
            print("INVALID")
            return
        }
        
        // create a networking task to perform http get request
        let task = session.dataTask(with: SEARCH_URL) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil,error)
            }
            if let data = data {
                do{
                    let decodedData = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                    print(decodedData)
                    completion(decodedData.results,nil)
                }
                catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getConversionRate(completion: @escaping (Double) -> Void) {
        guard let url = URL(string: "http://api.currencylayer.com/live?access_key=4be5684586ec246c0b906d0b29855337&currencies=SGD,CNY") else {
            print("invalid url")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching conversion rate", error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("Empty response data")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let rates = json?["quotes"] as? [String: Any]

                if let sgdPerUsd = rates?["USDSGD"] as? Double, let cnyPerUsd = rates?["USDCNY"] as? Double {
                    let sgdPerCny = sgdPerUsd / cnyPerUsd
                    completion(sgdPerCny)
                } else {
                    completion(0.2)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
     
    func getContacts() -> [Contact]{
      let contacts = [
       Contact(name: "Kelly Goodwin", jobTitle: "Designer", country: "bo"),
       Contact(name: "Mohammad Hussain", jobTitle: "SEO Specialist", country: "be"),
       Contact(name: "John Young", jobTitle: "Interactive Designer", country: "af"),
       Contact(name: "Tamilarasi Mohan", jobTitle: "Architect", country: "al"),
       Contact(name: "Kim Yu", jobTitle: "Economist", country: "br"),
       Contact(name: "Derek Fowler", jobTitle: "Web Strategist", country: "ar"),
       Contact(name: "Shreya Nithin", jobTitle: "Product Designer", country: "az"),
       Contact(name: "Emily Adams", jobTitle: "Editor", country: "bo"),
       Contact(name: "Aabidah Amal", jobTitle: "Creative Director", country: "au"),
       Contact(name: "Kelly Goodwin", jobTitle: "Designer", country: "bo"),
       Contact(name: "Mohammad Hussain", jobTitle: "SEO Specialist", country: "be"),
       Contact(name: "John Young", jobTitle: "Interactive Designer", country: "af"),
       Contact(name: "Tamilarasi Mohan", jobTitle: "Architect", country: "al"),
       Contact(name: "Kim Yu", jobTitle: "Economist", country: "br"),
       Contact(name: "Derek Fowler", jobTitle: "Web Strategist", country: "ar"),
       Contact(name: "Shreya Nithin", jobTitle: "Product Designer", country: "az"),
       Contact(name: "Emily Adams", jobTitle: "Editor", country: "bo"),
       Contact(name: "Aabidah Amal", jobTitle: "Creative Director", country: "au")
       ]
      return contacts
     }
}
