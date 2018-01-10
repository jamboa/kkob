//
//  BankAppDetailTableViewController.swift
//  kakaoBankHomework
//
//  Created by yoojonghyun on 2018. 1. 8..
//  Copyright © 2018년 yoojonghyun. All rights reserved.
//

import UIKit
import SwiftyJSON


class BankAppDetailTableViewController: UITableViewController {

    public var idString : String = ""
    private var appData : JSON? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let urlString =  "https://itunes.apple.com/lookup?id=\(self.idString)&country=kr"
        
        DispatchQueue.global().async {
            
            let _ = Bernoice.shared.getByRemote(url: urlString,completion:{[weak self] (data) in
                
                self?.appData = JSON(data)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let appDataWithData = self.appData else {
            return UITableViewCell()
        }
        
        let arrayResult = appDataWithData["results"].arrayValue
        let data = arrayResult[0]
        
        switch(indexPath.row) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleViewCell", for: indexPath) as! TitleViewCell
            
            let genresStringArray = data["genres"].arrayValue.map { $0.stringValue}
            let genresString = genresStringArray.joined(separator: ",")
            
            cell.updateInfo(titleIamgeUrl: data["artworkUrl100"].stringValue,
                            trackName: data["trackName"].stringValue,
                            trackContentRating: data["trackContentRating"].stringValue,
                            contentAdvisoryRating: data["contentAdvisoryRating"].stringValue,
                            averageUserCurrentRating: data["averageUserRatingForCurrentVersion"].stringValue,
                            artistName: data["artistName"].stringValue,
                            genres: genresString)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "newFeatureViewCell", for: indexPath) as! NewFeatureViewCell
            
            cell.updateInfo(version: data["version"].stringValue,
                            releaseDate: data["releaseDate"].stringValue,
                            releaseNote: data["releaseNotes"].stringValue)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "previewCell", for: indexPath) as! PreviewCell
            let screenshotUrls = data["screenshotUrls"].arrayValue.map { $0.stringValue}
            cell.updateInfo(screenshotUrls: screenshotUrls)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionViewCell", for: indexPath) as! DescriptionViewCell
            cell.updateInfo(description: data["description"].stringValue)
            return cell
        default:
            return UITableViewCell()

        }

        
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
