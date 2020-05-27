//
//  MainMenuCell.swift
//  Meridian
//
//  Created by Artem Shuba on 06/04/2020.
//  Copyright © 2020 Artem Shuba. All rights reserved.
//

import UIKit

protocol MainMenuCellDelegate : class {
    func mainMenuCellDidSelect(_ cell: MainMenuCell)
}

class MainMenuCell: UITableViewCell {
    weak var delegate: MainMenuCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        tapRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapRecognizer)
    }
    
    func configure(with title: String) {
        textLabel?.text = title
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: animated)
    }
    
    @objc
    private func onTap(_ sender: UIGestureRecognizer) {
        delegate?.mainMenuCellDidSelect(self)
        setSelected(true, animated: false)

    }
}
