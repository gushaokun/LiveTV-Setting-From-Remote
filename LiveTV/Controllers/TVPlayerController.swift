//
//  TVPlayerController.swift
//  AppleTVDemo
//
//  Created by Gavin on 16/2/22.
//  Copyright © 2016年 Gavin. All rights reserved.
//

import UIKit
import AVKit

class TVPlayerController: AVPlayerViewController {
    
    var urlString:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        let playItem = AVPlayerItem(URL: NSURL(string: urlString!)!)
        player = AVPlayer(playerItem: playItem)
        print("\(urlString)")
        player?.play()
    }
    
}






















