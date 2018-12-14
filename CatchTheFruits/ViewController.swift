//
//  ViewController.swift
//  CatchTheFruits
//
//  Created by Halil Özel on 13.12.2018.
//  Copyright © 2018 Halil Özel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    
    
    @IBOutlet weak var fruit1: UIImageView!
    @IBOutlet weak var fruit2: UIImageView!
    @IBOutlet weak var fruit3: UIImageView!
    @IBOutlet weak var fruit4: UIImageView!
    @IBOutlet weak var fruit5: UIImageView!
    @IBOutlet weak var fruit6: UIImageView!
    @IBOutlet weak var fruit7: UIImageView!
    @IBOutlet weak var fruit8: UIImageView!
    @IBOutlet weak var fruit9: UIImageView!
    
  
    var score = 0
    
    var timer = Timer()
    
    var hideTimer = Timer()
    
    var counter = 0
    
    
    var fruitsArray = [UIImageView]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        scoreLabel.text = "Score : \(score)"

        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        
        
        fruit1.isUserInteractionEnabled = true
        fruit2.isUserInteractionEnabled = true
        fruit3.isUserInteractionEnabled = true
        fruit4.isUserInteractionEnabled = true
        fruit5.isUserInteractionEnabled = true
        fruit6.isUserInteractionEnabled = true
        fruit7.isUserInteractionEnabled = true
        fruit8.isUserInteractionEnabled = true
        fruit9.isUserInteractionEnabled = true
        
        
        fruit1.addGestureRecognizer(recognizer1)
        fruit2.addGestureRecognizer(recognizer2)
        fruit3.addGestureRecognizer(recognizer3)
        fruit4.addGestureRecognizer(recognizer4)
        fruit5.addGestureRecognizer(recognizer5)
        fruit6.addGestureRecognizer(recognizer6)
        fruit7.addGestureRecognizer(recognizer7)
        fruit8.addGestureRecognizer(recognizer8)
        fruit9.addGestureRecognizer(recognizer9)



        // timer
        
        counter = 20
        timeLabel.text = "Time : \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        
        
        // hide timer
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:#selector(ViewController.hideFruits), userInfo: nil, repeats: true)

        
        // array
        
        fruitsArray.append(fruit1)
        fruitsArray.append(fruit2)
        fruitsArray.append(fruit3)
        fruitsArray.append(fruit4)
        fruitsArray.append(fruit5)
        fruitsArray.append(fruit6)
        fruitsArray.append(fruit7)
        fruitsArray.append(fruit8)
        fruitsArray.append(fruit9)
        
        hideFruits()
    }
    
    
    @objc func hideFruits(){
        
        for fruit in fruitsArray{
            
            fruit.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(fruitsArray.count - 1)))
        
        fruitsArray[random].isHidden = false
        
    }
    
    
    @objc func countDown(){
        
        counter -= 1
        timeLabel.text = "Time : \(counter)"
        
        if counter == 0{
            
            timer.invalidate()
            hideTimer.invalidate()
            
            
            let alert = UIAlertController(title: "Time", message: "Time's Up !!!", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "Yep", style: .default, handler: nil)
            
            let noButton = UIAlertAction(title: "Nope", style: .cancel, handler: nil)
            
            alert.addAction(okButton)
            alert.addAction(noButton)
            
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }


}

