//
//  Globals.swift
//  Basis-Auth-Demo
//
//  Created by rishabh on 04/05/22.
//

import Foundation
import UIKit.UIColor

class Globals: NSObject {
    class ColorFactory: NSObject {
        static let indigo = UIColor.init(red: 88/255, green: 86/255, blue: 214/255, alpha: 1.00)
    }
    
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
