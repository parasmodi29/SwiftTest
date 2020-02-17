
import UIKit
import Alamofire

class APIhandler: NSObject {

  static let shared: APIhandler = {
    let instance = APIhandler()
    // Setup code
    return instance
  }()
  
  fileprivate func getBaseURL() -> String {
    
    return "https://dev.akcess.io:4000/"
  }
  
  internal func getURL(path: String,pathVariables: [String:Any]?, queryParams: [String:Any]?) -> URL {
    
    var resultingPath = self.getBaseURL() + path
    
    if let pathVariables = pathVariables {
      for (key, value) in pathVariables {
        resultingPath = resultingPath.replacingOccurrences(of: key, with: "\(value)")
      }
    }
    
    let encodedString = resultingPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)
    
    var urlComponents = URLComponents(string: encodedString!)
    
    if let queryParams = queryParams {
      urlComponents?.queryItems = []
      for (key, value) in queryParams {
        urlComponents?.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
      }
    }
    
    return urlComponents!.url!
  }
  
  
  internal func getDataRequest(url: URL, method: HTTPMethod, bodyData: [String:Any]?, completion: @escaping(DataRequest?, Error?) -> Void) {
    
    let dataRequest = request(url, method: method, parameters: bodyData, encoding: JSONEncoding.default, headers: nil)
    
    dataRequest.response() { response in
      
      if response.response != nil {
        
        if response.response?.statusCode != nil {
          
          if (response.response?.statusCode)! == 200 {
            completion(dataRequest, nil)
          }else {
            return
           // completion(dataRequest, nil)
          }
          
        }
        
      }
      
    }
  }
  
  
  internal func getResponse <T: Codable> (method: HTTPMethod, url: URL, bodyData: [String:Any]?, completion: @escaping (T?, String?) -> Void) {
    
    getDataRequest(url: url, method: method, bodyData: bodyData) { dataRequest, error in
      guard let dataRequest = dataRequest, error == nil else {
        completion(nil, error?.localizedDescription)
        return
      }
      
      dataRequest
        .response() { response in
          guard let data = response.data, response.error == nil else {
            completion(nil, response.error?.localizedDescription)
            return
          }
          do {
            /*let jsonResponse = try JSONSerialization.jsonObject(with:
            data, options: [])
            print(jsonResponse)*/
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            completion(decodedData, nil)
            
          } catch {
            
              completion(nil,self.convertDataToDictionary(jsonData:data))
          }
         
      }
    }
  }

  
  private  func convertDataToDictionary(jsonData: Data)-> String {
    
    do {
      
      let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:Any]
      
      guard let dictError = json!["error"]  as? NSDictionary else {
        
        return ""
      }
      guard let dictDetail = dictError.value(forKey:"details")  as?  [Any] else {
        
        guard let errorMessage = dictError.value(forKey:"message")  as? String else {
          
          return ""
        }
        
        return errorMessage
        
      }
      
      
      if let json = dictDetail as? [[String:AnyObject]] {
        
        for object in json {
          
          guard let errorMessage = object["message"]  as? String else {
            
            guard let errorMessage = object["description"]  as? String else {
              
              return ""
            }
            return errorMessage
          }
          
          return errorMessage
        }
        
      }
      
      return ""
      
    } catch {
      
    }
    
    if let aStrError = String.init(data: jsonData, encoding:.utf8) {
      
      return aStrError
    }
    return ""
  }
}


extension APIhandler {
  
  func getReponseForRequest(requestURL:URL, bodyPerameter: [String:Any]?,methodName:HTTPMethod,completion: @escaping(UsersDetail?, String?) -> Void) {
      
      getResponse(method:methodName, url:requestURL, bodyData:bodyPerameter) { (userDetail,Error) in
          
          completion(userDetail,Error)
      }
      
  }
}
