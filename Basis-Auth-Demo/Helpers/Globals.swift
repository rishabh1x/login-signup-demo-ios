//
//  Globals.swift
//  Basis-Auth-Demo
//
//  Created by rishabh on 04/05/22.
//

import Foundation

class Globals: NSObject {
    static let base_url: String = "https://hiring.getbasis.co/"
    
    struct API_ENDPOINTS {
        struct Subroutes {
            private let email_subroute = "candidate/users/email"
            private let verify_subroute = "candidate/users/email/verify"
            
            func getEmailSubroute() -> String {
                return self.email_subroute
            }
            func getVerifySubroute() -> String {
                return self.verify_subroute
            }
        }
        
        private static let subRouteManager = Subroutes()
        
        static let login = base_url + subRouteManager.getEmailSubroute()
        static let verify = base_url + subRouteManager.getVerifySubroute()
    }
}
