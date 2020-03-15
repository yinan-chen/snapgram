//
//  CameraViewController.swift
//  Snapagram
//
//  Created by RJ Pimentel on 3/11/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController {

    @IBOutlet weak var selectedImage: UIImageView!
    var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.cameraImagePicker = UIImagePickerController()
//        self.cameraImagePicker.delegate = self
//        self.cameraImagePicker.sourceType = .camera
        
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
        self.imagePickerController.sourceType = .photoLibrary

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func albumBtnPressed(_ sender: Any) {
        present(imagePickerController,animated: true){
            print("Album Image Picker Presented")
        }
    }
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage{
            selectedImage.image = img
        }
        
        imagePickerController.dismiss(animated: true, completion: nil)
    }
}
