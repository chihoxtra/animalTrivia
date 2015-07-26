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
    let randomNumber = Int(arc4random_uniform(5))


    // IBOutlet for various UI components
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var labelTimer: UILabel!
    
    struct optionsAndAnswers {
        var options = [String] ()
        var answer = 0
    }
    
    struct questions {
        var picture = UIImage()
        var info = optionsAndAnswers()
    
    }

    required init?(coder aDecoder: NSCoder) {

        var itemsList:items = [

        
        ]
        
        
        
        for index in 0...(imageNumber-1) {
            imageList.append(UIImage(named: (String(index) + ".png"))!)
        }
        
        super.init(coder: aDecoder)
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
        }
        
    }
    
    @IBAction func buttonStart(sender: AnyObject)
    {

        
        
        print(randomNumber)
        profilePic.image = imageList[randomNumber]
        
    }

}

