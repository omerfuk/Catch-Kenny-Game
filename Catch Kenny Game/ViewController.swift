//
//  ViewController.swift
//  Catch Kenny Game
//
//  Created by Ömer Faruk Kılıçaslan on 27.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var kenny9: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny1: UIImageView!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    //Variables
    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 10
    var kennyArray = [UIImageView]()
    
    var highScore = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score : \(score)"
        
        //Highscore check
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore : \(highScore)"
        }
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recognizer1)
        
        kenny2.addGestureRecognizer(recognizer2)

        kenny3.addGestureRecognizer(recognizer3)

        kenny4.addGestureRecognizer(recognizer4)

        kenny5.addGestureRecognizer(recognizer5)
        
        kenny6.addGestureRecognizer(recognizer6)

        kenny7.addGestureRecognizer(recognizer7)

        kenny8.addGestureRecognizer(recognizer8)

        kenny9.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        timeLabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)

        hideKenny()
    }
    
    @objc func hideKenny() {
        
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        
        var random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
        
    }
    
    
    @objc func increaseScore() {
        
        score += 1
        scoreLabel.text = "Score : \(score)"
        
    }
    
    @objc func countTime() {
        
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            
            //HighScore
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore : \(self.highScore)"
                
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
                
            }
            
            
            
            let alert = UIAlertController(title: "Warning", message: "Time is up", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            let replayAction = UIAlertAction(title: "Replay", style: .default) { UIAlertAction in
                //replay pressed
                
                self.score = 0
                self.scoreLabel.text = "Score : \(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTime), userInfo: nil, repeats: true)
                
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okAction)
            alert.addAction(replayAction)
            
            present(alert, animated: true, completion: nil)
        }
        
        
    }


}

