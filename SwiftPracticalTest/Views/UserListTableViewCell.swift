
import UIKit
import SDWebImage

class UserListTableViewCell: UITableViewCell {
  
  /**
   @IBOutlet
   */
  @IBOutlet weak var imgvUserPic: CustomImageView!
  @IBOutlet weak var lblUserName: UILabel!
  @IBOutlet weak var lblEmail: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
 
  /**
   Configure Cell
   */
  func configureCell(_ user: UserData) {
    
    if let firstName = user.firstName {
      
      if let lastName = user.lastName {
        self.lblUserName.text = String(format: "%@ %@", firstName,lastName)
      }else {
        self.lblUserName.text = firstName
      }
    }else {
      if let lastName = user.lastName {
        self.lblUserName.text = lastName
      }
    }
    
    if let email = user.email {
      
      if let value = email.value {
        self.lblEmail.text =  value
      }
    
    }
    
    
    if let url = user.proPic {
      
      DispatchQueue.global(qos: .background).async {
        Helper.downloadImage(url) { (image, error) in
          DispatchQueue.main.async {
            
            if error == nil {
              self.imgvUserPic.image = image
            } else{
              self.imgvUserPic.image = UIImage(named: "ic_placeholder")
            }
          }
        }
      }
    }
    
  }
}
