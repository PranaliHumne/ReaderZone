//
//  ViewController.swift
//  Online_Reader
//
//  Created by Admin on 24/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: BaseViewController {

    @IBOutlet weak var editUser_name: UITextField!
    @IBOutlet weak var edit_Password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logIn() {
        if editUser_name.text!.count == 0 {
                   showError(message: "Email is mandatory")
               } else if edit_Password.text!.count == 0 {
                   showError(message: "Password is mandatory")
               } else {
                   let body = [
                       "User_name": editUser_name.text!,
                       "password": edit_Password.text!
                   ]
                   
                   let url = "http://172.18.5.15:4000/users/login"
        AF.request(url, method: .post, parameters: body,encoding:JSONEncoding())
                       .responseJSON(completionHandler: { response in
                           let result = response.value as! [String: Any]
                           let status = result["status"] as! String
                           if status == "Success" {
                               
                               let data = result["data"] as! [String: Any]
                               let id = data["User_id"] as! Int
                               let name = data["User_name"] as! String
                            
                                print("\(name)")
                               // persist the userId in user defaults
                               let userDefaults = UserDefaults.standard
                               userDefaults.setValue(id, forKey: "User_id")
                               userDefaults.setValue(name, forKey: "User_name")
                               userDefaults.synchronize()
                               
//                               let transactionsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeViewController")
//                               self.navigationController?.pushViewController(transactionsVC, animated: true)
                               
                           } else {
                               self.showError(message: "Invalid email or pasword")
                           }
                       })
               }
    }
    
    @IBAction func forgotPassword() {
    }
    @IBAction func registerUser() {
    }
}

