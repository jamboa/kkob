//
//  TitleViewCell.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 8..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import UIKit

class TitleViewCell: UITableViewCell {

    @IBOutlet weak var titleImage: UIImageViewCached!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTItleLabel: UILabel!
    @IBOutlet weak var evaluationScore: UILabel!
    @IBOutlet weak var evaluationNumber: UILabel!
    @IBOutlet weak var appRank: UILabel!
    @IBOutlet weak var appGenre: UILabel!
    @IBOutlet weak var ageLimit: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var urlSessionDataTask : URLSessionDataTask?

    func updateInfo(titleIamgeUrl : String,
                    trackName : String,
                    trackContentRating: String,
                    contentAdvisoryRating: String,
                    averageUserCurrentRating : String,
                    artistName : String ,
                    genres : String) {
        
        self.titleLabel.text = trackName
        self.subTItleLabel.text = artistName
        self.evaluationScore.text = averageUserCurrentRating
        self.evaluationNumber.text = "평가"
        self.appRank.text = "-"
        self.appGenre.text = genres
        self.ageLimit.text = contentAdvisoryRating
        
        self.titleImage.applyRounded().downloadImage(url: titleIamgeUrl)

        
    }
    
    func cancelTask() {
        if let task = urlSessionDataTask {
            task.cancel()
        }
    }

}
