
import Foundation
struct CurrencyManager {


    func getCurrency (completionHandler : @escaping (Currency?)->Void){
        let url = URL(string: apiUrl)
        
        
        if let safeurl = url {
            let session = URLSession.shared
       
        
        let task = session.dataTask(with: safeurl) { (data, response, error) in
            if error != nil {
      
                print("Error" , error!.localizedDescription)
                completionHandler(nil)
            }
            if let safeData = data{
              if let  currency = self.parseJSON(safeData)
               {
                 completionHandler(currency)
                }
              else{
                completionHandler(nil)
              }
            }
            else{
                completionHandler(nil)
            }
        }
    
        task.resume()
        }
       
       }
    func convertCurrency(from: String , to: String , amount: Double) {
        
    }
    
    func parseJSON(_ data: Data) -> Currency? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Currency.self, from: data)
            return decodedData
            
        } catch {
      
            return nil
        }
    }
    
    
}
