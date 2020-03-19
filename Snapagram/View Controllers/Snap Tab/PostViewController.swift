//
//  PostViewController.swift
//  Snapagram
//
//  Created by Yinan Chen on 3/18/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postImgView: UIImageView!
    var postImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load img transferred from segue
        postImgView.image = postImg
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
