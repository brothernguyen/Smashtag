//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Tuan Anh on 3/25/17.
//  Copyright © 2017 Tuan Anh. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewController: UITableViewController {
    
    private var tweets = [Array<Tweet>]()
    
    var searchText: String? {
        didSet {
            tweets.removeAll()
            tableView.reloadData()
            searchForTweets()
            title = searchText
        }
    }
    
    private func twitterRequest() -> Twitter.Request? {
        if let query = searchText, !query.isEmpty {
            return Twitter.Request(search: query, count: 100)
        }
        return nil
    }
    
    private func searchForTweets() {
        if let request = twitterRequest() {
            request.fetchTweets { [weak self] newTweets in
                self?.tweets.insert(newTweets, at: 0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText = "#stanford"
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
 
    

}
