//
//  CameraVC.swift
//  SnapDevChat
//
//  Created by Melissa Bain on 8/31/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit

class CameraVC: AAPLCameraViewController, AAPLCameraVCDelegate {
    
    @IBOutlet weak var previewView: AAPLPreviewView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        
        delegate = self
        self._previewView = previewView
        
        super.viewDidLoad()
        
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
    
    @IBAction func changeCameraButtonPressed(_ sender: AnyObject) {
        
        changeCamera()
    }
    
    @IBAction func recordButtonPressed(_ sender: AnyObject) {
        print("this button was pressed")
        toggleMovieRecording()
    }
}
