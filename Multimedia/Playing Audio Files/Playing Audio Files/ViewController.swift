//
//  ViewController.swift
//  Playing Audio Files
//
//  Created by Yao Jiqian on 04/01/2018.
//  Copyright © 2018 BigBit Corp. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer : AVAudioPlayer?
    
    /* The delegate message that will let us know that the player has finished playing an audio file */
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Finished playing the song.")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dispatchQueue = DispatchQueue.global(qos: .default)
        
        dispatchQueue.async(execute: {[weak self] in
            let mainBundle = Bundle.main
            
            /* Find the location of our file to feed to the audio player */
            let filePath = mainBundle.path(forResource: "MySong", ofType: "mp3")
            
            if let thePath = filePath{
                let url = URL(fileURLWithPath: thePath)
                do{
                    let fileData = try Data(contentsOf: url)
                
                    //var error : Error!
                
                    self!.audioPlayer = try AVAudioPlayer(data: fileData)
                    
                    /* Did we get an instance of AVAudioPlayer? */
                    if let player = self!.audioPlayer {
                        /* Set the delegate and start playing */
                        player.delegate = self!
                        if player.prepareToPlay() && player.play() {
                            print("play successful")
                        }else{
                            print("play failed")
                        }
                    }
                }catch{
                    print("Catch an excption.")
                }
                
            }else{
                print("filePath not found")
            }
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

