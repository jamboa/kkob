//
//  BankAppDetailViewController.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 8..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BankAppDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    


    public var urlString : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let urlString =  "https://itunes.apple.com/lookup?id=\(self.urlString)&country=kr"
        
        
        DispatchQueue.global().async {
            Alamofire.request(urlString).responseJSON{ (response) in
                
                if let data : Dictionary<String,Any>  = response.result.value as? Dictionary<String, AnyObject> {
                    let json = JSON(data)
                    print(json)
                    
                }
            }
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
