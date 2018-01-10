//
//  DictionaryExtension.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 7..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setStringWithLineSpacing(string : String, lineSpace : CGFloat) {
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle,
                                      value:paragraphStyle,
                                      range:NSMakeRange(0, attributedString.length))
        
        
        
        self.attributedText = attributedString;
    }

}

