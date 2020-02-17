

import Foundation
import SDWebImage
import UIKit

@IBDesignable
class CustomImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}

class Helper: NSObject {
  
  // MARK: - Download Image
  class func downloadImage(_ strImagURL: String?, completion: @escaping(UIImage?, Error?) -> Void) {
      SDWebImageManager.shared.loadImage(with: URL(string: "https://dev.akcess.io:3000/\((strImagURL)!)"), options: [.highPriority], progress: { (receivedSize, expectedSize,url) in
          
      }) { (image, data, error, cacheType, finished, url) in
          if finished == true {
              completion(image,error)
          }
      }
  }
  
}
