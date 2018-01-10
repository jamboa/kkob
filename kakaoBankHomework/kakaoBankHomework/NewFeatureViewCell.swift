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
    
    func updateInfo(version : String,
                    releaseDate : String,
                    releaseNote: String) {
        
        self.versionLabel.text = version
        self.latestUpdate.text = dateToDate(date: releaseDate)
//        self.releaseNotes.text = releaseNote
        
        self.releaseNotes.setStringWithLineSpacing(string: releaseNote, lineSpace: 12)

    }
    
    
    func dateToDate(date : String) -> String {
        let DateFormatterInput = DateFormatter()
        DateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateDate = DateFormatterInput.date(from: date)
        let DateFormatterOutput = DateFormatter()
        DateFormatterOutput.dateFormat = "yyyy-MM-dd"
        let dateString = DateFormatterOutput.string(from: dateDate!)
        
        return dateString
    }
}
