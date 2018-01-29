//
//  ViewController.swift
//  SlackUI
//
//  Created by leeyoungjoon on 2018. 1. 24..
//  Copyright © 2018년 leeyoungjoon. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NextButton.isEnabled = false
        
        NotificationCenter.default.addObserver(
                forName: NSNotification.Name.UIKeyboardWillShow,
                object: nil, queue: OperationQueue.main) {
            (noti) in
            if let value = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardFrame = value.cgRectValue
                let height = keyboardFrame.height // 키보드

                self.bottomConstraint.constant = height + 20
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: OperationQueue.main){
            (noti) in
            self.bottomConstraint.constant = 20
            
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
//        DispatchQueue.main.asyncAfter(deadline : .now() + 2) { // 2초 뒤에 실행
//            UIView.animate(withDuration: 0.3, animations: {
//                self.bottomConstraint.constant = 100
//                self.view.layoutIfNeeded() // 뷰 갱신(필수)})
//            })
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SecondViewController{
            vc.urlString = (inputField.text ?? "") + (placeholderLabel.text ?? "")
        }
    }
}


extension ViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { // string은 문자열이 반환, NSRange는 범위가 넘어옮
        let finalText = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string)

        let nsstr = finalText as NSString // NSString으로 변환함
        let dict = [NSAttributedStringKey.font : inputField.font!]
        let width = nsstr.size(withAttributes: dict).width //
        leading.constant = width
        view.layoutIfNeeded()
        
        if finalText.count == 0 {
            placeholderLabel.text = "your-url.slack.com"
            NextButton.isEnabled = false
        }else{
            placeholderLabel.text = ".slack.com"
            NextButton.isEnabled = true
        }
        return true // 키보드에 입력할 때마다 이전의 입력된 값을 리턴함()
    }
}
