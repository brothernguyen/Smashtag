//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Anh Tuan Nguyen on 3/28/17.
//  Copyright © 2017 Tuan Anh. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Twitter.Tweet? { didSet{updateUI()} }
    
    private func updateUI() {
        tweetTextLabel?.text = tweet?.text
        tweetUserLabel?.text = tweet?.user.description
        
        if let profileImageURL = tweet?.user.profileImageURL {
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContent = try? Data(contentsOf: profileImageURL)
                if let imageData = urlContent {
                    DispatchQueue.main.async {
                        self?.tweetProfileImageView?.image = UIImage(data: imageData)
                    }                    
                }
            }
        }
        else {
            tweetProfileImageView?.image = nil
        }
        
        if let created = tweet?.created {
            let formatter = DateFormatter()
            if Date().timeIntervalSince(created) > 24*60*60 {
                formatter.dateStyle = .short
            }
            else {
                formatter.timeStyle = .short
            }
            tweetCreatedLabel?.text = formatter.string(from: created)
        }
        else {
            tweetCreatedLabel?.text = nil
        }
    }
}
