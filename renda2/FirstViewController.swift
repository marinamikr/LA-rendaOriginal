//
//  FirstViewController.swift
//  renda2
//
//  Created by 原田摩利奈 on 8/29/22.
//

import UIKit
import Firebase
import FirebaseFirestore

class FirstViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var maxLabel: UILabel!
    let saveDate: UserDefaults = UserDefaults.standard
    
    let firestore = Firestore.firestore()
    var ref: DocumentReference?
    var max: Int = 30

    override func viewDidLoad() {
        super.viewDidLoad()

        maxLabel.text = String(max)
        firestore.collection("counts").document("share").addSnapshotListener { snapshot, error in
                 if error != nil {
                     print("エラーが発生しました")
                     print(error)
                     return
                 }
                 let data = snapshot?.data()
                 if data == nil {
                     print("データがありません")
                     return
                 }
                 let count = data!["count"] as? Int
                 if count == nil {
                     print("countという対応する値がありません")
                     return
                 }
                 self.label.text = String(count!)
             }
        print("今ここ")
        // Do any additional setup after loading the view.
    }
    @IBAction func segue(segue: UIStoryboardSegue) {
        let firstView = segue.source as? ResultViewController
        max = (firstView?.resultArray[0])!
        maxLabel.text = String(max)
    }
    

}
