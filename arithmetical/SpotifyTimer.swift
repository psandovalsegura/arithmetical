//
//  SpotifyTimer.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 1/13/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import Foundation

//TODO: Remove SPTAudioStreamingDelegate if no delegate methods are useful
class SpotifyTimer: NSObject, SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
    var spotifyHeaderView: SpotifyHeaderView?
    var timer = Timer()
    var timerDecrement = 1
    var timerSeconds = 5 //Initial amount
    
    var loadedTracks: [Track]?
    var trackIndex: Int = 0
    var accuratelyPlaying: Bool?
    
    func start() {
        SPTAudioStreamingController.sharedInstance().delegate = self
        SPTAudioStreamingController.sharedInstance().playbackDelegate = self
        
        // Start the timer
        self.timer = Timer.scheduledTimer(timeInterval: Double(self.timerDecrement), target: self, selector: #selector(self.timerUpdate), userInfo: nil, repeats: true)
        
        //Play a song
        SpotifyClient.getCurrentUserSavedTracks { (tracks) in
            self.loadedTracks = tracks
            self.trackIndex = 0
            let firstTrack = tracks[0]
            
            SPTAudioStreamingController.sharedInstance().setIsPlaying(true, callback: { (error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else {
                    SPTAudioStreamingController.sharedInstance().playSpotifyURI(firstTrack.uri!, startingWith: 0, startingWithPosition: 0, callback: { (error) in
                        if error != nil {
                            print("Error in playSportifyURI: \(error?.localizedDescription)")
                        } else {
                            self.accuratelyPlaying = true
                            if self.spotifyHeaderView != nil {
                                self.updateHeader()
                            }
                        }
                    })
                }
            })
        }
        
    }
    
    func start(spotifyHeader: SpotifyHeaderView) {
        self.spotifyHeaderView = spotifyHeader
        start()
    }
    
    func updateHeader() {
        let currentTrack = loadedTracks?[trackIndex]
        self.spotifyHeaderView?.trackLabel.text = (currentTrack?.name!)! + " - " + (currentTrack?.artistName)!
        
        //Load album artwork
        
    }
    
    func timerGain() {
        self.timerSeconds += 5
        play()
    }
    
    func timerUpdate() {
        if self.timerSeconds == 0 {
            
            //Stop the music
            pause()
            self.accuratelyPlaying = false
        }
        
        if self.accuratelyPlaying! {
            self.timerSeconds -= self.timerDecrement
        }
        
        updateStreak()
    }
    
    func updateStreak() {
        let streak = Float(Double(self.timerSeconds) / 100.0)
        
        if streak < 0.3 {
            self.spotifyHeaderView?.streakProgressView.tintColor = UIColor.red
        } else if streak < 0.6 {
            self.spotifyHeaderView?.streakProgressView.tintColor = UIColor.yellow
        } else {
            self.spotifyHeaderView?.streakProgressView.tintColor = UIColor.green
        }
        
        self.spotifyHeaderView?.streakProgressView.progress = streak
    }
    
    func pause(){
        SPTAudioStreamingController.sharedInstance().setIsPlaying(false, callback: { (error) in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            }
        })
        
        self.accuratelyPlaying = false
    }
    
    func play() {
        SPTAudioStreamingController.sharedInstance().setIsPlaying(true, callback: { (error) in
            if error != nil {
                print("Error: \(error?.localizedDescription)")
            }
        })
        
        self.accuratelyPlaying = true
    }
    
    func invalidate() {
        self.timer.invalidate()
        pause()
    }
    
    internal func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didStartPlayingTrack trackUri: String!) {
        print("Did Start Playing Track")
    }
    
    internal func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didStopPlayingTrack trackUri: String!) {
        print("Did Stop Playing Track")
        //Go to next loaded track
        self.trackIndex += 1
        if self.trackIndex < (self.loadedTracks?.count)! {
            let currentTrack = self.loadedTracks?[self.trackIndex]
            SPTAudioStreamingController.sharedInstance().playSpotifyURI(currentTrack?.uri!, startingWith: 0, startingWithPosition: 0, callback: { (error) in
                if error != nil {
                    print("Error in playSportifyURI: \(error?.localizedDescription)")
                } else {
                    self.accuratelyPlaying = true
                    if self.spotifyHeaderView != nil {
                        self.updateHeader()
                    }
                }
            })
        }
        
    }
    
    internal func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didChangePosition position: TimeInterval) {
        updateStreak()
    }
    
}
