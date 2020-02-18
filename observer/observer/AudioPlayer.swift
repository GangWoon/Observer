//
//  AudioPlayer.swift
//  observer
//
//  Created by Cloud on 2020/02/18.
//  Copyright © 2020 Cloud. All rights reserved.
//

import UIKit

protocol AudioPlayerObserver: class {
    func audioPlayer(_ player: AudioPlayer,
                     didStartPlaying item: AudioPlayer.Item)

    func audioPlayer(_ player: AudioPlayer,
                     didPausePlaybackOf item: AudioPlayer.Item)

    func audioPlayerDidStop(_ player: AudioPlayer)
}

extension AudioPlayerObserver {
    func audioPlayer(_ player: AudioPlayer,
                     didStartPlaying item: AudioPlayer.Item) {}

    func audioPlayer(_ player: AudioPlayer,
                     didPausePlaybackOf item: AudioPlayer.Item) {}

    func audioPlayerDidStop(_ player: AudioPlayer) {}
}

class AudioPlayer {
    
    struct Item {
        
    }

    private var state = State.idle {
        // We add a property observer on 'state', which lets us
        // run a function on each value change.
        didSet { stateDidChange() }
    }
    private var observations = [ObjectIdentifier: Observation]()
    
    func addObserver(_ observer: AudioPlayerObserver) {
        let id = ObjectIdentifier(observer)
        observations[id] = Observation(observer: observer)
    }

    func removeObserver(_ observer: AudioPlayerObserver) {
        let id = ObjectIdentifier(observer)
        observations.removeValue(forKey: id)
    }
 
}

private extension AudioPlayer {
    enum State {
        case idle
        case playing(Item)
        case paused(Item)
    }
    
    struct Observation {
        weak var observer: AudioPlayerObserver?
    }

    
    func stateDidChange() {
        for (id, observation) in observations {
            guard let observer = observation.observer else {
                observations.removeValue(forKey: id)
                continue
            }
            
            switch state {
            case .idle:
                observer.audioPlayerDidStop(self)
            case let .paused(item):
                observer.audioPlayer(self, didStartPlaying: item)
            case let .playing(item):
                observer.audioPlayer(self, didStartPlaying: item)
            }
        }
    }
}
