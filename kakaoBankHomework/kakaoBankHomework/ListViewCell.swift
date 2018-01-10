//
//  ListViewCell.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 9..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageViewCached!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var screenShotImage: UIImageViewCached!
    @IBOutlet weak var screenShotImage2: UIImageViewCached!
    @IBOutlet weak var screenShotImage3: UIImageViewCached!
//    var dataTask : [URLSessionDataTask?]
    
    func updateInfo(iconImageUrl : String,
                    title : String,
                    subTitle: String,
                    idString : String) {
        

        let _ = iconImage.applyRounded().downloadImage(url: iconImageUrl)
        titleLabel.text = title
        subTitleLabel.text = subTitle
    
        let urlString =  "https://itunes.apple.com/lookup?id=\(idString)&country=kr"
        
        DispatchQueue.global().async {
            
            let _ = Bernoice.shared.getByRemote(url: urlString,completion:{(data) in
                
                    let appData = JSON(data)
                    let arrayResult = appData["results"].arrayValue
                    let data = arrayResult[0]
                    let screenshotUrls = data["screenshotUrls"].arrayValue.map { $0.stringValue}
                    
                    DispatchQueue.main.async {
                        
                        let screenshots = [self.screenShotImage,self.screenShotImage2,self.screenShotImage3]
                        
                        for (screenshot,screenshotUrl) in zip(screenshots,screenshotUrls) {
                            screenshot?.applyRounded().downloadImage(url: screenshotUrl)
                        }
                        
                    }

            })
            
        }
        
        
        
    }
    
    func cancelUpdating() {
        let screenshots = [self.screenShotImage,self.screenShotImage2,self.screenShotImage3]
        for screenshot in screenshots {
            screenshot?.cancelDownloadImage()
        }
        
    }
}
