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
    }
}
