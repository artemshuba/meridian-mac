//
//  MyMusicViewController.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

protocol MyMusicView : class {
    func reload()
}

class MyMusicViewController : UIViewController {
    @IBOutlet private weak var tracksTableView: UITableView!
    
    private let presenter: MyMusicPresenter
    
    init?(coder: NSCoder, presenter: MyMusicPresenter) {
        self.presenter = presenter
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        presenter.load()
    }
    
    private func setupViews() {
        tracksTableView.register(TrackCell.nib, forCellReuseIdentifier: TrackCell.reuseIdentifier)
        tracksTableView.dataSource = self
        tracksTableView.delegate = self
    }
}

extension MyMusicViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reuseIdentifier, for: indexPath) as? TrackCell else {
            fatalError("Unexpected cell type")
        }
        
        let track = presenter.tracks[indexPath.row]
        
        cell.configure(with: track)
        
        return cell
    }
}

extension MyMusicViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectTrack(at: indexPath)
    }
}

extension MyMusicViewController : MyMusicView {
    func reload() {
        tracksTableView.reloadData()
    }
}
