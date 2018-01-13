//
//  NewFeatureCell.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 9..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import UIKit

class NewFeatureViewCell: UITableViewCell {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var latestUpdate: UILabel!
    @IBOutlet weak var releaseNotes: UILabel!
    @IBOutlet weak var releaseNotesHeight: NSLayoutConstraint!

    
    func updateInfo(bankNewFeatureInfo : BankNewFeatureInfo) {
        
        self.versionLabel.text = bankNewFeatureInfo.version
        self.latestUpdate.text = bankNewFeatureInfo.releaseDate
        self.releaseNotes.setStringWithLineSpacing(string: bankNewFeatureInfo.releaseNote, lineSpace: 12)
        
    }

}
