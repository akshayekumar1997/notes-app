//
//  ShowVC.swift
//  notes app
//
//  Created by SUMSKAR PC on 05/05/24.
//

import UIKit

class ShowVC: UIViewController {
   
    @IBOutlet weak var lbltxt: UILabel!
    var label:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbltxt.text=label
       
    }
    

   

}
