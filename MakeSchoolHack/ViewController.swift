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
    
    var counter = 1
    
    var timerTime = ""
    
    var startTime = NSTimeInterval()
    
    var timer:NSTimer = NSTimer()
    
    var bestTime: String?
    
    
    func restart () {
        generateQuestion()
        counter = 1
        questionNumberLabel.text = String(counter)
        answerBox.text = ""
        start()
    }
    
    func endGame(){
        //        if bestTime == nil {
        //            bestTime = timerTime
        //            NSUserDefaults.standardUserDefaults().setObject(bestTime, forKey: "bestTime")
        //            updateBestTimeLabel()
        //        }
        
        if(bestTime == nil || bestTime > timerTime){
            bestTime = timerTime
            // save to NSUserDefauults
            NSUserDefaults.standardUserDefaults().setObject(bestTime, forKey: "bestTime")
            
            updateBestTimeLabel()
        }
        
        let alertController: UIAlertController = UIAlertController(title: "Congratulations! 🐠 You finished in " + timerTime, message: "Do you want to practice some more?", preferredStyle: .Alert)
        
        
        let moreButton = UIAlertAction(title: "Yes!", style: .Default) { (action: UIAlertAction) in
            
            self.restart()
        }
        
        alertController.addAction(moreButton)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func updateBestTimeLabel() {
        bestTime = NSUserDefaults.standardUserDefaults().stringForKey("bestTime")
        
        if let bestTime = bestTime {
            bestTimerLabel.text = bestTime
        } else {
            bestTimerLabel.text = "Does not exist"
        }
    }
    
    
    func askUserToStart(){
        let alert: UIAlertController = UIAlertController(title: "This is a simple math game that tests your math speed.", message: "Are you ready?", preferredStyle: .Alert)
        
        let startAction = UIAlertAction(title: "Start!", style: .Default) { (action: UIAlertAction) in
            self.generateQuestion()
            self.start()
        }
        
        alert.addAction(startAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBestTimeLabel()

//        askUserToStart()
//        generateQuestion()
//        start()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        askUserToStart()
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
    
    @IBOutlet weak var questionNumberLabel: UILabel!
    
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
        timerTime = "\(strMinutes):\(strSeconds):\(strFraction)"
        
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
        answerBox.text = ""
        
        //        if let str = answerBox.text{
        //            if(str.characters.count != 0){
        //                let index = str.endIndex.advancedBy(-1)
        //
        //                let substr = str.substringToIndex(index)
        //
        //                answerBox.text? = substr
        //            }
        //        }
        
    }
    
    @IBAction func buttonTouched(sender: UIButton) {
        let numberPressed = sender.tag
        
        let digit = String(numberPressed)
        
        if(answerBox.text?.characters.count < 6){
            answerBox.text? += digit
        }
        
        if(counter == 10 && checkCorrectAnswer()){
            stop()
            endGame()
            //counter = 0
        }
        
        if(checkCorrectAnswer()){
            checkButtonOutlet.setImage(UIImage(named: "numButtonCheckGreenGradient.png"), forState: .Normal)
            
            if(counter < 10){
                counter += 1
                // sleep(1)
                questionNumberLabel.text = String(counter)
                generateQuestion()
            }
            
        } else {
            checkButtonOutlet.setImage(UIImage(named: "numButtonCheckRedGradient.png"), forState: .Normal)
        }
    }
    
    @IBOutlet weak var bestTimerLabel: UILabel!
    
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    @IBAction func checkButton(sender: AnyObject) {
        if(checkCorrectAnswer()){
            generateQuestion()
        }
    }
    
    
    
    func generateQuestion() {
        let numOne = arc4random_uniform(9) + 1
        let numTwo = arc4random_uniform(9) + 1
        
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
    
    func checkCorrectAnswer() -> Bool {
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
        }
        
        if(answer == answerBox.text){
            return true
        } else {
            return false
        }
    }
    
    
    @IBAction func negativeButton(sender: AnyObject) {
        
        
        //answerBox.text = "-" + answerBox.text!
        
        // must check if empty answer box
        
        if(answerBox.text![0] != "-"){
            answerBox.text = "-" + answerBox.text!
        } else if (answerBox.text![0] == "-"){
            answerBox.text?.removeAtIndex((answerBox.text?.startIndex)!)
        }
        
        if(checkCorrectAnswer()){
            checkButtonOutlet.setImage(UIImage(named: "numButtonCheckGreenGradient.png"), forState: .Normal)
            generateQuestion()
        } else {
            checkButtonOutlet.setImage(UIImage(named: "numButtonCheckRedGradient.png"), forState: .Normal)
        }
    }
}
