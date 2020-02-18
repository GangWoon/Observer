//
//  AudioPlayer.swift
//  observer
//
//  Created by Cloud on 2020/02/18.
//  Copyright © 2020 Cloud. All rights reserved.
//

struct Item {
    
}

import Foundation

class AudioPlayer {
    private var state = State.idle {
        didSet {
            changeState()
        }
    }
    
    func play(_ item: Item) {
        state = .playing(item)
    }
    
    func paused() {
        switch state {
        case .idle, .paused:
            break
        case let .playing(item):
            state = .paused(item)
            
        }
    }
    
    func stop() {
        state = .idle
        
    }
    
    func changeState() {
        print("state changed")
    }
}

private extension AudioPlayer {
    enum State {
        case idle
        case playing(Item)
        case paused(Item)
    }
}
