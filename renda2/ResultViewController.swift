//
//  ResultViewController.swift
//  renda2
//
//  Created by 原田摩利奈 on 8/29/22.
//

import UIKit
import Firebase
import FirebaseCore

class ResultViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    let firestore = Firestore.firestore()
    var ref: DocumentReference?
    
    var result: Int = 0
    //    var resultArray = [30, 35, 60, 24, 31, 20, 30, 31, 20]
    var resultArray: [Int] = []
    let saveDate: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        label.text = saveDate.object(forKey: "result") as? String
        //
        //        let value = UserDefaults.standard.array(forKey: "result") as! [String]
        //        print(value)
        //        resultArray = value
        //        saveDate.array(forKey: "resu")
        table.dataSource = self
        
        label.text = String(result)
        
        if result >= 30 {
            resultLabel.text = "clear!!"
        } else {
            resultLabel.text = "残念..."
        }
        getCount()
//        resultArray.sort { $0 > $1 }
        print("今")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func back() {
        saveDate.set(result, forKey: "result")
        print("保存した")
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        //        self.dismiss(animated: true, completion: nil)
        //        self.presentingViewController?.dismiss(animated: true, completion: nil)
        print("now")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = self.resultArray[indexPath.row] as? String
        return cell!
    }
    
    func getCount() {
        firestore.collection("count1").getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("ドキュメントの取得に失敗しました:", error)
            } else {
                print("ドキュメントの取得に成功しました")
                //                for document in querySnapshot!.documents {
                //                    let data = document.data()
                //
                //                    resultArray.append(data)
                
                
//                self.resultArray = querySnapshot!.documents.map { document in
//                    let data = testData(document: document)
//                    let data = document.data()
//                    return data["count"] as! Int
                    print(self.resultArray)
//                    print(data)

                }
            }
            self.resultArray.sort { $0 > $1 }
    }
}


//querySnapshotにドキュメントデータが配列になって入っている。
//                 <ここから先が後編>


class testData: NSObject {
    var uid: String?
    var data1: String?
    var data2: Int?
    
    
    //init()について解説置いています。
    
    init(document: QueryDocumentSnapshot) {
        self.uid = document.documentID
        let Dic = document.data()
        self.data1 = Dic["data1"] as? String
        self.data2 = Dic["data2"] as? Int
    }
}
