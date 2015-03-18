//
//  ViewController.swift
//  TipCalculatorWorks
//
//  Created by Lea Sparkman on 2/11/15.
//  Copyright (c) 2015 CompSci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billAmountLabel: UILabel! //variable because it needs to be assigned a value later. You don't want to have memory allocated for something that isn't needed because it slows down your phone. The compiler still wants a reference to some value (address in value), so that ! means that the value will be assigned later.
    @IBOutlet weak var customTipPercentLabel1: UILabel! //same thing as the other; order doesn't matter
    @IBOutlet weak var customTipPercentLabel2: UILabel!
    @IBOutlet weak var customTipPercentSlider: UISlider!
    @IBOutlet weak var tip15Label: UILabel!
    @IBOutlet weak var total15Label: UILabel!
    @IBOutlet weak var tipCustomLabel: UILabel!
    @IBOutlet weak var totalCustomLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    
    let decimal100 = NSDecimalNumber(string: "100.0")
    let decimal15Percent = NSDecimalNumber(string: "0.15")
    

    //weak references: when you need a reference to something but you're not the owner of it. The view controller is not the owner of these elements, it owns them indirectly.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputTextField.becomeFirstResponder()
    }
    @IBAction func calculateTip(sender: AnyObject) { //anyObject allows us to have an ambiguous input
        let inputString = inputTextField.text
        let sliderValue = NSDecimalNumber(integer: Int(customTipPercentSlider.value))
        let customPercent = sliderValue / decimal100
        
        //did cystomTipPercebtageSlider generate the event? 
        if sender is UISlider {
            //thumb moved so upsate the labels with new custom percent 
            customTipPercentLabel1.text =
                NSNumberFormatter.localizedStringFromNumber(customPercent, numberStyle: NSNumberFormatterStyle.PercentStyle)
            customTipPercentLabel2.text = customTipPercentLabel1.text
        }
        
        //if there is a bill amount, calculate tips and totals
        if !inputString.isEmpty {
            // convert to NSDecimalNumber and insert decimal point
            let billAmount =
                NSDecimalNumber(string: inputString) / decimal100
            
            //did input TextField generate the event? 
            if sender is UITextField {
                //update billAmountLabel with currency-formatted total
                billAmountLabel.text = " " + formatAsCurrency(billAmount)
                
                //calculatwe and display the 15% tip and total
                let fifteenTip = billAmount * decimal15Percent
                total15Label.text = formatAsCurrency(fifteenTip)
                total15Label.text =
                    formatAsCurrency(billAmount + fifteenTip)
                
            }
            
            //calculate custom tip and display custom tip and total 
            
            let customTip = billAmount * customPercent
            tipCustomLabel.text = formatAsCurrency(customTip)
            totalCustomLabel.text =
                formatAsCurrency(billAmount + customTip)
            
        }
        
        else {
            //clear all labels
            billAmountLabel.text = ""
            tip15Label.text  = ""
            total15Label.text = ""
            tipCustomLabel.text = ""
            totalCustomLabel.text = ""
        }
    }
}


// convert a numeric values to localized currency string 
func formatAsCurrency(number: NSNumber) -> String {
    return NSNumberFormatter.localizedStringFromNumber(number, numberStyle: NSNumberFormatterStyle.CurrencyStyle)
}


//overloaded + operator to add NSDecimalNumbers 
func +(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByAdding(right)
}

//overloaded * operator to multiply NSDecimalNumbers 
func *(left: NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByMultiplyingBy(right)
}

//overloaded / operator to divide NSDecimalNumbers
func /(left:NSDecimalNumber, right: NSDecimalNumber) -> NSDecimalNumber {
    return left.decimalNumberByDividingBy(right)
}

//This is a commnet that will do nothingggg (this will be seen an an "M" to which you did not commit. Might also see an a

