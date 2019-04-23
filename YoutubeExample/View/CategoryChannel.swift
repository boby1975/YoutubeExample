//
//  CategoryChannel.swift
//  YoutubeExample
//
//  Created by iMAC on 4/22/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import UIKit

class CategoryChannel : UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var channels: [Channel] = []
    
    func configure(channels: [Channel]){
        self.channels = channels
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.reloadData()
        collectionView.setContentOffset(CGPoint.zero, animated: false)
        
    }
}

extension CategoryChannel : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return channels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "channelCell", for: indexPath) as! ChannelCell
        cell.configure(channel: channels[indexPath.row])
        return cell
    }
    
}

extension CategoryChannel: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = indexPath.row
        print("selected cell: \(selectedCell)")
    }
}

