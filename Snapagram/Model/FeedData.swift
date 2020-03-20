//
//  FeedData.swift
//  Snapagram
//
//  Created by Arman Vaziri on 3/8/20.
//  Copyright © 2020 iOSDeCal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

// Create global instance of the feed
var feed = FeedData()
let db = Firestore.firestore()
let storage = Storage.storage()

class Thread {
    var name: String
    var emoji: String
    var entries: [ThreadEntry]
    
    init(name: String, emoji: String) {
        self.name = name
        self.emoji = emoji
        self.entries = []
    }
    
    func addEntry(threadEntry: ThreadEntry) {
        entries.append(threadEntry)
        let imageID = UUID.init().uuidString
        let sender = threadEntry.username
        let receiver = self.name
        
        let storageRef = storage.reference(withPath: "threadEntry/\(imageID).jpg")
        guard let imageData = threadEntry.image.jpegData(compressionQuality: 0.75) else { return }
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        storageRef.putData(imageData)
        
        var ref: DocumentReference? = nil
        ref = db.collection("threadEntry").addDocument(data:[
            "imageID": imageID,
            "sender": sender,
            "receiver": receiver]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
    
    func removeFirstEntry() -> ThreadEntry? {
        if entries.count > 0 {
            return entries.removeFirst()
        }
        return nil
    }
    
    func unreadCount() -> Int {
        return entries.count
    }
}

struct ThreadEntry {
    var username: String
    var image: UIImage
}

struct Post {
    var location: String
    var image: UIImage?
    var user: String
    var caption: String
    var date: Date
}

class FeedData {
    var username = "Yinan&Yutong"
    
    var threads: [Thread] = [
        Thread(name: "memes", emoji: "😂"),
        Thread(name: "dogs", emoji: "🐶"),
        Thread(name: "fashion", emoji: "🕶"),
        Thread(name: "fam", emoji: "👨‍👩‍👧‍👦"),
        Thread(name: "tech", emoji: "💻"),
        Thread(name: "eats", emoji: "🍱"),
    ]

    // Adds dummy posts to the Feed
    var posts: [Post] = [
        Post(location: "New York City", image: UIImage(named: "skyline"), user: "nyerasi", caption: "Concrete jungle, wet dreams tomato 🍅 —Alicia Keys", date: Date()),
        Post(location: "Memorial Stadium", image: UIImage(named: "garbers"), user: "rjpimentel", caption: "Last Cal Football game of senior year!", date: Date()),
        Post(location: "Soda Hall", image: UIImage(named: "soda"), user: "chromadrive", caption: "Find your happy place 💻", date: Date())
    ]
    
    // Adds dummy data to each thread
    init() {
        for thread in threads {
            let entry = ThreadEntry(username: self.username, image: UIImage(named: "garbers")!)
            thread.entries.append(entry)
        }
    }
    
    func fetchThread() {
        db.collection("threadEntry").getDocuments(){ (threadEntries, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                var receiver: String
                var imageID: String
                var sender: String
                
                for document in threadEntries!.documents {
                    imageID = document.data()["imageID"] as! String
                    receiver = document.data()["receiver"] as! String
                    sender = document.data()["sender"] as! String
                    
                    let storageRef = storage.reference(withPath: "threadEntry/\(imageID).jpg")
                    
                    storageRef.getData(maxSize: 4 * 1024 * 1024) { (data, error) in
                        if error != nil {
                            print("error")
                        }
                        if let data = data {
                            let image = UIImage(data: data)
                            for thread in self.threads {
                                if thread.name == receiver {
                                    thread.entries.append(ThreadEntry(username: sender, image: image!))
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addPost(post: Post) {
        posts.append(post)
        let location = post.location
        let imageID = UUID.init().uuidString
        let user = post.user
        let caption = post.caption
        let date = Timestamp(date: post.date)
        
        let storageRef = storage.reference(withPath: "post/\(imageID).jpg")
        guard let imageData = post.image!.jpegData(compressionQuality: 0.75) else { return }
        let uploadMetadata = StorageMetadata.init()
        uploadMetadata.contentType = "image/jpeg"
        storageRef.putData(imageData)
        
        var ref: DocumentReference? = nil
        ref = db.collection("post").addDocument(data:[
            "location": location,
            "imageID": imageID,
            "user": user,
            "caption": caption,
            "date": date]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    // Optional: Implement adding new threads!
    func addThread(thread: Thread) {
        threads.append(thread)
    }
}

// write firebase functions here (pushing, pulling, etc.) 
