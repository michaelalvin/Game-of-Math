//
//  ViewController.swift
//  MakeSchoolHack
//
//  Created by Michael Alvin on 7/6/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let numOne = arc4random_uniform(9) + 1
        let numTwo = arc4random_uniform(9) + 1

        numberOne.text? = String(numOne)
        numberTwo.text? = String(numTwo)
        
        let numThree = Int(arc4random_uniform(4) + 1)
        
        switch numThree {
            case 1:
                mathSymbol.text? = "+"
            case 2:
                mathSymbol.text? = "-"
            case 3:
                mathSymbol.text? = "x"
            case 4:
                mathSymbol.text? = "/"
            default:
                mathSymbol.text? = "∮"
        
    }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var answerBox: UILabel!
    
    @IBOutlet weak var numberOne: UILabel!
    
    @IBOutlet weak var numberTwo: UILabel!
    
    @IBOutlet weak var mathSymbol: UILabel!

    @IBAction func backButton(sender: AnyObject) {
        
        if let str = answerBox.text{
            let index = str.endIndex.advancedBy(-1)
            
            let substr = str.substringToIndex(index)
            
            answerBox.text? = substr
        }
        
    }
    
    @IBAction func buttonTouched(sender: UIButton) {
        let numberPressed = sender.tag
    
        let digit = String(numberPressed)
        
        answerBox.text? += digit
    }
    
    
    @IBAction func checkButton(sender: AnyObject) {
        
    }
    
    

}

