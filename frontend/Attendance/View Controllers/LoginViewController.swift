//
//  LoginViewController.swift
//  Attendance
//
//  Created by Tijs Fertinel on 28/11/2018.
//  Copyright © 2018 Tijs Fertinel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func Login(_ sender: Any) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        loginService!.login(username: usernameField.text!, password: passwordField.text!, onSuccess: { (user) in
            UIViewController.removeSpinner(spinner: sv)
            DispatchQueue.main.async {
                self.currentUser = user
                self.loadLandingScreen()
            }
        }) {
            UIViewController.removeSpinner(spinner: sv)
            self.displayError()
        }
    }
    
    var currentUser: User?
    var loginService: LoginService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginService = LoginService()
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    func displayError() {
    }

    func loadLandingScreen() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let landingScreen = storyboard.instantiateViewController(withIdentifier: "Landing") as! LezingTableViewController
        let landingNavController = storyboard.instantiateViewController(withIdentifier: "lezingNavController") as! UINavigationController
        landingScreen.currentUser = currentUser
        landingNavController.pushViewController(landingScreen, animated: true)
        self.present(landingNavController, animated: true, completion: nil)
    }

}

extension UIViewController {
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}
