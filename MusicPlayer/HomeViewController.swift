//
//  HomeViewController.swift
//  MusicPlayer
//
//  Created by binyu on 2021/5/15.
//

import UIKit
import AVFoundation

let player = AVPlayer()
let playerStatus = PlayerStatus()

class HomeViewController: UIViewController {

    @IBOutlet weak var nowPlayingSheet: UIView!
    @IBOutlet weak var nowPlayingButton: UIButton!
    @IBOutlet weak var nowPlayingImageView: UIImageView!
    @IBOutlet weak var nowPlayingSongLabel: UILabel!
    @IBOutlet weak var nowPlayingSingerLabel: UILabel!
    
    
    @IBOutlet weak var singerScrollView: UIScrollView!
    @IBOutlet weak var singerView: UIView!
    @IBOutlet weak var albumScrollView: UIScrollView!
    @IBOutlet weak var albumView: UIView!
    @IBOutlet weak var songView: UIView!
    @IBOutlet weak var songScrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNowPlayingSheet()
        initSingerCard()
        initAlbumCard()
        initSongCard()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) {(_) in
            self.playNextSong()
            self.setNowPlayingView()
            NotificationCenter.default.post(name: Notification.Name("setMusicView"), object: nil)
            
            
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(playPause), name: NSNotification.Name("playPause"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(nextSong), name: NSNotification.Name("nextSong"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(playPrevSong), name: NSNotification.Name("PrevSong"), object: nil)
        
        
        
    }
    
    func initSingerCard() {
        let beginningX = 10
        for (index, data) in SingerData.singers.enumerated(){
            let frame = CGRect(x: beginningX+index*160, y: 0, width: 152, height: 152)
            singerView.addSubview(SingerUIView(frame: frame, singerName: data.singerName, singerImage: UIImage(named: data.singerImage)!)!)
        }
    }
    
    func initAlbumCard(){
        let beginnimgX = 10
        for (index,data) in Album.albums.enumerated(){
            let frame = CGRect(x: beginnimgX+index*160, y: 0, width: 152, height: 152)
            albumView.addSubview(AlbumUIView(frame: frame, albumName: data.albumName, albumImage: UIImage(named: data.albumImage)!)!)
        }
    }
    
    
    func initSongCard(){
        let beginning = 10
        for (index,data) in Song.songs.enumerated() {
            let frame = CGRect(x: beginning+index*160, y: 0, width: 152, height: 152)
            songView.addSubview(SongUIView(frame: frame, songInfo: data, touchFunc: songViewTouchAction)!)
        }
    }
    
    func initNowPlayingSheet() {
        setNowPlayingView()
        nowPlayingSheet.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.toCurrentMusicPage))
        nowPlayingSheet.addGestureRecognizer(gesture)
        
        
    }
    
    @objc func toCurrentMusicPage() {
        if let controller = storyboard?.instantiateViewController(identifier: "MusicViewController") as? MusicViewController,let _ = playerStatus.nowPlaying {
            present(controller, animated: true, completion: nil)
            // set Song
        }
    }
    
    @objc func toNextMusicPage() {
        if let controller = storyboard?.instantiateViewController(identifier: "MusicViewController") as? MusicViewController {
            present(controller, animated: true, completion: nil)
            setNowPlayingView()
            if let nextSong = playerStatus.nowPlaying {
                playMusic(nextSong)
            }
        }
    }
    
    func songViewTouchAction(nextSongInfo: Song) {
        if playerStatus.nowPlaying?.songName == nextSongInfo.songName{
            toCurrentMusicPage()
        }else{
            playerStatus.nowPlaying = nextSongInfo
            toNextMusicPage()
        }
    }
    func playMusic(_ resource: Song) {
        let fileUrl = Bundle.main.url(forResource: resource.songName, withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: fileUrl)
        print(fileUrl)
        playerStatus.duration = playerItem.asset.duration.seconds
        player.replaceCurrentItem(with: playerItem)
        player.play()
        playerStatus.isPlay = true
        setPlayButton()//設定播放暫停按鈕
        
    }
    
    func resumeMusic() {
        player.play()
        playerStatus.isPlay = true
        setPlayButton()
    }
    
    func pauseMusic() {
        player.pause()
        playerStatus.isPlay = false
        setPlayButton()
    }
    
    func setPlayButton() {
        if playerStatus.isPlay {
            nowPlayingButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }else{
            nowPlayingButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    func setNowPlayingView() {
        if let currentSong = playerStatus.nowPlaying {
            nowPlayingImageView.image = UIImage(named: currentSong.songImage)
            nowPlayingSongLabel.text = currentSong.songName
            nowPlayingSingerLabel.text = currentSong.singerName
        }else{
            nowPlayingImageView.image = nil
            nowPlayingSongLabel.text = "查無此歌曲"
            nowPlayingSingerLabel.text = "查無此歌手"
        }
    }
    
    
    
    
    
    @IBAction func playPause(_ sender: Any) {
        if playerStatus.isPlay {
            pauseMusic()
        }else{
            if playerStatus.nowPlaying == nil{
                playerStatus.nowPlaying = Song.songs[playerStatus.nowPlayIndex]
                playMusic(playerStatus.nowPlaying!)
                setNowPlayingView()
            }
            resumeMusic()
        }
    }
    @IBAction func nextSong(_ sender: Any) {
        playNextSong()
    }
    
    func playNextSong() {
        if playerStatus.nowPlaying == nil {
            playerStatus.nowPlaying = Song.songs[playerStatus.nowPlayIndex]
        } else {
            if playerStatus.playType != "repeat" {
                playerStatus.nowPlayIndex += 1
                if (playerStatus.nowPlayIndex > Song.songs.count - 1) {
                    playerStatus.nowPlayIndex = 0
                }
            }
            playerStatus.nowPlaying = Song.songs[playerStatus.nowPlayIndex]
        }
        playMusic(playerStatus.nowPlaying!)
        setNowPlayingView()
    }
    @objc func playPrevSong() {
        if playerStatus.playType != "repeat" {
            playerStatus.nowPlayIndex -= 1
            if (playerStatus.nowPlayIndex < 0){
                playerStatus.nowPlayIndex = Song.songs.count - 1
            }
        }
        playerStatus.nowPlaying = Song.songs[playerStatus.nowPlayIndex]
        playMusic(playerStatus.nowPlaying!)
        setNowPlayingView()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
