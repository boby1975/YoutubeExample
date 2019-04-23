//
//  ChannelCell.swift
//  YoutubeExample
//
//  Created by iMAC on 4/22/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import UIKit

class ChannelCell : UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var subs: UILabel!
    @IBOutlet weak var title: UILabel!
    var channel: Channel!
    
    func configure(channel: Channel){
        self.channel = channel
        imageView.image = UIImage(data: NSData(contentsOf: NSURL(string: (self.channel.thumbnail))! as URL)! as Data)
        title.text = self.channel.title
        subs.text = self.channel.subscriberCount + " " + NSLocalizedString("subscribers", comment: "")
    }
    
}
