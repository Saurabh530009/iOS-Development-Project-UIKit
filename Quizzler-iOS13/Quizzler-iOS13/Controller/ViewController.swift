//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var questionLabel: UILabel?
    @IBOutlet weak var progressButton: UIProgressView?
    @IBOutlet weak var trueButton : UIButton?
    @IBOutlet weak var falseButton : UIButton?
    @IBOutlet weak var scoreLabel : UILabel?
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let userAnswer = sender.currentTitle else {
            return
        }
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        if ( userGotItRight == true){
            // changing background color of button
            sender.backgroundColor = UIColor.green
        }
        else{
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()
        
        // For wait of 0.2 second
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)

    }
    
    @objc func updateUI(){
        questionLabel?.text = quizBrain.getQuestionText()
        progressButton?.progress = quizBrain.getProgress()
        scoreLabel?.text = " Score is : \(quizBrain.getScore())"
        trueButton?.backgroundColor = UIColor.clear
        falseButton?.backgroundColor = UIColor.clear
        
    }
}

