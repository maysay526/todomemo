//
//  ViewController.swift
//  aaa
//
//  Created by 吉川明成 on 2017/02/16.
//  Copyright © 2017年 mycompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate, UITextFieldDelegate{

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var array: Array<String> = []
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        if let todos = userDefaults.object(forKey: "array") {
            array = todos as! Array<String>
        }
        let myTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.close(_ :)))
        // イベントが入ったUITapGestureRecognizerをインスタンス化
        
        
        self.tableView.isUserInteractionEnabled = true
        // タップを検知することができるようにする
        
        self.tableView.addGestureRecognizer(myTap)
        // labelにイベントを追加
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    func close (_ sender: UITapGestureRecognizer) {
        self.textField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if array == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath)
            cell.textLabel?.text = array[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // Deleteボタン.
        let myDeleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            
            tableView.isEditing = false
            self.array.remove(at: indexPath.row)
            self.userDefaults.set(self.array, forKey: "array")
            self.userDefaults.synchronize()
            tableView.reloadData()
        
            
        }
        myDeleteButton.backgroundColor = UIColor.red
        
        return [myDeleteButton]
        
    }
    

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    @IBAction func button(_ sender: Any) {
        if  "" != textField.text {
           let text =  textField.text
        array.append(text!)
        print(array)
        
        userDefaults.set(array, forKey: "array")
        userDefaults.synchronize()
        tableView.reloadData()
        
        
        
        
        textField.text = nil
        }
    }

}

