//
//  ResultViewController.swift
//  renda2
//
//  Created by 原田摩利奈 on 8/29/22.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {
   
    
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    var result: Int = 0
    var resultArray = [30, 35, 60, 24, 31, 20, 30, 31, 20]
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
        cell?.textLabel?.text = String(resultArray[indexPath.row])
        return cell!
    }
    
}
