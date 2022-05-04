//
//  EmailLandingPresenter.swift
//  Basis-Auth-Demo
//
//  Created by rishabh on 04/05/22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EmailLandingPresentationLogic
{
    func presentSomething(response: EmailLanding.LoginAction.LoginResponse)
}

class EmailLandingPresenter: EmailLandingPresentationLogic
{
  weak var viewController: EmailLandingDisplayLogic?
  
  // MARK: Do something
  
    func presentSomething(response: EmailLanding.LoginAction.LoginResponse)
  {
      let viewModel = EmailLanding.LoginAction.LoginViewModel(apiSuccess: response.success, isLogin: response.isLogin)
      viewController?.loginActionComplete(viewModel: viewModel)
  }
}
