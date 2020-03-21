//
//  PostViewController.swift
//  Snapagram
//
//  Created by Yinan Chen on 3/18/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var postImgView: UIImageView!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var captionField: UITextField!
    
    var postImg: UIImage!
    var selectedThreadIndex: Int!
    
    //reference to whole collection view
    @IBOutlet weak var threadCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load img transferred from segue
        postImgView.image = postImg
        
        //require delegates to connect between view and controller
        threadCollectionView.delegate = self
        threadCollectionView.dataSource = self
        
        /*
             move up view while typing using keyboard
             credit to:
          https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
                 
          */
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // obey the set protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return number of cell
        return feed.threads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        //get the specific thread that are working on
        let thread = feed.threads[index]
        
        //get reference to the cell at the above index
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postViewThreadCell", for: indexPath) as? PostViewThreadCollectionViewCell{
            cell.emojiLabel.text = thread.emoji
            cell.nameLabel.text = thread.name
            
            return cell
        }else{
            //return empty UICollectionViewCell
            return UICollectionViewCell()
        }
        
    }
    
    // function for selected thread view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedThreadIndex = indexPath.item
    }
    
    @IBAction func createThreadBtnPressed(_ sender: Any) {
        let newThreadEntry = ThreadEntry(username: feed.threads[selectedThreadIndex].name, image: postImg)
    feed.threads[selectedThreadIndex].addEntry(threadEntry: newThreadEntry)
        print("add new thread entry to \(newThreadEntry.username)")
    }
    
    @IBAction func createPostBtnPressed(_ sender: Any) {
        let location = locationField.text ?? ""
        let caption = captionField.text ?? ""
        
        
        let newPost = Post(location: location, image: postImg, user: "Yinan&Yutong", caption: caption, date: Date())
        feed.addPost(post: newPost)
    }
    
    /*
        move up view while typing using keyboard
        credit to:
     https://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
            
     */
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
//    }
}
