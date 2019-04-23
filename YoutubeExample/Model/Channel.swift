//
//  Channel.swift
//  YoutubeExample
//
//  Created by iMAC on 4/21/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import Foundation

class Channel {
    
    let title: String
    let thumbnail: String
    let playlistID: String
    let subscriberCount: String
    
    init(title: String, thumbnail: String, playlistID: String, subscriberCount: String){
        self.title = title
        self.thumbnail = thumbnail
        self.playlistID = playlistID
        self.subscriberCount = subscriberCount
    }
    
}
