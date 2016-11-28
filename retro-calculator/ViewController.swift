//
//  ViewController.swift
//  retro-calculator
//
//  Created by Eduardo Chiaro on 11/27/16.
//  Copyright © 2016 Eduardo Chiaro. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumbers = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    var currentOperation: Operation = Operation.Empty

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        outputLbl.text = "0"
        
        
        let _path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: _path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL as URL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPress(btn: UIButton!) {
        playSound()
        
        runningNumbers +=  "\(btn.tag)"
        outputLbl.text = runningNumbers
    }
    
    @IBAction func onDividePressed(_ sender: Any) {
        processOperation(op: Operation.Divide)
    }
    @IBAction func onMultiplyPressed(_ sender: Any) {
        processOperation(op: Operation.Multiply)
    }
    @IBAction func onSubtractPressed(_ sender: Any) {
        processOperation(op: Operation.Subtract)
    }
    @IBAction func onAddPressed(_ sender: Any) {
        processOperation(op: Operation.Add)
    }
    @IBAction func onEqualPress(_ sender: Any) {
        processOperation(op: currentOperation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            //run
            if runningNumbers != "" {
                
                rightValStr = runningNumbers
                runningNumbers = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }
                
                leftValStr = result
                
                outputLbl.text = result
            }
            currentOperation = op
            
        } else {
            //first time operator pressed
            leftValStr = runningNumbers
            runningNumbers = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
}

