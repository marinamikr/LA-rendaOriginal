//
//  ResultViewController.swift
//  renda2
//
//  Created by 原田摩利奈 on 8/29/22.
//

import UIKit
import Firebase
import FirebaseCore

class ResultViewController: UIViewController {
    
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    let firestore = Firestore.firestore()
    var ref: DocumentReference?
    
    var result: Int = 0
    var resultArray1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
    var resultArray: [Int] = []
    let saveDate: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getResult()
        self.table.reloadData()
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")

        label.text = String(result)
        
        if result >= 30 {
            resultLabel.text = "clear!!"
        } else {
            resultLabel.text = "残念..."
        }
//        resultArray.sort { $0 > $1 }
        print("今da")
    }
    
    @IBAction func reloadButton() {
        self.table.reloadData()
        print("リロード")
    }
    
    @IBAction func back() {
        saveDate.set(result, forKey: "result")
        print("保存した")
//        let firstView = segue.source as! FirstViewController
//        firstView.max = resultArray[0]
        performSegue(withIdentifier: "back", sender: nil)
        print("now")
    }
    
    func getResult() {
        firestore.collection("count1").getDocuments() { [self] (querySnapshot, error) in
                        if let error = error {
                            print("ドキュメントの取得に失敗しました:", error)
                        } else {
                            print("ドキュメントの取得に成功しました")
                            for document in querySnapshot!.documents {
                                let data = document.data()["count"] as? Int
                                print("わけわかめ")
                                //取得したデータに対しての処理を書く
                                self.resultArray.append(data!)
                                self.resultArray.sort { $0 > $1 }
                                print(data)
                                print("\(resultArray)これ")
                                }
                            }
        }
    }
    
}

extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        cell.label?.text = String(resultArray[indexPath.row])
        cell.rankLabel?.text = String(resultArray1[indexPath.row]) + "位"
        print(cell.textLabel?.text)
        print(resultArray[0])
        return cell
    }
    
}
    
