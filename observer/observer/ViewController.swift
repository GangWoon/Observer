//
//  ViewController.swift
//  observer
//
//  Created by Cloud on 2020/02/18.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mp3 = AudioPlayer()
        mp3.play(Item())
        mp3.paused()
        mp3.stop()
    }
}

