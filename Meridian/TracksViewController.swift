//
//  TracksViewController.swift
//  Meridian
//
//  Created by Artem Shuba on 02/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit
import VkSwift
import AVFoundation

class TracksViewController : UIViewController {
    
    var vk: VkApi!
    
var player: AVPlayer!
    
    private var tracks: [VkAudio] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        loadTracks()
    }
    
    private func loadTracks() {
        let result = vk.fetchAudios()
        
        switch result {
        case .success(let response):
            tracks = response.items.filter { $0.url?.isEmpty != true }
            tableView.reloadData()
            
        case .failure(let error):
            print(error)
        }
    }
}

extension TracksViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.textLabel?.text = "\(tracks[indexPath.row].title) - \(tracks[indexPath.row].artist)"
        
        return cell
    }
}

extension TracksViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        

        let url  = URL.init(string: track.url!)

        let playerItem: AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        player.play()
    }
}
