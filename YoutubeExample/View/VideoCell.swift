//
//  VideoCell.swift
//  YoutubeExample
//
//  Created by iMAC on 4/21/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import UIKit

class VideoCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var title: UILabel!
    var playItem: Playlist!
    
    func configure(playItem: Playlist){
        self.playItem = playItem
        imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: (self.playItem.thumbnail))! as URL)! as Data)
        title.text = self.playItem.title
    }
    
}
