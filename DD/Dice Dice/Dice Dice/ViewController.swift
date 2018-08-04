
//
//  ViewController.swift
//  Dice Dice
//
//  Created by Glny Gl on 27.07.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var sound: AVAudioPlayer = AVAudioPlayer ()
    var win: AVAudioPlayer = AVAudioPlayer ()
    var btn1: Int = 0
    var btn2: Int = 0
    var rand1: UInt32 = 0
    var rand2: UInt32 = 0
    var rslt: Int = 0
    @IBOutlet weak var lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let soundFile = Bundle.main.path(forResource: "DiceSoundEffect", ofType: ".mp3")
         let winFile = Bundle.main.path(forResource: "WinSoundEffect", ofType: ".mp3")
        do {
            try sound = AVAudioPlayer(contentsOf: URL (fileURLWithPath: soundFile!))
              try win = AVAudioPlayer(contentsOf: URL (fileURLWithPath: winFile!))
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func rollingDice(_ sender: UIButton) {
        
        if(sender.tag == 1){
            if(btn1 == 0){
                roll1(sender)
                if(rand1 != 0 && rand2 != 0){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                        self.result(r1: self.rand1, r2: self.rand2)
                    }
                }
            }
            else if(btn2 == 0){
                lbl.text = "It's Purple Turn"
            }
        }
        if(sender.tag == 2){
            if(btn2 == 0){
                roll2(sender)
                if(rand1 != 0 && rand2 != 0){
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        self.result(r1: self.rand1, r2: self.rand2)
                    }
                }
            }
            else if(btn1 == 0) {
                lbl.text = "It's Pink Turn"
            }
        }
    }
    
    func result(r1:UInt32, r2:UInt32){
        if(r1>r2){
            lbl.text = "PINK WIN"
            win.play()
        }
        else if(r2>r1){
            lbl.text = "PURPLE WIN"
            win.play()
        }
        else {
            lbl.text = "TRY AGAIN"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.lbl.text = "PLAY AGAIN"
        }
        btn1 = 0
        btn2 = 0
        rand1 = 0
        rand2 = 0
        rslt = 1
    }
    
    func roll1(_ sender: UIButton){
        let array: NSMutableArray = []
        let newView = UIImageView()
        newView.frame = sender.bounds
        for _ in 1...8{
            rand1 = arc4random_uniform(6)+1
            let image = UIImage(named: "\(rand1)\(sender.tag)")
            array.add(image!)
        }
        sender.setBackgroundImage(array.lastObject as? UIImage, for: .normal)
        sender.addSubview(newView)
        newView.animationImages = array as? [UIImage]
        newView.animationDuration = 1.0
        newView.animationRepeatCount = 1
        newView.startAnimating()
        sound.play()
        btn1=1
    }
    func roll2(_ sender: UIButton){
        let array: NSMutableArray = []
        let newView = UIImageView()
        newView.frame = sender.bounds
        for _ in 1...8{
            rand2 = arc4random_uniform(6)+1
            let image = UIImage(named: "\(rand2)\(sender.tag)")
            array.add(image!)
        }
        sender.setBackgroundImage(array.lastObject as? UIImage, for: .normal)
        sender.addSubview(newView)
        newView.animationImages = array as? [UIImage]
        newView.animationDuration = 1.0
        newView.animationRepeatCount = 1
        newView.startAnimating()
        sound.play()
        btn2=1
    }
}


