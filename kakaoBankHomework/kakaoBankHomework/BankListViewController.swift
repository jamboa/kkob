//
//  ViewController.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 7..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import UIKit
import SwiftyJSON

class BankListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var bankAppsTable: UITableView!
    var banks : Array<JSON> = [JSON]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listViewCell", for: indexPath) as! ListViewCell
        cell.cancelUpdating()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listViewCell", for: indexPath) as! ListViewCell
        let data = banks[indexPath.row]
        let iconArray = data["im:image"].arrayValue
        let iconImage = iconArray[2]["label"].stringValue
        cell.updateInfo(iconImageUrl: iconImage,
                        title: data["title"]["label"].stringValue,
                        subTitle: data["rights"]["label"].stringValue,
                        idString : data["id"]["attributes"]["im:id"].stringValue)
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let viewController = segue.destination as? BankAppDetailTableViewController {
            if let urlString = sender as? String {
                viewController.idString = urlString
//                print("urlString : \(urlString)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = banks[indexPath.row]
//        print("data : \(data)")
        performSegue(withIdentifier: "toBankAppDetail", sender: data["id"]["attributes"]["im:id"].stringValue)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bankAppsTable.dataSource = self
        bankAppsTable.delegate = self
        
        let url = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=200/genre=6015/json"
        
        let _ = Bernoice.shared.getByRemote(url: url, cached: false ,completion:{[weak self] (data) in
            
            let json = JSON(data)
            if let appArrays = (json["feed"]["entry"].array) {
                self?.banks = appArrays
            }
            
            DispatchQueue.main.async {
                self?.bankAppsTable.reloadData()
            }
            
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

