//
//  RegisterUserController.swift
//  Online_Reader
//
//  Created by Admin on 24/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class RegisterUserController: BaseViewController {

    
    @IBOutlet weak var editFull_Name: UITextField!
    
    @IBOutlet weak var editUser_name: UITextField!
    
    @IBOutlet weak var edit_email: UITextField!
     @IBOutlet weak var editPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func onRegister() {
        if editFull_Name.text!.count == 0 {
                     showError(message: "Name is mandatory")
                 } else if editUser_name.text!.count == 0 {
                     showError(message: "User Name is mandatory")
                 } else if edit_email.text!.count == 0 {
                     showError(message: "Email is mandatory")
                 } else if editPassword.text!.count == 0 {
                     showError(message: "Password is mandatory")
                 } else {
                     
                     let body = [
                         "full_name": editFull_Name.text!,
                         "User_name":editUser_name.text!,
                         "email": edit_email.text!,
                         "password": editPassword.text!
                     ]
                     
                     makeApiCall(path: "/users/register",
                                 completionHandler: { result in
                                 
                                     let alert = UIAlertController(title: "Success", message: "Registered a new user. Please login now.", preferredStyle: .alert)
                                     alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                         //self.navigationController?.popViewController(animated: true)
                                        self.dismiss(animated: true, completion: nil)
                                     }))
                                     self.present(alert, animated: true, completion: nil)
                                         
                                 }, method: .post, parameters: body)
                        }
                     
    
             }
    
    @IBAction func onCancel() {
        dismiss(animated: true, completion: nil)
    }
    

}
