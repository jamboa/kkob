//
//  PreviewCell.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 9..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import UIKit

class PreviewCell: UITableViewCell {

    @IBOutlet weak var preview1: UIImageViewCached!
    @IBOutlet weak var preview2: UIImageViewCached!
    @IBOutlet weak var preview3: UIImageViewCached!
    @IBOutlet weak var preview4: UIImageViewCached!
    @IBOutlet weak var preview5: UIImageViewCached!
    
    
    func updateInfo(screenshotUrls : [String] ) {
        
        let previews = [preview1,preview2,preview3,preview4,preview5]
        
        for (preview,screenshotUrl) in zip(previews,screenshotUrls) {
            let _ = preview?.applyRounded().downloadImage(url: screenshotUrl)
        }
        
    }
}
