//
//  ViewController.swift
//  AnimalTrivia
//
//  Created by pun samuel on 25/7/15.
//  Copyright © 2015 Samuel Pun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //The array holding all the images
    var imageList = [UIImage]()
    
    // global setting variables
    let imageNumber = 5
    var secondCount = 10
    var correctAnswer = 0
    var dataURL = "http://chihoxtra.ddns.net/images/games/items.txt"
    var score = 0


    // IBOutlet for various UI components
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var labelScore: UILabel!

    @IBOutlet weak var labelCorrect: UILabel!
    
    @IBAction func buttonOption1(sender: UIButton) {
        if correctAnswer == 0 {
            print("對")
            labelCorrect.hidden = true
            score++
            labelScore.text = "Score:" + String(score)
            nextQuestion()
        } else {
            labelCorrect.hidden = false
        }
    }
    
    
    @IBAction func buttonOption2(sender: UIButton) {
        if correctAnswer == 1 {
            labelCorrect.hidden = true
            print("對")
            score++
            labelScore.text = "Score:" + String(score)
            nextQuestion()
        } else {
            labelCorrect.hidden = false
        }
    }
    
    struct optionsAndAnswers {
        var options = [String] ()
        var answer:Int = 0
    }
    
    struct questions {
        var picture = UIImage()
        var info = optionsAndAnswers()
    
    }
    
    var itemsList = [questions]()

    func prepareData() {
        
        
//        let dataSource = NSURL(string: dataURL)

//        let task = NSURLSession.sharedSession().dataTaskWithURL(dataSource!) {
//            (data, response, error) in print(NSString(data: data!, encoding: NSUTF8StringEncoding))
//        }
//        
//        task.resume()
        
        //        let rawData = NSData(contentsOfURL:dataSource!)
        
//        var bufferString:NSString = ""
//        
//        while (bufferString.length == 0) {
//            do {
//                bufferString = try NSString(contentsOfURL: dataSource!, encoding: NSUTF8StringEncoding)
//
//            } catch {
//                // Handle Error
//                print("error in fetching the data")
//            }
//        }
//        var dataLine = [String](), dataItems = [String]()
//        
//        dataLine = bufferString.componentsSeparatedByString("\n1")
//        
//        for i in 0...dataLine.count {
//            dataItems = dataLine[i].componentsSeparatedByString(",")
//            itemsList.append(questions(picture: UIImage(named: (dataItems[0]))!, info: optionsAndAnswers(options: [dataItems[1], dataItems[2]], answer: Int(dataItems[3])!)))
//            print(itemsList)
//        }
        
        
        itemsList = [
            questions(picture: UIImage(named: ("0.png"))!, info: optionsAndAnswers(options: ["lo san", "小狗"], answer: 1)),
            questions(picture: UIImage(named: ("1.png"))!, info: optionsAndAnswers(options: ["波兒", "so san"], answer: 0)),
            questions(picture: UIImage(named: ("2.png"))!, info: optionsAndAnswers(options: ["小狗", "波兒"], answer: 1)),
            questions(picture: UIImage(named: ("3.png"))!, info: optionsAndAnswers(options: ["so san", "lo san"], answer: 1)),
            questions(picture: UIImage(named: ("4.png"))!, info: optionsAndAnswers(options: ["so san", "lo san"], answer: 0)),
        ]
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        score = 0
        self.prepareData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        labelTimer.hidden = false
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func update() {
        
        if(secondCount > 0)
        {
            if(secondCount < 3) {
                labelTimer.textColor = UIColor.redColor()
            }
            labelTimer.text = "Time Left" + String(--secondCount)
        } else {
            labelTimer.text = "Time is up了"
            buttonStart.setTitle("再來噢", forState: .Normal)
            buttonStart.hidden = false
            optionButton1.hidden = true
            optionButton2.hidden = true
            profilePic.hidden = true
            prepareData()

        }
        
    }
    
    func nextQuestion() {
        let randomNumber = Int(arc4random_uniform(5))
        
        print(randomNumber)
        
        profilePic.image = itemsList[randomNumber].picture
        optionButton1.setTitle(itemsList[randomNumber].info.options[0], forState: .Normal)
        optionButton2.setTitle(itemsList[randomNumber].info.options[1], forState: .Normal)
        correctAnswer = itemsList[randomNumber].info.answer
    }
    
    @IBAction func buttonStart(sender: AnyObject)
    {
        nextQuestion()
        
        secondCount = 10
        labelTimer.hidden = false
        profilePic.hidden = false
        buttonStart.hidden = true
        optionButton1.hidden = false
        optionButton2.hidden = false
        labelScore.hidden = false
        
    
    }

}

