//
//  CameraVC.swift
//  SnapDevChat
//
//  Created by Melissa Bain on 8/31/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit
import FirebaseAuth

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate {
    
    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        
        delegate = self
        self._previewView = previewView
        
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //performSegue(withIdentifier: "gotoLoginVC", sender: nil)
        
        guard FIRAuth.auth()?.currentUser != nil else {
            
            performSegue(withIdentifier: "gotoLoginVC", sender: nil)
            
            return
        }
    }
    
    func shouldEnableCameraUI(_ enable: Bool) {
        
        cameraButton.isEnabled = enable
        print("Should enable camera UI: \(enable)")
    }
    
    func shouldEnableRecordUI(_ enable: Bool) {
        
        recordButton.isEnabled = enable
        print("Should enable record UI: \(enable)")
    }
    
    func canStartRecording() {
        
        print("Recording has started")
    }
    
    func recordingHasStarted() {
        
        print("Can start recording")
    }
    
    func videoRecordingComplete(_ videoURL: URL!) {
        
        performSegue(withIdentifier: "gotoUsersVC", sender: ["videoURL": videoURL])
    }
    
    func videoRecordingFailed() {
        
    }
    
    func snapshotTaken(_ snapshotData: Data!) {
        
        performSegue(withIdentifier: "gotoUsersVC", sender: ["snapshotData": snapshotData])
    }
    
    func snapshotFailed() {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let UsersVC = segue.destination as? UsersVC {
            if let videoDict = sender as? Dictionary<String, URL> {
                let url = videoDict["videoURL"]
                UsersVC.videoURL = url
            } else if let snapDict = sender as? Dictionary<String, Data> {
                let snapData = snapDict["snapshotData"]
                UsersVC.snapData = snapData
            }
        }
    }
    
    @IBAction func changeCameraButtonPressed(_ sender: AnyObject) {
        
        changeCamera()
    }
    
    @IBAction func recordButtonPressed(_ sender: AnyObject) {
        
        print("this button was pressed")
        
        toggleMovieRecording()
    }
}
