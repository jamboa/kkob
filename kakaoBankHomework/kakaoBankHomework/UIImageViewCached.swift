import Foundation
import UIKit

class UIImageViewCached : UIImageView
{
    var urlSessionDataTask : URLSessionDataTask?
    
    func applyRounded() -> UIImageViewCached {
        DispatchQueue.main.async() { [weak self] in
            self?.layer.cornerRadius = 15.0
            self?.clipsToBounds = true
        }
        return self
    }
    
    func downloadImage(url:String) {
        urlSessionDataTask = Bernoice.shared.getByRemote(url: url,cached: true){ [weak self] data in
            DispatchQueue.main.async() { [weak self] in
                self?.contentMode = UIViewContentMode.scaleAspectFill
                self?.image = UIImage(data: data)
            }
        }
    }
    
    func cancelDownloadImage() {
        urlSessionDataTask?.cancel()
    }
}
