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
    
    
    func updateInfo(bankInfo : BankSimpleInfo) {
        
        
        let _ = iconImage.applyRounded().downloadImage(url: bankInfo.iconImageUrl)
        titleLabel.text = bankInfo.title
        subTitleLabel.text = bankInfo.subTitle
        
        let screenshots = [screenShotImage,screenShotImage2,screenShotImage3]
        bankInfo.updateScreenShots {(index,data ) in
            screenshots[index]?.applyRounded().image = UIImage(data: data)
        }
    }
    
    func cancelUpdating() {
        let screenshots = [self.screenShotImage,self.screenShotImage2,self.screenShotImage3]
        for screenshot in screenshots {
            screenshot?.cancelDownloadImage()
        }
        
    }
}
