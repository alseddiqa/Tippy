//
//  ViewController.swift
//  Tippy
//
//  Created by Abdullah Alseddiq on 12/18/19.
//  Copyright © 2019 Abdullah Alseddiq. All rights reserved.
//
// A simple tip calculator built as pre-work to enroll in iOS class
//the app allows the user to insert and amount and a tip to that amount

import UIKit

class ViewController: UIViewController {

    //connecting textfield to controller
    @IBOutlet weak var amountField: UITextField!
    var percentage:Double = 0
   
    @IBOutlet weak var errorCheck: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        errorCheck.text = ""

    }

    //stepper to allow the user increase and decrease the amount by $0.50
    @IBAction func updateAmount(_ sender: UIStepper) {
        amountField.text = "$"+String(sender.value)
    }
    
    //updating tip after percentage selection changes
    @IBAction func percentageSeg(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            percentage = 0
            updateTotal()
        }
        else if sender.selectedSegmentIndex == 1 {
            percentage = 0.10
            updateTotal()
        }
        else if sender.selectedSegmentIndex == 2 {
            percentage = 0.15
            updateTotal()

        }
        else if sender.selectedSegmentIndex == 3 {
            percentage = 0.25
            updateTotal()
        }
        else
        {
            customizeTip()
        }
        
    }
    
    //adding a custom tip when a user select custom
    func customizeTip()
    {
        let alert = UIAlertController(title: "Custom Tip", message: "Enter a specific amount", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "0.00"
            textField.keyboardType = UIKeyboardType.numberPad
        })
        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { _ in}))
        alert.addAction(UIAlertAction(title: "add", style: .default, handler: { action in
            self.updateTotalWitTip(alerty: alert)
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    //handling custom tip
    func updateTotalWitTip(alerty:UIAlertController)
    {
        let textField = alerty.textFields![0]
        let tipText = textField.text!
        let tip = Double(tipText)
        
        let amountText = amountField.text!
        if(amountText.prefix(1) == "$")
        {
            let mySubstring = amountText.dropFirst()  // play
            let amount = Double(mySubstring)
            let theTotal = amount! + tip!
            total.text = "$"+String(theTotal)
            errorCheck.text = ""

        }
        else if (amountText == ""){
            errorCheck.text = "Please insert an amount"
        }
        else {
            errorCheck.text = "Please use the proper format in the amount field '$0.00'"
        }
        
    }
    
    @IBOutlet weak var total: UILabel!
    
    //handling percentage tip
    func updateTotal()
    {
        let amountText = amountField.text!
        
        if(amountText.prefix(1) == "$")
        {
            let mySubstring = amountText.dropFirst()  // play
            let amount = Double(mySubstring)
            let theTotal = amount! + (percentage*amount!)
            total.text = "$"+String(theTotal)
            errorCheck.text = ""

        }
        else if (amountText == ""){
            errorCheck.text = "Please insert an amount"
        }
        else {
            errorCheck.text = "Please use the proper format in the amount field '$0.00'"
        }
                
    }
}

