//
//  QueryService.swift
//  YoutubeExample
//
//  Created by iMAC on 4/21/19.
//  Copyright © 2019 BM-IT. All rights reserved.
//

import Foundation

// Runs query data task and stores result in array
class QueryService {
    let apiKey = "YOUR API KEY"
    
    
    
    typealias JSONDictionary = [String: Any]
    typealias ChannelResult = ([Channel]?, String) -> ()
    typealias PlaylistResult = ([Playlist]?, String) -> ()
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var channels: [Channel] = []
    var playlist: [Playlist] = []
    var errorMessage = ""
    
    
    func getChannelResult(forUsername: String, completion: @escaping ChannelResult) {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://www.googleapis.com/youtube/v3/channels") {
            urlComponents.query = "part=statistics,contentDetails,snippet&forUsername=\(forUsername)&key=\(apiKey)"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    self.errorMessage += "Channel DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updateChannelResult(data)
                    
                    DispatchQueue.main.async {
                        completion(self.channels, self.errorMessage)
                    }
                }
            }
            
            dataTask?.resume()
        }
    }
    
    fileprivate func updateChannelResult(_ data: Data) {
        var response: JSONDictionary?
        channels.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary

        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["items"] as? [Any] else {
            errorMessage += "Response does not contain items key\n"
            return
        }
        var index = 0
        for channelDictionary in array {
            if let channelDictionary = channelDictionary as? JSONDictionary,
                let title = (channelDictionary["snippet"] as! JSONDictionary)["title"] as? String,
                let thumbnail = (((channelDictionary["snippet"] as! JSONDictionary)["thumbnails"] as! JSONDictionary)["default"]  as! JSONDictionary)["url"] as? String,
                let playlistID = ((channelDictionary["contentDetails"] as! JSONDictionary) ["relatedPlaylists"] as! JSONDictionary )["uploads"] as? String,
                let subscriberCount = (channelDictionary["statistics"] as! JSONDictionary)["subscriberCount"] as? String {
                
                channels.append(Channel(title: title, thumbnail: thumbnail, playlistID: playlistID, subscriberCount: subscriberCount ))
                index += 1
            } else {
                errorMessage += "Problem parsing channelDictionary\n"
            }
        }
        
        print("channel index=\(index)")
    }
    
    func getPlaylistResult(playlistID: String, completion: @escaping PlaylistResult) {
        
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string: "https://www.googleapis.com/youtube/v3/playlistItems") {
            urlComponents.query = "part=snippet&maxResults=20&playlistId=\(playlistID)&key=\(apiKey)"
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.dataTask = nil }
                
                if let error = error {
                    self.errorMessage += "Playlist DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updatePlaylistResult(data)
                    
                    DispatchQueue.main.async {
                        completion(self.playlist, self.errorMessage)
                    }
                }
            }
            
            dataTask?.resume()
        }
    }
    
    fileprivate func updatePlaylistResult(_ data: Data) {
        var response: JSONDictionary?
        playlist.removeAll()
        
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
            
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        guard let array = response!["items"] as? [Any] else {
            errorMessage += "Response does not contain items key\n"
            return
        }
        var index = 0
        for playlistDictionary in array {
            if let playlistDictionary = playlistDictionary as? JSONDictionary,
                let title = (playlistDictionary["snippet"] as! JSONDictionary)["title"] as? String,
                let thumbnail = (((playlistDictionary["snippet"] as! JSONDictionary)["thumbnails"] as! JSONDictionary)["default"]  as! JSONDictionary)["url"] as? String,
                let videoID = ((playlistDictionary["snippet"] as! JSONDictionary) ["resourceId"] as! JSONDictionary )["videoId"] as? String {
                
                playlist.append(Playlist(title: title, thumbnail: thumbnail, videoID: videoID))
                index += 1
            } else {
                errorMessage += "Problem parsing playlistDictionary\n"
            }
        }
        
        print("playlist index=\(index)")
    }
    
    
    
    
}
