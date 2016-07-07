//
//  ViewController.swift
//  MakeSchoolHack
//
//  Created by Michael Alvin on 7/6/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var counterLabel: UILabel!
    
    
    var startTime = NSTimeInterval()
    
    var timer:NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        generateQuestion()
        start()
    }
    
    func start(){
        if (!timer.valid) {
            let aSelector : Selector = "updateTime"
            timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    func stop(){
        timer.invalidate()
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        counterLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
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
            if(str.characters.count != 0){
                let index = str.endIndex.advancedBy(-1)
                
                let substr = str.substringToIndex(index)
                
                answerBox.text? = substr
            }
        }
        
    }
    
    @IBAction func buttonTouched(sender: UIButton) {
        let numberPressed = sender.tag
        
        let digit = String(numberPressed)
        
        if(answerBox.text?.characters.count < 6){
            answerBox.text? += digit
        }
        
        var answer = ""
        
        if let problemTypeCheck = mathSymbol.text{
            switch problemTypeCheck {
            case "+":
                answer = ProblemType.add(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
            case "-":
                answer = ProblemType.subtract(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
            case "x":
                answer = ProblemType.multiply(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
            case "/":
                answer = ProblemType.divide(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
                
            default: break
            }
            
            
            if(answer != answerBox.text){
                checkButtonOutlet.setImage(UIImage(named: "numButtonCheckRedGradient.png"), forState: .Normal)
            } else {
                checkButtonOutlet.setImage(UIImage(named: "numButtonCheckGreenGradient.png"), forState: .Normal)
            }

        }
    }
    
    
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    @IBAction func checkButton(sender: AnyObject) {
        var answer = ""
        
        if let problemTypeCheck = mathSymbol.text{
            switch problemTypeCheck {
            case "+":
                answer = ProblemType.add(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
            case "-":
                answer = ProblemType.subtract(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
            case "x":
                answer = ProblemType.multiply(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
            case "/":
                answer = ProblemType.divide(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
                
            default: break
            }
            
            if answer == answerBox.text{
                generateQuestion()
            }
        }
        
    }
    
    
    
    func generateQuestion() {
        let numOne = arc4random_uniform(9) + 1
        let numTwo = arc4random_uniform(5) + 1
        
        numberOne.text? = String(numOne)
        numberTwo.text? = String(numTwo)
        
        let numThree = Int(arc4random_uniform(3) + 1)
        
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
        
        answerBox.text = ""
        
        checkButtonOutlet.setImage(UIImage(named: "numButtonCheckRedGradient.png"), forState: .Normal)
        
    }
    
    @IBAction func negativeButton(sender: AnyObject) {
        
        if(answerBox.text![0] != "-"){
            answerBox.text? = "-" + answerBox.text!
        } else if (answerBox.text![0] == "-"){
            if var str = answerBox.text{
                if(str.characters.count != 0){
                    str.removeAtIndex(str.startIndex)
                    answerBox.text? = str
                }
            }
        }
        
        var answer = ""
        
        if let problemTypeCheck = mathSymbol.text{
            switch problemTypeCheck {
            case "+":
                answer = ProblemType.add(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
            case "-":
                answer = ProblemType.subtract(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
            case "x":
                answer = ProblemType.multiply(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
            case "/":
                answer = ProblemType.divide(Int(numberOne.text!)!, num2: Int(numberTwo.text!)!)
                
            default: break
            }
            
            
            if(answer != answerBox.text){
                checkButtonOutlet.setImage(UIImage(named: "numButtonCheckRedGradient.png"), forState: .Normal)
            } else {
                checkButtonOutlet.setImage(UIImage(named: "numButtonCheckGreenGradient.png"), forState: .Normal)
            }
            
            
        }
    }
    
}


extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
}

