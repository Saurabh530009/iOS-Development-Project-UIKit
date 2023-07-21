//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var messageTextfield: UITextField?
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey!"),
        Message(sender: "a@b.com", body: "Hello!"),
        Message(sender: "1@2.com", body: "What's up?"),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        title = K.appName
        navigationItem.hidesBackButton = true
        
        registerCell()
        loadMessages()
        
    }
    
    func loadMessages(){
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
            
            self.messages = []
            
            if let e = error {
                print("There is an issue on retrieving data from firestore. \(e)")
            } else {
                if let snapshotDocuments  = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView?.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView?.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func registerCell(){
        let nib = UINib(nibName: K.cellNibName, bundle: nil)
        tableView?.register(nib, forCellReuseIdentifier: K.cellIdentifier)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield?.text,let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField : messageSender,
                                                                      K.FStore.bodyField : messageBody,
                                                                      K.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("There is an issue with saving data to Firestor \(e)")
                } else {
                    print("Successfully saved data.")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield?.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as? MessageCell else{
            return UITableViewCell();
        }

        let message = messages[indexPath.row]
        cell.label?.text = message.body
        
        // This is the message from the current user.
        if (message.sender == Auth.auth().currentUser?.email) {
            cell.leftImageView?.isHidden = true
            cell.rightImageView?.isHidden = false
            cell.messageBubble?.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label?.textColor = UIColor(named: K.BrandColors.purple)
        }
        // This is message from another sender
        else {
            cell.leftImageView?.isHidden = false
            cell.rightImageView?.isHidden = true
            cell.messageBubble?.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label?.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
    
        return cell
    }
}

extension ChatViewController :UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
