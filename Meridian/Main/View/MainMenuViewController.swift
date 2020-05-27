//
//  MainMenuViewController.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

class MainMenuViewController : UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var playerView: PlayerView!
    
    private var presenter: MainMenuPresenter
    private weak var player: AudioPlayer?
    
    private var selectedIndexPath: IndexPath?

    init?(coder: NSCoder, presenter: MainMenuPresenter, player: AudioPlayer) {
        self.presenter = presenter
        self.player = player
        
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MainMenuCell.nib, forCellReuseIdentifier: MainMenuCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)

        let initialViewController = MyMusicViewBuilder.build(withContext: .default)
        splitViewController?.showDetailViewController(initialViewController, sender: self)
        
        playerView.player = player
    }
}

extension MainMenuViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfGroups()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems(inGroup: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainMenuCell.reuseIdentifier, for: indexPath) as? MainMenuCell else {
            fatalError("Unexpected cell type")
        }
        
        let title = presenter.title(forItemAt: indexPath)
        
        cell.configure(with: title)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter.title(forGroup: section)
    }
}

extension MainMenuViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Avoid navigation to the same page
        guard tableView.indexPathForSelectedRow != indexPath else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow,
            let cell = tableView.cellForRow(at: selectedIndexPath) {
            cell.setSelected(false, animated: true)
        }
        
        presenter.selectItem(at: indexPath)
    }
}

// Hack to avoid default blue selection from main menu
extension MainMenuViewController : MainMenuCellDelegate {
    func mainMenuCellDidSelect(_ cell: MainMenuCell) {
        if let selectedIndexPath = selectedIndexPath,
            let selectedCell = tableView.cellForRow(at: selectedIndexPath) {
            selectedCell.setSelected(false, animated: false)
        }
            
        selectedIndexPath = tableView.indexPath(for: cell)
        tableView(tableView, didSelectRowAt: selectedIndexPath!)
    }
}
