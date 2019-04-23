//
//  ViewController.swift
//  YoutubeExample
//
//  Created by iMAC on 4/21/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var channelsList: [Channel] = []
    var playlist: [Playlist] = []
    let queryService = QueryService()
    var pullupController: PlayerViewController!
    
    let desiredChannelsArray = ["Apple", "Google", "Microsoft"]
    
    var categories = ["YouTubeAPI", "Playlist-1", "Playlist-2"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPullUpController()
        tableView.delegate = self
        tableView.dataSource = self
        getChannels(forUsername: desiredChannelsArray[1])
    }

    
    //MARK: Private
    fileprivate func getChannels(forUsername: String){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        queryService.getChannelResult(forUsername: forUsername) { results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let results = results {
                self.channelsList = results
                if results.count > 0 {
                    self.getPlaylist(playlistID: self.channelsList[0].playlistID)
                    print ("result query channels ok")
                } else {
                    print ("query channels no records")
                }
            }
            if !errorMessage.isEmpty { print("query channels error: " + errorMessage) }
        }
    }
    
    fileprivate func getPlaylist(playlistID: String){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        queryService.getPlaylistResult(playlistID: playlistID) { results, errorMessage in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            if let results = results {
                self.playlist = results
                self.tableView.reloadData()
                
                if self.playlist.count > 0 {
                    print ("result query playlist ok")
                } else {
                    print ("query playlist no records")
                }
            }
            if !errorMessage.isEmpty { print("query playlist error: " + errorMessage) }
        }
    }
    
    private func addPullUpController() {
        
        guard
            let pullUpController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "PlayerViewController") as? PlayerViewController
            else { return }
        
        pullupController = pullUpController
        addPullUpController(pullUpController, animated: true)
    }
}


extension MainViewController : UITableViewDelegate { }

extension MainViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellChannels") as! CategoryChannel
            cell.configure(channels: channelsList)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellPlaylist") as! CategoryVideo
            cell.configure(playlist: playlist)
            return cell
        }
        
        
    }
    
}
