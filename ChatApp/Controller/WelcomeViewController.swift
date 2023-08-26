//
//  ViewController.swift
//  ChatApp
//
//  Created by Ashraf Eltantawy on 21/08/2023.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var welcomeLable: UILabel!
    var characterIndex = 0.0
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden=true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden=false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLable.text=""
        let welcomeLetter = K.appName
        for letter in welcomeLetter{
            Timer.scheduledTimer(withTimeInterval: 0.1*characterIndex, repeats: false) { timer in
                self.welcomeLable.text?.append(letter)
            }
            
            characterIndex+=1
        }
    }


}

