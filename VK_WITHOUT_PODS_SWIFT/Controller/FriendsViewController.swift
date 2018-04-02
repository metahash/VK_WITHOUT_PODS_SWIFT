//
//  FriendsViewController.swift
//  VK_WITHOUT_PODS_SWIFT
//
//  Created by Victor on 02.04.2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var friends = [FriendsModel.Response.Items]()
    var user_id : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FriendsNetworkService.getComments(userID: self.user_id!) { (response) in
            self.friends = response.friends
            self.tableView.reloadData()
        }
    }
}

extension FriendsViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView (_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "friendsCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as? FriendsCell else { return UITableViewCell() }
        
        cell.lastNameLabel.text = friends[indexPath.row].last_name
        cell.firstNameLabel.text =  friends[indexPath.row].first_name
        
        ///UI iphoneX
        cell.contentView.backgroundColor = UIColor.white
        cell.backgroundColor = UIColor.white
        ///
        if let imageURL = URL(string: friends[indexPath.row].photo_50!) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageURL)
                if let data = data {
                    let image = UIImage (data: data)
                    DispatchQueue.main.async {
                        cell.friendsImageView.image = image
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        destinationVC.friends = [friends[indexPath.row]]
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
}


