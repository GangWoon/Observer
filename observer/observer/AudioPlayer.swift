//
//  AudioPlayer.swift
//  observer
//
//  Created by Cloud on 2020/02/18.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit



class AudioPlayer {
    struct Item {
        
    }
    
    private var notificationCenter: NotificationCenter
    private var state = State.idle {
        // We add a property observer on 'state', which lets us
        // run a function on each value change.
        didSet { stateDidChange() }
    }
    
    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
        notificationCenter.addObserver(self, selector: #selector(playbackDidStart(_:)), name: .playbackStarted, object: nil)
    }
    
    @objc private func playbackDidStart(_ notification: Notification) {
        guard let item = notification.object as? AudioPlayer.Item else {
            let object = notification.object as? Any
            print(object)
            return
        }
        print(item)
    }
}

extension Notification.Name {
    static var playbackStarted: Notification.Name {
        return .init("AudioPlayer.playbackStarted")
    }
    
    static var playbackPaused: Notification.Name {
        return .init("AudioPlayer.playbackPaused")
    }
    
    static var playbackStopped: Notification.Name {
        return .init("AudioPlayer.playbackStopped")
    }
}

private extension AudioPlayer {
    enum State {
        case idle
        case playing(Item)
        case paused(Item)
    }
    
    func stateDidChange() {
        switch state {
        case .idle:
            notificationCenter.post(name: .playbackStopped, object: nil)
        case let .playing(item):
            notificationCenter.post(name: .playbackStarted, object: item)
        case let .paused(item):
            notificationCenter.post(name: .playbackPaused, object: item)
        }
    }
}
