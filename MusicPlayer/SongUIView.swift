//
//  SongUIView.swift
//  MusicPlayer
//
//  Created by binyu on 2021/5/16.
//

import UIKit

class SongUIView: UIView {
    var songInfo: Song?
    let touchFunc: (Song) -> Void
    var songImageView: UIImageView = UIImageView()
    var songNameLabel: UILabel = UILabel()
    
    
    
    init?(frame:CGRect, songInfo: Song?, touchFunc: @escaping (Song) -> Void) {
        self.songInfo = songInfo
        self.touchFunc = touchFunc
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(named: "DarkColor")
        self.layer.cornerRadius = 20
        
        setSongUIImage()
        setSongLabel()
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    private func setSongUIImage() {
        songImageView.frame = CGRect(x: 18, y: 5, width: 120, height: 120)
        songImageView.contentMode = .scaleAspectFill
        songImageView.layer.cornerRadius = songImageView.frame.width/2
        songImageView.backgroundColor = UIColor(named: "DarkColor")
        songImageView.clipsToBounds = true
        setinteractive(imageView: songImageView)
        self.addSubview(songImageView)
    }
    
    private func setinteractive(imageView: UIImageView) {
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.touchAction))
        imageView.addGestureRecognizer(gesture)
        print("gesture")
    }
    
    @objc private func touchAction(_ sender:UITapGestureRecognizer) {
        guard  self.songInfo != nil else {
            return
        }
        self.touchFunc(self.songInfo!)
        let index = Song.songs.firstIndex { (song) -> Bool in
            return song.songName == self.songInfo?.songName

        }
        print(index)
        playerStatus.nowPlayIndex = index ?? 0
        
    }
    
    private func setSongLabel() {
        songNameLabel.frame = CGRect(x: 0, y: 120, width: 152, height: 41)
        songNameLabel.textAlignment = .center
        songNameLabel.textColor = UIColor.white
        songNameLabel.font = .boldSystemFont(ofSize: 10)
        self.addSubview(songNameLabel)
        
        
    }
    
    
    private func setView(){
        if let songInfo = songInfo {
            songNameLabel.text = songInfo.songName
            songImageView.image = UIImage(named: songInfo.songImage)
        }else{
            songNameLabel.text = songInfo?.songName ?? "歌曲"
            songImageView.image = nil
        }
    }
    
    final func setSongInfo(info: Song?) {
         songInfo = info
        setView()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
