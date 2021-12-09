//
//  Music.swift
//  Lost in Doi Saket
//
//  Created by Sacha Schwab on 17.10.15.
//  Copyright © 2015 Sacha Schwab. All rights reserved.
//

import UIKit
import AVFoundation

class Track: NSObject {
    
    var audioPlayer: AVAudioPlayer!
    var player = AVPlayer()
    
    // MARK: Player

    func loadSelectedTrack(trackID: String!, clientID: String) -> AVPlayer {
        
        guard let fileURL: NSURL = NSURL(string: "https://api.soundcloud.com/tracks/\(trackID)/stream.json?client_id=\(clientID)")! else {
            print("error downloading track!!!!")
        }
        self.player = AVPlayer(URL: fileURL)
        self.player.play()
        print("accessing streaming")
        return self.player
    }
}
