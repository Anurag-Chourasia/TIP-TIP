//
//  ResultViewController.swift
//  Tip-Tip
//
//  Created by Anurag Chourasia on 11/05/23.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var amountSplitLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var recaulculateButton: UIButton!
    
    var amountSplit: Float?
    var message: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        recaulculateButton.layer.cornerRadius = 20
        amountSplitLabel.text = String(format: "%0.2f",amountSplit ?? 0)
        messageLabel.text = message
    }
    
    @IBAction func recalculateButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
