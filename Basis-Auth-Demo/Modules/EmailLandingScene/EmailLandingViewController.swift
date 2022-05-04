//
//  EmailLandingViewController.swift
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

protocol EmailLandingDisplayLogic: AnyObject
{
    func loginActionComplete(viewModel: EmailLanding.LoginAction.LoginViewModel)
}

class EmailLandingViewController: UIViewController, EmailLandingDisplayLogic
{
    var interactor: EmailLandingBusinessLogic?
    var router: (NSObjectProtocol & EmailLandingRoutingLogic & EmailLandingDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    private func setup()
    {
        let viewController = self
        let interactor = EmailLandingInteractor()
        let presenter = EmailLandingPresenter()
        let router = EmailLandingRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(note:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTextFieldUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setTextFieldUI() {
        emailTextField.layer.borderWidth = 2.00
        emailTextField.layer.borderColor = UIColor.systemIndigo.cgColor
    }
    
    // MARK: Do something
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var buttonGetOTP: UIButton!
    @IBOutlet weak var containerStackViewBottomConstraint: NSLayoutConstraint!
    
    @IBAction func buttonGetOTPPressed(_ sender: Any) {
        ActivityIndicator.start(controller: self)
        let request = EmailLanding.LoginAction.LoginRequest(email: "rishabh1x@gmail.com")
        interactor?.loginUsing(request: request)
    }
    
    @IBAction func emailTextFieldDidBeginEditing(_ sender: UITextField) {
        sender.layer.borderColor = UIColor.systemIndigo.cgColor
    }
    
    func loginActionComplete(viewModel: EmailLanding.LoginAction.LoginViewModel) {
        DispatchQueue.main.async {
            ActivityIndicator.stop(controller: self)
            if (viewModel.apiSuccess) {
                self.emailTextField.isUserInteractionEnabled = false
                self.buttonGetOTP.isUserInteractionEnabled = false
                self.buttonGetOTP.backgroundColor = .systemGray2
                print("\nReady for routing to the -- verify scene\n")
            }
            else {
                self.emailTextField.layer.borderColor = UIColor.systemRed.cgColor
                print("\nAPI Status", viewModel.apiSuccess)
            }
        }
    }
    
    // MARK: Keyboard
    @objc func keyboardWillShow(note:Notification) {
        guard let keyboardFrame = note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardRect = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRect.height
        
        containerStackViewBottomConstraint.constant = keyboardHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(note:Notification) {
        containerStackViewBottomConstraint.constant = 0.00
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
