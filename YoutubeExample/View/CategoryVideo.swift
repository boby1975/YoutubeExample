//
//  CategoryRow.swift
//  YoutubeExample
//
//  Created by iMAC on 4/21/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import UIKit

class CategoryVideo : UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var playlist: [Playlist] = []

    func configure(playlist: [Playlist]){
        self.playlist = playlist
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.reloadData()
        collectionView.setContentOffset(CGPoint.zero, animated: false)

    }
}

extension CategoryVideo : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
        cell.configure(playItem: playlist[indexPath.row])
        return cell
    }
    
}

extension CategoryVideo: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = indexPath.row
        print("selected cell: \(selectedCell)")
    }
}


