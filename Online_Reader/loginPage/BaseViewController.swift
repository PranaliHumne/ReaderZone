//
//  BaseViewController.swift
//  Online_Reader
//
//  Created by Admin on 24/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func makeApiCall(path: String,  completionHandler: @escaping (Any?) -> Void, method: HTTPMethod = .get, parameters: Parameters? = nil) {
        let url = "http://172.18.5.15:4000" + path
        print("calling API: \(url)")
        AF.request(url, method: method, parameters: parameters,encoding:JSONEncoding())
            .responseJSON(completionHandler: { response in
                let result = response.value as! [String: Any]
                let status = result["status"] as! String
                if status == "Success" {
                    completionHandler(result["data"])
                } else {
                    print("Error while calling API: \(result["error"]!)")
                }
            })
    }

}
