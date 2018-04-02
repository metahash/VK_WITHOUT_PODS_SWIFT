//
//  DetailViewController.swift
//  VK_WITHOUT_PODS_SWIFT
//
//  Created by Victor on 02.04.2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var friendImage200: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var idUserLabel: UILabel!
    
    var friends  = [FriendsModel.Response.Items]()
    var imageUrl = ""
    var fullName = ""
    var location = ""
    var idUser   = ""
    var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromModel()
        load()
        self.view.reloadInputViews()
    }
    
    @IBAction func tap(_ sender: Any) {
        if (!flag) {
            //hide
            self.infoView.isHidden = true
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.view.backgroundColor = .darkGray//status bar
            self.mainView.backgroundColor = .darkGray
            flag = true
        }
        else {
            //show
            self.infoView.isHidden = false
            self.navigationController?.setNavigationBarHidden(false, animated: false)
            self.mainView.backgroundColor = .white
            flag = false
        }
    }
    
    func getDataFromModel() {
        for friend in friends {
            
            self.imageUrl = friend.photo_200_orig!
            self.fullName = "\(String(describing: friend.first_name!) )"
            self.fullName += " "
            self.fullName += "\(String(describing: friend.last_name!))"
            self.fullName += " "
            
            if friend.bdate != nil {
                self.fullName += "\(String(describing: friend.bdate!))"
            }
            
            if friend.city != nil {
                self.location = "\(String(describing: friend.city!.title!))"
            }
            
            if friend.country != nil {
                self.location += " "
                self.location += "\(String(describing: friend.country!.title!))"
            }
            
            if friend.id != nil {
                self.idUser = "id \(String(describing: friend.id!))"
            }
        }
    }
    
    
    func load() {
        
        let urlPath = URL(string: self.imageUrl)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: urlPath!)
            if let data = data {
                let image = UIImage (data: data)
                DispatchQueue.main.async {
                    self.friendImage200.image = image
                }
            }
        }
        self.fullNameLabel.text = self.fullName
        self.locationLabel.text = self.location
        self.idUserLabel.text = self.idUser
    }
}
