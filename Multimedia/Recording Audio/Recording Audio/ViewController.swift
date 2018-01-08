//
//  ViewController.swift
//  Recording Audio
//
//  Created by Yao Jiqian on 08/01/2018.
//  Copyright © 2018 BigBit Corp. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate , AVAudioPlayerDelegate{
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    func startRecordingAudio(){
        
        let audioRecordingURL = self.audioRecordingPath()
        
        do{
            audioRecorder = try AVAudioRecorder(url: audioRecordingURL, settings: audioRecordingSettings() as! [String : Any])
        }catch{
            print("creat audioRecorder failed.")
        }
        
        if let recorder = audioRecorder {
            recorder.delegate = self
            
            /* Prepare the recorder and then start the recording */
            if recorder.prepareToRecord() && recorder.record() {
                print("Successfully started to record.")
                
                /* After 5 seconds, let's stop the recording process */
                let delayInSeconds = DispatchTimeInterval.seconds(5)
                let delayInNanoSeconds = DispatchTime.now() + delayInSeconds
                
                DispatchQueue.global().asyncAfter(deadline: delayInNanoSeconds, execute: {[weak self] in
                    self!.audioRecorder!.stop()
                })
                
            }else{
                print("Failed to record.")
                audioRecorder = nil
            }
        }else{
            print("Failed to create audioRecorder.")
        }
        
    }
    
    func audioRecordingPath() -> URL{
        
        let fileManager = FileManager()
        var documentsFolderUrl : URL?
        do{
            documentsFolderUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        }catch{
            print("get url failed.")
        }
        
        return documentsFolderUrl!.appendingPathComponent("Recording.m4a");
    }
    
    func audioRecordingSettings() -> NSDictionary{
        
        /* Let's prepare the audio recorder options in the dictionary.
         Later we will use this dictionary to instantiate an audio
         recorder of type AVAudioRecorder */
        
        return [
            AVFormatIDKey : kAudioFormatMPEG4AAC as NSNumber,
            AVSampleRateKey : 16000.0 as NSNumber,
            AVNumberOfChannelsKey : 1 as NSNumber,
            AVEncoderAudioQualityKey : AVAudioQuality.low.rawValue as NSNumber
            ]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Ask for permission to see if we can record audio */
        let session = AVAudioSession.sharedInstance()
        
        do{
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.duckOthers)
            
            try session.setActive(true)
            session.requestRecordPermission{[weak self] (allowed : Bool) in
                if(allowed){
                    self!.startRecordingAudio()
                }else{
                    print("We don't have permission to record audio")
                }
            }
        }catch{
            print("Session failed.")
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if flag {
            print("Successfully stopped the audio recording process")
            do {
                /* Let's try to retrieve the data for the recorded file */
                let fileData = try NSData(contentsOf: audioRecordingPath(), options: NSData.ReadingOptions.mappedRead)
                /* Form an audio player and make it play the recorded data */
                audioPlayer = try AVAudioPlayer(data: fileData as Data)
                /* Could we instantiate the audio player? */
                if let player = audioPlayer {
                    player.delegate = self
                    if player.prepareToPlay() && player.play() {
                        print("Started playing the recorded audio")
                    }else{
                        print("Could not play the audio")
                    }
                }
            }catch{
                self.audioPlayer = nil
            }
            
        }else{
            print("Stopping the audio recording failed")
        }
        
        /* Here we don't need the audio recorder anymore */
        self.audioRecorder = nil
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        if flag{
            print("Audio player stopped correctly")
        }else{
            print("Audio player did not stop correctly")
        }
        audioPlayer = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

