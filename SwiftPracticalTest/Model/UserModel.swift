
import Foundation

struct UsersDetail: Codable {
  
  var success: Bool
  var msg: String?
  var data: [UserData]
}


struct UserData: Codable {
  var _id: String
  var uuidObj: UserUUID?
  var isVerifier: Bool
  var isViewer: Bool
  var isUser: Bool
  var subusers: [Subusers]
  var isUserNameVerified: Bool
  var isAccessIdVerified: Bool
  var isProfilePicVerified: Bool
  var isVerified: Bool
  var CbeStatus: String?
  var accounts: [UserAccount]
  var contacts: [UserContacts]
  var dateCreated: String?
  var dateModified: String?
  var profileFields: [UserprofileFields]
  var email: UserEmail?
  var phone: UserPhone?
  var firstName: String?
  var lastName: String?
  var countryCode: String?
  var countryDialCode: String?
  var isCbe: Bool
  var uuid: String?
  var pvtKey: String?
  var akcessId: String?
  var accountId: String?
  var __v: Int?
  var passCode: String?
  var proPic: String?
}

struct UserUUID: Codable {
  var createdDate: String?
}

struct Subusers: Codable {
  
}

struct UserAccount: Codable {

}

struct UserContacts: Codable {

  var permission: UserPermission?
  var status: String?
  var _id: String?
  var contact: String?
  var date: String?
}

struct UserPermission: Codable {
  
  var fatherName:Bool
  var motherName:Bool
  var birthDate:Bool
  var birthCountry:Bool
  var nationality:Bool
  var IDNumber:Bool
  var governorate:Bool
  var recordNumber: Bool
  var gender: Bool
  var status: Bool
  var bloodType: Bool
  var phoneNumber: Bool
  var homeAddres: Bool
  var passport: Bool
  var company: Bool
  var jobTitle: Bool
  var workAddress: Bool
}

struct UserprofileFields: Codable {
  
  var isVisible: Bool
  var isVerified: Bool
  var isDelete: Bool
  var _id: String?
  var name: String?
  var value: String?
  var createdDate: String?
}

struct UserEmail: Codable {
  
  var isVerified: Bool
  var isVisible: Bool
  var _id: String?
  var value: String?
}

struct UserPhone: Codable {
  
  var isVerified: Bool
  var isVisible: Bool
  var _id: String?
  var value: Int?
}
