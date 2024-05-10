//
//  ViewController.swift
//  notes app
//
//  Created by SUMSKAR PC on 05/05/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var notes : [String]=[]
    
    @IBAction func add(_ sender: Any) {
        let writeVC=(storyboard?.instantiateViewController(withIdentifier: "write"))! as!WriteVC

        
        writeVC.update = {
            self.fetchnotes()
        }

        navigationController?.pushViewController(writeVC, animated: true)
    }
    @IBOutlet weak var addClicked: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate   = self
        tableView.dataSource = self
      


        setUserDefaults()
        fetchnotes()
        }
        func setUserDefaults(){
            if !UserDefaults.standard.bool(forKey: "setup"){
                UserDefaults.standard.setValue(true, forKey: "setup")
                UserDefaults.standard.setValue(0, forKey: "count")
        }
    }

    func fetchnotes(){
        DispatchQueue.main.async {
            self.notes.removeAll()
            guard let count = UserDefaults.standard.value(forKey: "count") as? Int else {
                print("Error: Unable to fetch count from UserDefaults")
                return
            }
            
            for i in 0..<count {
                if let task = UserDefaults.standard.value(forKey: "task_\(i)") as? String {
                    self.notes.append(task)
                } else {
                    print("Error: Unable to fetch task for index \(i) from UserDefaults")
                }
            }
            
            self.tableView.reloadData()
        }
    }
    

}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text=notes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let showVC =  storyboard?.instantiateViewController(withIdentifier: "show") as? ShowVC else {
              print("Error: Unable to instantiate showVC")
              return
          }
        let note=notes[indexPath.row]
        
        showVC.label = note
           navigationController?.pushViewController(showVC, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
               // Remove the note from UserDefaults
               UserDefaults.standard.removeObject(forKey: "task_\(indexPath.row)")

               // Shift notes indices in UserDefaults for notes after the deleted note
               let count = UserDefaults.standard.integer(forKey: "count")
               for i in (indexPath.row + 1)..<count {
                   if let task = UserDefaults.standard.value(forKey: "task_\(i)") as? String {
                       UserDefaults.standard.set(task, forKey: "task_\(i - 1)")
                   }
               }

               // Remove the last duplicated note entry
               UserDefaults.standard.removeObject(forKey: "task_\(count - 1)")

               // Update UserDefaults count
               UserDefaults.standard.set(count - 1, forKey: "count")

               // Update the notes array
               fetchnotes()
           }
    }
}
