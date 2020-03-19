//
//  PostViewController.swift
//  Snapagram
//
//  Created by Yinan Chen on 3/18/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var postImgView: UIImageView!
    var postImg: UIImage!
    var feedData : FeedData!
    
    //reference to whole collection view
    @IBOutlet weak var threadCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //load img transferred from segue
        postImgView.image = postImg
        
        //require delegates to connect between view and controller
        threadCollectionView.dataSource = self
        self.feedData = FeedData()
    }
    
    
    // obey the set protocols
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return number of cell
        return feedData.threads.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.item
        //get the specific thread that are working on
        let thread = feedData.threads[index]
        
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
}
