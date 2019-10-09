//
//  AddViewController.swift
//  todoPOOJA
//
//  Created by Student-12 on 07/10/19.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    
    var id = String()
    var name = String()
    
    
    
    @IBOutlet var InfoOutl: UILabel!
    @IBOutlet var SaveOutl: UIButton!
    @IBOutlet var DeleteOutl: UIButton!
    @IBOutlet var addTextField: UITextField!
    
    @IBOutlet var addTextField2: UITextField!
    
    @IBAction func AddButton(_ sender: UIButton) {
        
        if(SaveOutl.titleLabel?.text == "ADD")
        {
            
        let insertQuery = "insert into Employee(EmpId,EmpName) values('\(addTextField.text!)','\(addTextField2.text!)')"
        let isSuccess = DBWrapper.sharedobject.executeQuery(query: insertQuery)

        if(isSuccess)
        {
            print("inserted Record..")
        }
        else
        {
            print("Record Not Inserted..")
        }
        addTextField.text = ""
        addTextField2.text = ""
        
    }
        else
        {
            let updateQuery = "update Employee set EmpName = '\(addTextField2.text!)' where EmpId = '\(addTextField.text!)'"
            let isSuccess = DBWrapper.sharedobject.executeQuery(query: updateQuery)
         
            if(isSuccess)
            {
                print("Update Successfully...")
            }
            else
            {
                print("Update failed...")
            }
            addTextField.text = ""
            addTextField2.text = ""
            
        }
    }
   
    
    
    @IBAction func DeleteBtn(_ sender: UIButton) {
        
        let deleteQuery = "delete from Employee where EmpId = '\(addTextField.text!)'"
        let isSuccess = DBWrapper.sharedobject.executeQuery(query: deleteQuery)
        
        if(isSuccess)
        {
            print("Delete Successfully...")
        }
        else
        {
            print("Delete Failed...")
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

       if(ViewController.SharedView.count == 1)
       {
        
        SaveOutl.setTitle("ADD", for: .normal)
        SaveOutl.titleLabel?.text = "ADD"
        DeleteOutl.isHidden  = true
        InfoOutl.isHidden = false
        }
        else
       {
        
        SaveOutl.setTitle("UPDATE", for: .normal)
        SaveOutl.titleLabel?.text = "UPDATE"
       addTextField.text = id
        addTextField.isEnabled = false
        addTextField2.text = name
        DeleteOutl.isHidden = false
        InfoOutl.text = "Update Employee Name"
        
        
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
