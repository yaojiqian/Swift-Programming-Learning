//
//  ViewController.swift
//  Playing Video Files
//
//  Created by Yao Jiqian on 08/01/2018.
//  Copyright © 2018 BigBit Corp. All rights reserved.
//

import UIKit
//import MediaPlayer
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    var moviePlayer : AVPlayer?
    var moviePlayerController : AVPlayerViewController?
    var playButton : UIButton?
    
    func startPlayingVideo(){
        
        /* First let's construct the URL of the file in our application bundle that needs to get played by the movie player */
        let mainBundle = Bundle.main
        
        guard let url = mainBundle.url(forResource: "Sample", withExtension: "m4v") else{
            debugPrint("open Sample.m4v failed.")
            return
        }
        
        /* If we already created a movie player, let's try to stop it */
        if moviePlayer != nil{
            stopPlayingVideo()
        }
        
        /* Now create a new movie player using the URL */
        moviePlayer = AVPlayer(url: url)
        moviePlayerController = AVPlayerViewController()
        
        if let player = moviePlayer {
            /* Listen for the notification that the movie player sends us whenever it finishes playing */
            //NotificationCenter.default.addObserver(self, selector: #selector(videoHasFinishedPlaying), name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
            
            print("Successfully instantiated the movie player")
            moviePlayerController?.player = player
            //moviePlayerController?.
            
            /* Scale the movie player to fit the aspect ratio */
            present(moviePlayerController!, animated: true ){
                player.play()
            }
        }
    }
    
    func stopPlayingVideo(){
        if let player = moviePlayer{
            NotificationCenter.default.removeObserver(self)
            player.pause()
            //player.view.removeFromSuperview()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playButton = UIButton(type: .system)
        if let button = playButton {
            /* Add our button to the screen. Pressing this button starts the video playback */
            button.frame = CGRect(x: 0, y: 0, width: 70, height: 37)
            button.center = view.center
            
            button.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin , .flexibleBottomMargin , .flexibleRightMargin]
            button.addTarget(self, action: #selector(startPlayingVideo), for: .touchUpInside)
            
            button.setTitle("Play", for: .normal)
            
            view.addSubview(button)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

