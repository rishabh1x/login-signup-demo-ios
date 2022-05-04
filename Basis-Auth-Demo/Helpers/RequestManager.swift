//
//  RequestManager.swift
//  Basis-Auth-Demo
//
//  Created by rishabh on 04/05/22.
//

import Foundation

class RequestManager: NSObject {
    func sendAsyncRequestWith(endpointUrl: String, httpMethod: String, jsonData:String, onCompletion: @escaping (_ response:Data?,_ success:Bool) -> Void) {
        let strUrl = endpointUrl
        
        guard let url = URL(string: strUrl) else {return}
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { (dataReceived, response, error) in
            print("\n", response as Any, error as Any)
            print("\nData:", String.init(data: dataReceived ?? Data(), encoding: .utf8) as Any)
            
            if (error != nil) {
                onCompletion(nil, false)
            }
            else {
                if let dataReceivedNotNil = dataReceived {
                    onCompletion(dataReceivedNotNil, true)
                }
                else {
                    onCompletion(nil, false)
                }
            }
        }
        task.resume()
    }
}
