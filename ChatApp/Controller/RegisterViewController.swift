//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Ashraf Eltantawy on 22/08/2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registerClick(_ sender: UIButton) {
        startLoading()
        let email = emailField.text ?? ""
        let pass = passwordField.text ?? ""
            Auth.auth().createUser(withEmail: email, password: pass) { authResult, error in
                self.stopLoading()
                if let  error = error{
                    print(error.localizedDescription)
                }else{
                    self.performSegue(withIdentifier: K.registerSeque, sender: self)
                }
            }
        
        
        
    }
    
    
    func setupActivityIndicator() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    // Function to start the activity indicator
    func startLoading() {
        activityIndicator.startAnimating()
    }
    
    // Function to stop the activity indicator
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
}
