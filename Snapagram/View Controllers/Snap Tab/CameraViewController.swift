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
    @IBOutlet weak var postBtn: UIButton!
    
    var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _ = selectedImage.image{
            postBtn.isHidden = false
        }else{
            postBtn.isHidden = true
        }
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        self.imagePickerController.sourceType = .camera
        
        present(imagePickerController,animated: true){
            print("Camera Image Picker Presented")
            self.postBtn.isHidden = false
        }
    }
    
    @IBAction func albumBtnPressed(_ sender: Any) {
        self.imagePickerController.sourceType = .photoLibrary
        
        present(imagePickerController,animated: true){
            print("Album Image Picker Presented")
            self.postBtn.isHidden = false
        }
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toPostView", sender: nil)
        selectedImage.image = nil
        postBtn.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PostViewController{
            dest.postImg = selectedImage.image
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
