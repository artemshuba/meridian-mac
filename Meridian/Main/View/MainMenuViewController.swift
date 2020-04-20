//
//  MainMenuViewController.swift
//  Meridian
//
//  Created by Artem Shuba on 05/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

protocol MainMenuViewControllerDelegate : class {
    func mainMenu(_ mainMenuViewController: MainMenuViewController, didSelectRowAt indexPath: IndexPath)
}

class MainMenuViewController : UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var playerView: PlayerView!
    
    private var presenter: MainMenuPresenter
    private weak var player: AudioPlayer?
    
    private var selectedIndexPath: IndexPath?
    
    weak var menuDelegate: MainMenuViewControllerDelegate?
    
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
        //menuDelegate?.mainMenu(self, didSelectRowAt: indexPath)
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow,
            let cell = tableView.cellForRow(at: selectedIndexPath) {
            cell.setSelected(false, animated: true)
        }
        
        var detailViewController: UIViewController? = nil
        
        switch indexPath.section {
        case 0:
            detailViewController = MyMusicViewBuilder.build(withContext: .default)
        case 1:
            detailViewController = PopularViewBuilder.build(withContext: .default)
        default:
            break
        }

        if let detailViewController = detailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: self)
        }
    }
}

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
