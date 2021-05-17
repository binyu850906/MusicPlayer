//
//  SingerData.swift
//  MusicPlayer
//
//  Created by binyu on 2021/5/15.
//

import Foundation

struct SingerData: Equatable{
    let singerName: String
    let singerImage: String
    
    static var singers: [SingerData] {
       return [SingerData(singerName: "華晨宇", singerImage: "華晨宇"), SingerData(singerName: "瘦子", singerImage: "瘦子"), SingerData(singerName: "周興哲", singerImage: "周興哲"), SingerData(singerName: "蕭敬騰", singerImage: "蕭敬騰"), SingerData(singerName: "蔡健雅", singerImage: "蔡健雅")]
    }
}


struct Album: Equatable {
    let albumName: String
    let albumImage: String
    
    static var albums: [Album] {
        return [Album(albumName: "新世界", albumImage: "新世界"), Album(albumName: "你要相信這不是最後一天", albumImage: "你要相信這不是最後一天"), Album(albumName: "好想愛這個世界啊", albumImage: "好想愛這個世界啊"), Album(albumName: "與火星的孩子對話", albumImage: "與火星的孩子對話"), Album(albumName: "寒鴉少年", albumImage: "寒鴉少年")]
    }
}

struct Song: Equatable {
    let songName: String
    let songImage: String
    let singerName: String
    
    static var songs: [Song]{
        return [Song(songName: "鬥牛", songImage: Album.albums[0].albumImage, singerName: "華晨宇"), Song(songName: "好想愛這個世界啊", songImage: Album.albums[0].albumImage,singerName: "華晨宇"), Song(songName: "瘋人院", songImage: Album.albums[0].albumImage, singerName: "華晨宇"), Song(songName: "與火星的孩子對話", songImage: Album.albums[0].albumImage,singerName: "華晨宇"), Song(songName: "七重人格", songImage: Album.albums[0].albumImage, singerName: "華晨宇")]
    }
}
