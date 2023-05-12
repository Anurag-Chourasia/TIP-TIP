//
//  ViewController.swift
//  Tip-Tip
//
//  Created by Anurag Chourasia on 11/05/23.
//

import UIKit

class TipCalculateViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var percentTextField: UITextField!
    @IBOutlet var splitLabel: UILabel!
    @IBOutlet var stepper: UIStepper!
    var amount: Float = 0.0
    var percent: Float = 0.0
    var calculatedValue: Float = 0.0
    var splitValue : Float = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        amountTextField.delegate = self
        percentTextField.delegate = self
        amountTextField.inputAccessoryView = toolBar()
        percentTextField.inputAccessoryView = toolBar()
        stepper.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    @IBAction func stepperValueChange(_ sender: UIStepper) {
        splitLabel.text = String(format: "%0.0f", sender.value)
        splitValue = Float(sender.value)
        print(splitValue)
    }
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        calculatedValue = (amount + (amount * (percent/100))) / splitValue
        print(calculatedValue)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let segueVC = segue.destination as! ResultViewController
            
            segueVC.amountSplit = calculatedValue
            segueVC.message = "Split between \(String(format: "%0.0f", splitValue)) people, with \(percent)% tip."
            
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == percentTextField{
            if let percent = Double(percentTextField.text!){
                self.percent = Float(percent)
                print(self.percent)
            }
        }
        if textField == amountTextField{
            if let amount = Double(amountTextField.text!){
                self.amount = Float(amount)
                print(self.amount)
            }
        }
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
            let dotsCount = textField.text!.components(separatedBy: ".").count - 1
            if dotsCount > 0 && (string == "." || string == ",") {
                return false
            }
            
            if string == "," {
                textField.text! += "."
                return false
            }
            
            return true
        
    }
    
    
}

extension UIViewController{
    func toolBar() -> UIToolbar{
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.barTintColor = UIColor.init(red: 0/255, green: 25/255, blue: 61/255, alpha: 1) //Write what you want for color
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let buttonTitle = "Done" //Or "Tamam"
//        let cancelButtonTitle = "Cancel" //Or "İptal" for Turkish
        let doneButton = UIBarButtonItem(title: buttonTitle, style: .done, target: self, action: #selector(onClickDoneButton))
//        let cancelButton = UIBarButtonItem(title: cancelButtonTitle, style: .plain, target: self, action: #selector(onClickCancelButton))
        doneButton.tintColor = .white
//        cancelButton.tintColor = .white
        toolBar.setItems([/*cancelButton,*/space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        return toolBar
    }

    @objc func onClickDoneButton(){
        view.endEditing(true)
    }

//    @objc func onClickCancelButton(){
//        view.endEditing(true)
//    }
        
}

