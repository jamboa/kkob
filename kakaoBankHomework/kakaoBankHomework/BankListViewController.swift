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
    
    
    let bankListViewModel = BankListViewModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankListViewModel.numberOfBank()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listViewCell", for: indexPath) as! ListViewCell
        cell.cancelUpdating()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listViewCell", for: indexPath) as! ListViewCell
        cell.updateInfo(bankInfo : bankListViewModel.getBankInfo(index: indexPath.row))
        
        if indexPath.row > Int((Double(bankListViewModel.numberOfBank()) * 0.8)) {
            bankListViewModel.getList(from : bankListViewModel.numberOfBank(),count : 30) {[weak self] in
                self?.bankAppsTable.reloadData()
            }
            
        }
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let viewController = segue.destination as? BankAppDetailTableViewController {
            if let urlString = sender as? String {
                viewController.idString = urlString
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let data = bankListViewModel.getBankData(index: indexPath.row) else {
            return
        }
        performSegue(withIdentifier: "toBankAppDetail", sender: data["id"]["attributes"]["im:id"].stringValue)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        bankAppsTable.dataSource = self
        bankAppsTable.delegate = self
        
        bankListViewModel.getList(from : 0, count : 30) {[weak self] in
            self?.bankAppsTable.reloadData()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

