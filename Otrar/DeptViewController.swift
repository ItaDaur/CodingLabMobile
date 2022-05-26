//
//  DeptViewController.swift
//  Otrar
//
//  Created by Dauren Sarsenov on 16.05.2022.
//

import UIKit

class DeptViewController: UIViewController {

    @IBOutlet weak var labelNumber: UILabel!
    
    
    @IBAction func ProgressSlider(_ sender: UISlider){
        labelNumber.text = String(Int(sender.value)*100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
