//
//  Playlist.swift
//  YoutubeExample
//
//  Created by iMAC on 4/22/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import Foundation

class Playlist {
    
    let title: String
    let thumbnail: String
    let videoID: String
    
    init(title: String, thumbnail: String, videoID: String){
        self.title = title
        self.thumbnail = thumbnail
        self.videoID = videoID        
    }
    
}
