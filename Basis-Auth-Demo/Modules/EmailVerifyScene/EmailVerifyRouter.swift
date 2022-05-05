//
//  EmailVerifyRouter.swift
//  Basis-Auth-Demo
//
//  Created by rishabh on 05/05/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol EmailVerifyRoutingLogic
{
    func routeToDashboardScene()
}

protocol EmailVerifyDataPassing
{
    var dataStore: EmailVerifyDataStore? { get }
}

class EmailVerifyRouter: NSObject, EmailVerifyRoutingLogic, EmailVerifyDataPassing
{
    weak var viewController: EmailVerifyViewController?
    var dataStore: EmailVerifyDataStore?
    
    // MARK: Routing
    func routeToDashboardScene()
    {
        print("\nRouting...\n")
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = mainStoryboard.instantiateViewController(withIdentifier: "EmailDashboardViewController") as! EmailDashboardViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDashboardScene(source: dataStore!, destination: &destinationDS)
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    // MARK: Passing data
    func passDataToDashboardScene(source: EmailVerifyDataStore, destination: inout EmailDashboardDataStore)
    {
        destination.isLogin = source.isLogin
        destination.email = source.email
        destination.verificationIsLogin = source.verificationIsLogin
        destination.verificationCode = source.verificationCode
        destination.userName = source.userName
        destination.message = source.responseMessage
        destination.success = source.isApiSuccess
    }
    
}
