//
//  UsersVC.swift
//  SnapDevChat
//
//  Created by Melissa Bain on 9/1/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class UsersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]()
    private var selectedUsers = Dictionary<String, User>()
    private var _snapData: Data?
    private var _videoURL: URL?
    
    var snapData: Data? {
        
        get { return _snapData}
        set { _snapData = newValue }
    }
    
    var videoURL: URL? {
        
        get { return _videoURL }
        set { _videoURL = newValue }
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = true
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        DataService.instance.usersRef.observeSingleEvent(of: .value) { (snapshot: FIRDataSnapshot) in
            
            print("Snapshot: \(snapshot.debugDescription)")
            
            // Parse this in the model class - not here
            if let users = snapshot.value as? Dictionary<String, AnyObject> {
                for (key, value) in users {
                    if let dict = value as? Dictionary<String, AnyObject> {
                        //dict["dateAccountCreated"]
                        if let profile = dict["profile"] as? Dictionary<String, AnyObject> {
                            if let firstName = profile["firstName"] as? String {
                                let uid = key
                                let user = User(uid: uid, firstName: firstName)
                                
                                self.users.append(user)
                            }
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
            
            print("users: \(self.users)")
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        let user = users[indexPath.row]
        
        cell.updateUI(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        navigationItem.rightBarButtonItem?.isEnabled = true
        
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: true)
        
        let user = users[indexPath.row]
        selectedUsers[user.uid] = user
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! UserCell
        cell.setCheckmark(selected: false)
        
        let user = users[indexPath.row]
        selectedUsers[user.uid] = nil
        
        if selectedUsers.count <= 0 {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }
    
    @IBAction func sendButtonPressed(sender: AnyObject) {
        
        if let url = _videoURL {
            let videoName = "\(NSUUID().uuidString)\(url)"
            let ref = DataService.instance.videoStorageRef.child(videoName)
            
            let task = ref.putFile(url, metadata: nil, completion: { (meta: FIRStorageMetadata?, err) in
                
                if err != nil {
                    print("Error uploading video: \(err?.localizedDescription)")
                } else {
                    let downloadURL = meta!.downloadURL()
                    print("Download URL: \(downloadURL)")
                    
                    // Save this somewhere
                    self.dismiss(animated: true, completion: nil)
                }
            })
        } else if let snap = snapData {
            let ref = DataService.instance.imagesStorageRef.child("\(NSUUID().uuidString).jpg")
            
            let task = ref.put(snap, metadata: nil, completion: { (meta: FIRStorageMetadata?, err) in
                
                if err != nil {
                    print("Error uploading snapshot : \(err?.localizedDescription)")
                } else {
                    let downloadURL = meta!.downloadURL()
                    
                    self.dismiss(animated: true, completion: nil)
                }
            
            })
            
        }
    }
}
