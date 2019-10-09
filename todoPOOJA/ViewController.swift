//
//  ViewController.swift
//  todoPOOJA
//
//  Created by Student-12 on 07/10/19.
//  Copyright © 2019 felix. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var EmpIdArray = [String]()
    var EmpNameArray = [String]()
    
    static let SharedView = ViewController()
    var count = 0
    
    
    @IBOutlet var myTableViewOutl: UITableView!
    
    @IBAction func AddButton(_ sender: UIBarButtonItem) {
        
        
        let next = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        ViewController.SharedView.count = 1
        
        navigationController?.pushViewController(next, animated: true)
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmpIdArray.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = EmpIdArray[indexPath.row] + "      " + EmpNameArray[indexPath.row]
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let next1 = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        ViewController.SharedView.count = 2
        
        navigationController?.pushViewController(next1, animated: true)
        
        next1.id = EmpIdArray[indexPath.row]
       next1.name = EmpNameArray[indexPath.row]
        
    }
    
    func ShowMyTable()
    {
        EmpIdArray = [String]()
        EmpNameArray = [String]()
        
        
        let selectQuery = "select * from Employee"
        
        let selectAll = DBWrapper.sharedobject.SelectAllTask(query: selectQuery)
        
        EmpIdArray = DBWrapper.sharedobject.EmpId
        EmpNameArray = (selectAll as? [String])!
        
        print(EmpIdArray)
        print(EmpNameArray)
        
        if(EmpNameArray.count >= 0 )
        {
            myTableViewOutl.reloadData()
        }
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        ShowMyTable()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShowMyTable()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

