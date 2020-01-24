//
//  HomeViewController.swift
//  Online_Reader
//
//  Created by Admin on 24/01/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class HomeViewController: BaseViewController {

    var transactions: [Books] = []
   
    @IBOutlet weak var UiCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("home")
        UiCollection.dataSource = self as! UICollectionViewDataSource
        UiCollection.delegate = self as! UICollectionViewDelegate
    }
    override func viewDidAppear(_ animated: Bool) {
            loadTransactions()
            print("view")
        }
        
        func loadTransactions() {
                    transactions.removeAll()
                    makeApiCall(path: "/books",
                                completionHandler: {result in

                            let tempTransactions = result as! [[String: Any]]
                            for object in tempTransactions {
                         //  let product_id = object["product_id"] as! Int
        //                        let category_id = object["category_id"] as! Int
                                let book_id = object["book_id"] as! Int
                                let book_name = object["book_name"] as! String
                                let auther_name = object["auther_name"] as! String
                                let part = object["part"] as! Int
                                let publish_date = object["publish_date"] as! String
                                let rating = object["rating"] as! Int
                                let status = object["status"] as! String
                                let descripation = object["descripation"] as! String
                                let thumbnail = object["thumbnail"] as! String
                               // let bookFile = object["bookFile"] as! String
                                //let likes = object["likes"] as! Int
                                
                                let books = Books(book_id: book_id, book_name: book_name,auther_name: auther_name,part : part,publish_date : publish_date, rating : rating,status : status,descripation:descripation,thumbnail : thumbnail )
                                self.transactions.append(books)
                                print("\(self.transactions)")
                                print("\(books)")
                            }
                     self.UiCollection.reloadData()
                    })

               
            }

}


extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UiCollection.dequeueReusableCell(withReuseIdentifier: "bookcell", for: indexPath)

        
        let labelbookName = cell.viewWithTag(2) as! UILabel
        var thumbnail = cell.viewWithTag(1) as! UIImageView
        let transaction = transactions[indexPath.row]
        labelbookName.text = transaction.book_name
        let url1 = URL(string:"http://172.18.5.15:4000/\(transaction.thumbnail)")
        print("http://172.18.5.110:4000/\(transaction.thumbnail)")
        thumbnail.kf.setImage(with: url1)
        
        return cell
    }
}

extension HomeViewController:UICollectionViewDelegate {
    
}
