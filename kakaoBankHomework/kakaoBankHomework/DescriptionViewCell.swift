//
//  descriptionViewCell.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 9..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import UIKit

class DescriptionViewCell: UITableViewCell {
    @IBOutlet weak var desciptionLabel: UILabel!
    
    private func updateInfo(description : String) {
        self.desciptionLabel.setStringWithLineSpacing(string: description, lineSpace: 12)
    }
    
    func updateInfo(bankDescriptionInfo : BankDescriptionInfo) {
        self.updateInfo(description: bankDescriptionInfo.description)
    }
    
    
}
