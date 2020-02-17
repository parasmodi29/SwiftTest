

import UIKit

class UserDetailVC: UIViewController {
  
  /**
   @IBOutlets
   */
  @IBOutlet weak var imgvProfilePic: CustomImageView!
  
  @IBOutlet weak var lblFirstName: UILabel!
  
  @IBOutlet weak var lblLastName: UILabel!
  
  @IBOutlet weak var lblEmail: UILabel!
  
  @IBOutlet weak var lblPhone: UILabel!
  
  
  /**
   @vars
  */
  var dicUser: UserData?
  
  /**
   ViewDidLoad
   */
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.setupView()
  }
  
  /**
   setupView
   */
  
  func setupView() {

    guard dicUser != nil else {
      return
    }
    
    if let url = dicUser?.proPic {
      
      DispatchQueue.global(qos: .background).async {
        Helper.downloadImage(url) { (image, error) in
          DispatchQueue.main.async {
            
            if error == nil {
              self.imgvProfilePic.image = image
            } else{
              self.imgvProfilePic.image = UIImage(named: "ic_placeholder")
            }
          }
        }
      }
    }
    
    if let firstName = dicUser?.firstName {
    
      self.lblFirstName.text = String(format: "FirstName: %@", firstName)
    }
    
    if let lastName = dicUser?.lastName {
      self.lblLastName.text = String(format: "LastName: %@", lastName)
    }
    
    if let email = dicUser?.email {
      
      if let value = email.value {
        self.lblEmail.text =   String(format: "Email: %@", value)
      }
      
    }
    
    if let countryCode = dicUser?.countryDialCode {
      
      if let phoneNumber = dicUser?.phone?.value {
        
        self.lblPhone.text =   String(format: "Phone: %@-%@", countryCode,String(phoneNumber))
      }
      
    }
  }
}
