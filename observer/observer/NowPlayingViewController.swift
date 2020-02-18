//
//  NowPlayingViewController.swift
//  observer
//
//  Created by Cloud on 2020/02/18.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NowPlayingViewController: AudioPlayerObserver {
    func audioPlayer(_ player: AudioPlayer, didStartPlaying item: AudioPlayer.Item) {
        print(item)
    }
}
