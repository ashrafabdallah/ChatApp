//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Ashraf Eltantawy on 22/08/2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginClick(_ sender: UIButton) {
        let email = emailField.text ?? ""
        let pass = passwordField.text ?? ""
        Auth.auth().signIn(withEmail: email, password: pass) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            if let error = error{
                print(error.localizedDescription)
            }else{
                self?.performSegue(withIdentifier: K.loginSeque, sender: self)
            }
        }
    }
    
}
