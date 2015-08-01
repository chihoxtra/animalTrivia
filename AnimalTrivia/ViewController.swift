//
//  ViewController.swift
//  AnimalTrivia
//
//  Created by pun samuel on 25/7/15.
//  Copyright © 2015 Samuel Pun. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    
    // global setting variables

    var secondCount = 10
    var correctAnswer = 0
    var dataURL = "http://chihoxtra.ddns.net/images/games/items.txt"
    var score = 0
    var resultArr: [String] = []
    var questionNumber = 0
    var timerstarted = false
    
    struct optionsAndAnswers {
        var options = [String] ()
        var answer:Int = 0
    }
    
    struct questions {
        var picture = UIImage()
        var info = optionsAndAnswers()
        
    }
    
    var itemsList = [questions]()



    // IBOutlet for various UI components
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var labelScore: UILabel!

    @IBOutlet weak var labelCorrect: UILabel!
    
    func validateAnswer(b: UIButton, ans: Int) {
        if ((correctAnswer == 0) && (ans == 0)) || ((correctAnswer == 1) && (ans == 1)) {
            print("對")
            labelCorrect.hidden = true
            score++
            labelScore.text = "Score:" + String(score)
            nextQuestion()
        } else {
            labelCorrect.hidden = false
        }
    }
    
    @IBAction func buttonOption1(sender: UIButton) {
        validateAnswer(sender, ans: 0)
    }
    
    
    @IBAction func buttonOption2(sender: UIButton) {
        validateAnswer(sender, ans: 1)
    }
    
    
    func randomizeArray(var arr: [String]){
        
        if (arr.count > 0) {
            let tmp:String  = arr.removeAtIndex(Int(arc4random_uniform(UInt32(arr.count))))
            if tmp != "" {
                resultArr.append(tmp)
                randomizeArray(arr)
            }
            
        }
        
    }

    func prepareData() {

        // testing on data fetch
        
        let endpoint = NSURL(string: "http://chihoxtra.ddns.net/images/games/items.txt")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(endpoint!) {(rawdata, response, error) in
        
            let dataBuffer = NSString(data: rawdata!, encoding:NSUTF8StringEncoding) as String?
            var dataWithoutEmptyContent = dataBuffer!.componentsSeparatedByString("\n")
            
            dataWithoutEmptyContent.removeAtIndex(dataWithoutEmptyContent.indexOf("")!)
            
            self.randomizeArray(dataWithoutEmptyContent)
            var dataLine:[String] = self.resultArr

            
            for i in 0 ... (dataLine.count - 1) {
                if dataLine[i] != "" {
                
                    var dataItem:[String] = dataLine[i].componentsSeparatedByString(",")
                
                    self.itemsList.append(questions(picture: UIImage(named: (String(dataItem[0])))!, info: optionsAndAnswers(options: [String(dataItem[1]), String(dataItem[2])], answer: Int(dataItem[3])!)))
                
                }
            }

        }
        
        task.resume()


    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.prepareData()
        

    }
    
    func timerStart () {
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        labelTimer.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func update() {
        
        if(secondCount > 0)
        {
            if(secondCount < 4) {
                labelTimer.textColor = UIColor.redColor()
            }
            secondCount--
            labelTimer.text = "Time Left: " + String(secondCount)
        } else {
            // end game
            labelTimer.text = "Time is up了"
            buttonStart.setTitle("再來噢", forState: .Normal)
            buttonStart.hidden = false
            optionButton1.hidden = true
            optionButton2.hidden = true
            profilePic.hidden = true
            labelCorrect.hidden = true


        }
        
    }
    
    
    
    func nextQuestion() {

        if questionNumber < resultArr.count {
            profilePic.image = itemsList[questionNumber].picture
            optionButton1.setTitle(itemsList[questionNumber].info.options[0], forState: .Normal)
            optionButton2.setTitle(itemsList[questionNumber].info.options[1], forState: .Normal)
            correctAnswer = itemsList[questionNumber].info.answer
            questionNumber++
        }
        

    }
    
    @IBAction func buttonStart(sender: AnyObject)
    {

        nextQuestion()
        if timerstarted == false {
            timerStart()
            timerstarted = true
        }
        
        prepareData()

        questionNumber = 0
        score = 0
        labelScore.text = "Score: " + String(score)
    
        secondCount = 10
        labelTimer.hidden = false
        profilePic.hidden = false
        buttonStart.hidden = true
        optionButton1.hidden = false
        optionButton2.hidden = false
        labelScore.hidden = false
        
    
    }

}

