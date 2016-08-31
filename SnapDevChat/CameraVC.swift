//
//  CameraVC.swift
//  SnapDevChat
//
//  Created by Melissa Bain on 8/31/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit

class CameraVC: AAPLCameraViewController {

    @IBOutlet weak var previewView: AAPLPreviewView!
    
    override func viewDidLoad() {
        
        self._previewView = previewView
        
        super.viewDidLoad()
        
    }
    
    @IBAction func changeCameraButtonPressed(_ sender: AnyObject) {
        
        changeCamera()
    }
    
    
    @IBAction func recordButtonPressed(_ sender: AnyObject) {
        print("this button was pressed")
        toggleMovieRecording()
    }
}
