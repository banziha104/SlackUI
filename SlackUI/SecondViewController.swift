//
//  SecondViewController.swift
//  SlackUI
//
//  Created by leeyoungjoon on 2018. 1. 29..
//  Copyright © 2018년 leeyoungjoon. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var urlString : String?
    @IBOutlet weak var centerY: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottom.isActive = false
        centerY.isActive = true
        titleLabel.alpha = 0.0
        view.layoutIfNeeded()
        // Do any additional setup after loading the view.
    }
}



extension SecondViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let finalText = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)
        
        UIView.animate(withDuration: 0.3) {
            if finalText.count > 0 {
                self.bottom.isActive = true
                self.centerY.isActive = false
                self.placeholderLabel.alpha = 0.0
                self.titleLabel.alpha = 1.0
            }else{
                self.bottom.isActive = true
                self.centerY.isActive = false
                self.placeholderLabel.alpha = 1.0
                self.titleLabel.alpha = 0.0
            }
            self.view.layoutIfNeeded() 
        }
        
        
    
        return true
    }
}
