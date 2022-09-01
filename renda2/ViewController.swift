//
//  ViewController.swift
//  renda2
//
//  Created by 原田摩利奈 on 8/29/22.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var timerLabel: UILabel!
    
    var count: Int = 0
    var timer = Timer()
    var time = 5
    
    let firestore = Firestore.firestore()
    var ref: DocumentReference?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timerLabel.text = String(time)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.time -= 1
            self.timerLabel.text = String(self.time)
            if self.time == 0 {
                timer.invalidate()
                self.performSegue(withIdentifier: "clear", sender: nil)
                //                if self.count >= 30 {
                //                    self.performSegue(withIdentifier: "clear", sender: nil)
                //
                //                } else {
                //                    self.performSegue(withIdentifier: "not", sender: nil)
                //                }
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clear" {
            let resultView = segue.destination as! ResultViewController
            resultView.result = count
        }
        
        firestore.collection("counts").document("share").setData(["count": count]) { err in
            if let err = err {
                print("送信できませんでした: \(err)")
            }
        }
        
        ref = firestore.collection("count").addDocument(data: ["count": count]) { err in
            if let err = err {
                print("送信できませんでした: \(err)")
            }
        }
        
            
//            firestore.collection("count").document("share").addDocument(["count": count]) { err in
//            if let err = err {
//                print("送信できませんでした: \(err)")
//            }
//        }
    }
    
    @IBAction func tapButton(){
        count = count + 1
        label.text = String(count)
    }
    
    //    func countDown() {
    //        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
    //                  self.time -= 1
    //                  self.timerLabel.text = String(self.time)
    //        })
    //    }
    
}

