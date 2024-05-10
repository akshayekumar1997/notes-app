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
        guard let textInput = textfield.text, !textInput.isEmpty else { return }
           var count = UserDefaults.standard.integer(forKey: "count")
           count += 1
           UserDefaults.standard.set(count, forKey: "count")
           UserDefaults.standard.set(textInput, forKey: "task_\(count - 1)")
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
