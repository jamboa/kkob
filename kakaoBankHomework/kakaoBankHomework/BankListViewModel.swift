//
//  BankListViewModel.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 13..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import Foundation
import SwiftyJSON

struct BankSimpleInfo {
    var iconImageUrl : String
    var title : String
    var subTitle: String
    var idString : String
    
    
    init() {
        self.iconImageUrl = ""
        self.title = ""
        self.subTitle = ""
        self.idString = ""
    }
    
    init(iconImageUrl : String,title : String,subTitle: String,idString : String) {
        self.iconImageUrl = iconImageUrl
        self.title = title
        self.subTitle = subTitle
        self.idString = idString
    }
    
    func updateScreenShots(completion : @escaping ([String])->Void) {
        
        let urlString =  "https://itunes.apple.com/lookup?id=\(self.idString)&country=kr"
        
        let _ = Bernoice.shared.getByRemote(url: urlString, cached: false ,completion:{(data) in
            
            let appData = JSON(data)
            let arrayResult = appData["results"].arrayValue
            let data = arrayResult[0]
            let screenshotUrls = data["screenshotUrls"].arrayValue.map { $0.stringValue}
            
            completion(screenshotUrls)
        })
        
    }
}

class BankListViewModel {

    var banks : NSMutableArray = NSMutableArray()
    var numberOfList = 30
    
    func numberOfBank() -> Int {
        return banks.count
    }
    
    
    func getList(number : Int, completion:@escaping () -> Void) {
        let url = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=\(number)/genre=6015/json"
        
        let _ = Bernoice.shared.getByRemote(url: url, cached: false ,completion:{[weak self] (data) in
            let json = JSON(data)
            
            if let appArrays = (json["feed"]["entry"].array) , let this = self {
                let array = appArrays[(this.banks.count)..<(number)]
                self?.banks.addObjects(from: Array(array))
            }
            
            DispatchQueue.main.async {
                completion()
            }
        })
    }
    
    func getBankInfo(index : Int) -> BankSimpleInfo{
        guard let data = self.banks[index] as? JSON else {
            return BankSimpleInfo()
        }
        let iconArray = data["im:image"].arrayValue
        let iconImage = iconArray[2]["label"].stringValue
        
        return BankSimpleInfo(iconImageUrl: iconImage,
                        title: data["title"]["label"].stringValue,
                        subTitle: data["rights"]["label"].stringValue,
                        idString : data["id"]["attributes"]["im:id"].stringValue)
    }
    
    func getBankData(index : Int) -> JSON? {
        return banks[index] as? JSON
    }
    
    

    
}
