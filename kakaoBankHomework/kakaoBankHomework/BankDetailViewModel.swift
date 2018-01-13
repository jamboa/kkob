//
//  BankDetailViewModel.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 14..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import Foundation
import SwiftyJSON

struct BankTitleInfo {
    let titleIamgeUrl : String
    let trackName : String
    let trackContentRating: String
    let contentAdvisoryRating: String
    let averageUserCurrentRating : String
    let artistName : String
    let genres : String
    
    init() {
        self.titleIamgeUrl = ""
        self.trackName = ""
        self.trackContentRating = ""
        self.contentAdvisoryRating = ""
        self.averageUserCurrentRating = ""
        self.artistName = ""
        self.genres = ""
    }
    
    init(titleIamgeUrl : String,
         trackName : String,
         trackContentRating: String,
         contentAdvisoryRating: String,
         averageUserCurrentRating : String,
         artistName : String ,
         genres : String) {
        
        self.titleIamgeUrl = titleIamgeUrl
        self.trackName = trackName
        self.trackContentRating = trackContentRating
        self.contentAdvisoryRating = contentAdvisoryRating
        self.averageUserCurrentRating = averageUserCurrentRating
        self.artistName = artistName
        self.genres = genres
    }
}

struct BankNewFeatureInfo {
    let version : String
    let releaseDate : String
    let releaseNote: String
    
    init() {
        self.version = ""
        self.releaseDate = ""
        self.releaseNote = ""
    }
    
    init(version : String,
         releaseDate : String,
         releaseNote: String) {
        self.version = version
        self.releaseDate = releaseDate
        self.releaseNote = releaseNote
    }
}

struct BankPreviewInfo {
    let screenShotUrls : [String]
    
    init() {
        screenShotUrls = Array(repeating : "" , count : 3)
    }
    
    init(screenShotUrls : [String]) {
        self.screenShotUrls = screenShotUrls
    }
    
}

struct BankDescriptionInfo {
    let description : String
    
    init() {
        self.description = ""
    }
    
    init(description : String) {
        self.description = description
    }
    
}

class BankDetailViewModel {
    
    private var appData : JSON? = nil
    
    func getData(idString : String, completion : @escaping () -> Void) {
        let urlString =  "https://itunes.apple.com/lookup?id=\(idString)&country=kr"
        let _ = Bernoice.shared.getByRemote(url: urlString, cached: false ,completion:{[weak self] (data) in
            self?.appData = JSON(data)
            DispatchQueue.main.async {
                completion()
            }
        })
    }
    
    func getBankTitleInfo() -> BankTitleInfo {
        guard let appDataUnwrapped = self.appData else {
            return BankTitleInfo()
        }

        let arrayResult = appDataUnwrapped["results"].arrayValue
        let data = arrayResult[0]
        let genresStringArray = data["genres"].arrayValue.map { $0.stringValue}
        let genresString = genresStringArray.joined(separator: ",")
        
        return BankTitleInfo(titleIamgeUrl: data["artworkUrl100"].stringValue,
                             trackName: data["trackName"].stringValue,
                             trackContentRating: data["trackContentRating"].stringValue,
                             contentAdvisoryRating: data["contentAdvisoryRating"].stringValue,
                             averageUserCurrentRating: data["averageUserRatingForCurrentVersion"].stringValue,
                             artistName: data["artistName"].stringValue,
                             genres: genresString)
    }
    
    func getNewFeatureInfo() -> BankNewFeatureInfo {
        guard let appDataUnwrapped = self.appData else {
            return BankNewFeatureInfo()
        }
        
        let arrayResult = appDataUnwrapped["results"].arrayValue
        let data = arrayResult[0]
        
        return BankNewFeatureInfo(version: data["version"].stringValue,
                                  releaseDate: dateToDate(date: data["releaseDate"].stringValue),
                                  releaseNote: data["releaseNotes"].stringValue)
    }
    
    func getPreviewInfo() -> BankPreviewInfo {
        guard let appDataUnwrapped = self.appData else {
            return BankPreviewInfo()
        }
        let arrayResult = appDataUnwrapped["results"].arrayValue
        let data = arrayResult[0]
        let screenshotUrls = data["screenshotUrls"].arrayValue.map { $0.stringValue}
        return BankPreviewInfo(screenShotUrls: screenshotUrls)
    }
    
    func getDescriptionInfo() -> BankDescriptionInfo {
        guard let appDataUnwrapped = self.appData else {
            return BankDescriptionInfo()
        }
        let arrayResult = appDataUnwrapped["results"].arrayValue
        let data = arrayResult[0]
        return BankDescriptionInfo(description: data["description"].stringValue)
    }
    
    func numberOfInfoType() -> Int {
        return 4
    }
    
    private func dateToDate(date : String) -> String {
        let DateFormatterInput = DateFormatter()
        DateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateDate = DateFormatterInput.date(from: date)
        let DateFormatterOutput = DateFormatter()
        DateFormatterOutput.dateFormat = "yyyy-MM-dd"
        let dateString = DateFormatterOutput.string(from: dateDate!)
        
        return dateString
    }
    
    
    
}
