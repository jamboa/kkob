//
//  BankAppDetailTableViewController.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 8..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import UIKit
import SwiftyJSON


class BankAppDetailTableViewController: UITableViewController {

    public var idString : String = ""
    
    private let bankDetailViewModel : BankDetailViewModel = BankDetailViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        bankDetailViewModel.getData(idString: idString) { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bankDetailViewModel.numberOfInfoType()
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch(indexPath.row) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleViewCell", for: indexPath) as! TitleViewCell
            cell.updateInfo(bankTitleInfo: bankDetailViewModel.getBankTitleInfo())
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "newFeatureViewCell", for: indexPath) as! NewFeatureViewCell
            cell.updateInfo(bankNewFeatureInfo: bankDetailViewModel.getNewFeatureInfo())
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "previewCell", for: indexPath) as! PreviewCell
            cell.updateInfo(bankPreviewInfo: bankDetailViewModel.getPreviewInfo())
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionViewCell", for: indexPath) as! DescriptionViewCell
            cell.updateInfo(bankDescriptionInfo: bankDetailViewModel.getDescriptionInfo())
            return cell
        default:
            return UITableViewCell()

        }

        
    }


}
