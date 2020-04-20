//
//  PopularViewController.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

protocol PopularView : class {
    func reload()
}

class PopularViewController : UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
       
    private let presenter: PopularPresenter
    
    init?(coder: NSCoder, presenter: PopularPresenter) {
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
        tableView.register(TrackCell.nib, forCellReuseIdentifier: TrackCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension PopularViewController : UITableViewDataSource {
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

extension PopularViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.selectTrack(at: indexPath)
    }
}

extension PopularViewController : PopularView {
    func reload() {
        tableView.reloadData()
    }
}
