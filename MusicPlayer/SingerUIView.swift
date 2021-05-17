//
//  SingerUIView.swift
//  MusicPlayer
//
//  Created by binyu on 2021/5/16.
//

import UIKit

class SingerUIView: UIView {
    let singerName: String
    let singerImage: UIImage
    
    init?(frame: CGRect,singerName: String, singerImage: UIImage) {
        self.singerName = singerName
        self.singerImage = singerImage
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "DarkColor")
        self.layer.cornerRadius = 20
        setSingerUIImage()
        setNameUIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSingerUIImage() {
        let singerImage = UIImageView()
        singerImage.frame = CGRect(x: 18, y: 5, width: 120, height: 120)
        singerImage.image = self.singerImage
        singerImage.contentMode = .scaleAspectFill
        singerImage.layer.cornerRadius = singerImage.frame.width/2
        singerImage.clipsToBounds = true
        self.addSubview(singerImage)
    }
    
    private func setNameUIView() {
        let singerNameView = UIView(frame: CGRect(x: 0, y: 120, width: 152, height: 41))
        singerNameView.layer.cornerRadius = 20
        //set 底下兩邊圓角
        singerNameView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        singerNameView.backgroundColor = UIColor(red: 124, green: 114, blue: 135, alpha: 0)
        let nameLabel = UILabel(frame: CGRect(x: 0, y: 10, width: 152, height: 20))
        nameLabel.text = self.singerName
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.white
        singerNameView.addSubview(nameLabel)
        self.addSubview(singerNameView)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
