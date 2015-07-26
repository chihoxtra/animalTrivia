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
    
    // change the total number if needed
    let imageNumber = 5
    
    var secondCount = 10

    
    var correctAnswer = 0


    // IBOutlet for various UI components
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var labelTimer: UILabel!
    @IBOutlet weak var optionButton1: UIButton!
    @IBOutlet weak var optionButton2: UIButton!
    @IBOutlet weak var buttonStart: UIButton!

    @IBAction func buttonOption1(sender: UIButton) {
        if correctAnswer == 0 {
            print("對")
            nextQuestion()
        }
    }
    
    
    @IBAction func buttonOption2(sender: UIButton) {
        if correctAnswer == 1 {
            print("對")
            nextQuestion()
        }
    }
    
    struct optionsAndAnswers {
        var options = [String] ()
        var answer = 0
    }
    
    struct questions {
        var picture = UIImage()
        var info = optionsAndAnswers()
    
    }
    
    var itemsList = [questions]()

    func prepareData() {
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
            labelTimer.text = "Time Left" + String(--secondCount)
        } else {
            buttonStart.setTitle("再來噢", forState: .Normal)
            buttonStart.hidden = false
            optionButton1.hidden = true
            optionButton2.hidden = true
            profilePic.hidden = true
            labelTimer.hidden = true
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
        
    
    }

}

