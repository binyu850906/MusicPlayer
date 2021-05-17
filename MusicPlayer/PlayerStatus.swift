//
//  PlayerStatus.swift
//  MusicPlayer
//
//  Created by binyu on 2021/5/16.
//

import Foundation

class PlayerStatus {
    var nowPlaying: Song? = nil
    var nowPlayIndex: Int = 0
    var duration: Double = 0
    var isPlay: Bool = false
    var playType: String = "normal" // normal, shuffle, repeat
}
