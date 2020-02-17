
import UIKit

class UserListVC: UIViewController {
  
  /**
   @IBOutlet
   */
  @IBOutlet weak var tblView: UITableView!
  @IBOutlet weak var noDataView: UIView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  /**
   @vars
   */
  var arrUsers: [UserData] = []
  
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
    
    activityIndicator.startAnimating()
    self.tblView.register(UINib(nibName:"UserListTableViewCell", bundle:Bundle.main), forCellReuseIdentifier:"UserListCellID")
    self.tblView.estimatedRowHeight = 44.0
    self.tblView.rowHeight = UITableView.automaticDimension
    self.callAPIgetUsers()
  }
  
  /**
   Call API For Get Users
   */
  func callAPIgetUsers() {
    
    guard Connectivity.isConnectedToInternet() == true else {
      self.activityIndicator.stopAnimating()
      self.noDataView.isHidden = false
      let alertController = UIAlertController(title: "No Internet", message: "You are not connected to the Internet", preferredStyle: UIAlertController.Style.alert)
      
      let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) { (action) in
        self.dismiss(animated: true, completion: nil)
      }
      
      alertController.addAction(okAction)
      
      self.present(alertController, animated: true, completion: nil)
      return
    }
    
    let url =  APIhandler.shared.getURL(path: "api/admin/getusers", pathVariables:nil, queryParams:nil)
    
    APIhandler.shared.getReponseForRequest(requestURL: url, bodyPerameter: nil, methodName: .get) { (users, error) in
      
      self.activityIndicator.stopAnimating()
      
      guard error == nil else {
        return
      }
      
      guard users?.data.count != 0 else {
        self.noDataView.isHidden = false
        return
      }
      
      for objUser in (users?.data)! {
        self.arrUsers.append(objUser)
      }
      
      self.tblView.reloadData()
    }
    
    
    
  }
  
}


/**
 UITableViewDelegate, UITableViewDataSource
 */
extension UserListVC: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.arrUsers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let objCell = tableView.dequeueReusableCell(withIdentifier: "UserListCellID", for: indexPath) as? UserListTableViewCell else {
      return UITableViewCell()
    }
    
    objCell.configureCell(self.arrUsers[indexPath.row])
    
    return objCell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    if Connectivity.isConnectedToInternet() == true {
      
      let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
      let objUserDetailVC = storyBoard.instantiateViewController(withIdentifier: "UserDetailVC") as! UserDetailVC
      objUserDetailVC.dicUser = self.arrUsers[indexPath.row]
      let navVC = UINavigationController(rootViewController: objUserDetailVC)
      self.present(navVC, animated: true) {
        print("Open User Detail screen")
      }
      CFRunLoopWakeUp(CFRunLoopGetCurrent());
      
    }else {
      
      let alertController = UIAlertController(title: "No Internet", message: "You are not connected to the Internet", preferredStyle: UIAlertController.Style.alert)
      
      let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel) { (action) in
        self.dismiss(animated: true, completion: nil)
      }
      
      alertController.addAction(okAction)
      
      self.present(alertController, animated: true, completion: nil)
    }
    
    
  }
}
