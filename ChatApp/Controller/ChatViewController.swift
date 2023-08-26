//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Ashraf Eltantawy on 22/08/2023.
//

import UIKit
import Firebase
class ChatViewController: UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    var messages :[Message] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = K.appName
        navigationItem.hidesBackButton  = true
        tableview.dataSource=self
        tableview.register(UINib(nibName: K.nibFile, bundle: nil), forCellReuseIdentifier: K.messageCell)
        getMessagesFromFireStore()
    }
    
    @IBAction func logOutClick(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    
    @IBAction func sendClick(_ sender: UIButton) {
        if let message = messageField.text , let sender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collection)
                .addDocument(data: [
                    K.FStore.senderField:sender
                    ,K.FStore.bodyField:message
                    ,K.FStore.dateFiled:Date().timeIntervalSince1970]) { (error) in
                        if let error = error{
                            print("erro from fireStore \(error.localizedDescription)")
                        }else{
                            self.messageField.text=""
                        }
                    }
            
        }
    }
    func getMessagesFromFireStore(){
        db.collection(K.FStore.collection)
            .order(by: K.FStore.dateFiled)
            .addSnapshotListener { (querySnapShot , error) in
                self.messages = []
                
                if let error  = error{
                    print("error from get message \(error)")
                }else{
                    if let snapShotDoucuments = querySnapShot?.documents{
                        for snap in snapShotDoucuments{
                            if let message = snap.data()[K.FStore.bodyField] as? String , let sender = snap.data()[K.FStore.senderField] as? String{
                                self.messages.append(Message(sender:sender, body: message))
                            }
                            
                        }
                        DispatchQueue.main.async {
                            self.tableview.reloadData()
                            if self.messages.isEmpty == false {
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableview.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            
                           
                        }
                        
                    }
                }
            }
    }
    
}



extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        if let messageCell = tableView.dequeueReusableCell(withIdentifier: K.messageCell, for: indexPath) as? MessageCellTableViewCell {
            messageCell.label.text = message.body
            
            if message.sender == Auth.auth().currentUser?.email{
                messageCell.imageRecver.isHidden=true
                messageCell.imageSender.isHidden=false
                messageCell.viewOfBody.backgroundColor = UIColor(named: K.Color.BrandLightPurple)
                messageCell.label.textColor = UIColor(named: K.Color.BrandPurple)
            }else{
                messageCell.imageRecver.isHidden=false
                messageCell.imageSender.isHidden=true
                messageCell.viewOfBody.backgroundColor = UIColor(named: K.Color.BrandPurple)
                messageCell.label.textColor = UIColor(named: K.Color.BrandLightPurple)
            }
            
            
            
            return messageCell
        }
        return UITableViewCell()
    }
    
    
}
