//
//  WriteVC.swift
//  notes app
//
//  Created by SUMSKAR PC on 05/05/24.
//

import UIKit

class WriteVC: UIViewController ,UITextFieldDelegate{
    var update:(()->Void)?
    
    @IBAction func save(_ sender: Any) {
        guard let textInput = textfield.text,!textInput.isEmpty else{
            return
        }
        guard let count   = UserDefaults().value(forKey: "count") as? Int else{return}
        let newCount =   count+1
        UserDefaults.standard.setValue(newCount, forKey: "count")
        print(count)
        UserDefaults.standard.setValue(textInput, forKey: "task_\(newCount)") 
        
        update?()
        navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var saveTask: UIButton!
    @IBOutlet weak var textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfield.delegate=self
        dismiss()
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        return true
    }
    func dismiss(){
        let recogniser=UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(recogniser)
    }
   @objc func dismissKeyboard(){
       view.endEditing(true)
    }
}
