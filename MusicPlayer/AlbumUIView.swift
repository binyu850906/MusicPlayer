//
//  AlbumUIView.swift
//  MusicPlayer
//
//  Created by binyu on 2021/5/16.
//

import UIKit

class AlbumUIView: UIView {
    let albumName: String
    let albumImage: UIImage
    
    init?(frame: CGRect ,albumName: String ,albumImage: UIImage) {
        self.albumName = albumName
        self.albumImage = albumImage
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(named: "DarkColor")
        self.layer.cornerRadius = 20
        
        setAlbumImage()
      //  setAlbumNameUIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setAlbumImage(){
        let albumImage = UIImageView()
        albumImage.frame = CGRect(x: 22, y: 0, width: 106, height: 152)
        albumImage.image = self.albumImage
        albumImage.contentMode = .scaleAspectFill
        albumImage.clipsToBounds = true
        self.addSubview(albumImage)
    }
    
   /*private func setAlbumNameUIView(){
        let albumNameUIView = UIView()
        albumNameUIView.frame = CGRect(x: 0, y: 115, width: 152, height: 41)
        albumNameUIView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        albumNameUIView.layer.cornerRadius = 20
        albumNameUIView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        let albumNamelabel = UILabel(frame: CGRect(x: 16, y: 0, width: 152, height: 20))
        albumNamelabel.text = self.albumName
        albumNamelabel.font = UIFont.boldSystemFont(ofSize: 10)
        albumNamelabel.textAlignment = .left
        albumNamelabel.textColor = UIColor.white
        albumNameUIView.addSubview(albumNamelabel)
        self.addSubview(albumNameUIView)
    }*/
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
