//
//  NotificationViewController.swift
//  Otrar
//
//  Created by Dauren Sarsenov on 08.06.2022.
//

import UIKit

class NotificationViewController: UIViewController {

    @IBOutlet var myNotButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myNotButton.backgroundColor = .blue
        myNotButton.setTitleColor(.white, for: .normal)
        myNotButton.setTitle("Show Alert", for: .normal)
        
    }
    
    @IBAction func didTapNotButton() {
        
        let customAlert = myAlert()
        customAlert.showAlert(with: "Hello World", message: "This is my custom alert that is shown.", on: self)
        
    }
    

}

class myAlert {
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    
    private let backgroundView: UIView = {
       let background = UIView()
        background.backgroundColor = .black
        background.alpha = 0
        return background
    }()
    
    private let alertView: UIView = {
       let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    func showAlert(with title: String, message: String, on viewController: UIViewController) {
        guard let targetView = viewController.view else {
            return
        }
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width-80, height: 300)
        
        let titleNotLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 80))
        titleNotLabel.text = title
        titleNotLabel.textAlignment = .center
        alertView.addSubview(titleNotLabel)
        
        let messageNotLabel = UILabel(frame: CGRect(x: 0, y: 80, width: alertView.frame.size.width, height: 170))
        messageNotLabel.numberOfLines = 0
        messageNotLabel.text = message
        messageNotLabel.textAlignment = .left
        alertView.addSubview(messageNotLabel)
        
        let buttonNot = UIButton(frame: CGRect(x: 0, y: alertView.frame.size.height-50, width: alertView.frame.size.width, height: 50))
        alertView.addSubview(buttonNot)
        buttonNot.setTitle("Dismiss", for: .normal)
        buttonNot.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.25, animations: {
            
            self.backgroundView.alpha = Constants.backgroundAlphaTo
            
        })
    }
    
    @objc func dismissAlert() {
        
    }
    
}
