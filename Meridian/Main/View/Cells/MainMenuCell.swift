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
        
        selectionStyle = .gray
        let color = selectedBackgroundView?.value(forKey: "_selectionTintColor") as? UIColor
        
        let vibrancyEffect = UIVibrancyEffect()
        let visualEffectView = UIVisualEffectView(effect: vibrancyEffect)
        
        let bgColorView = UIView()
//        bgColorView.backgroundColor = color  //UIColor.systemGray
        bgColorView.addSubview(visualEffectView)
//        selectedBackgroundView = bgColorView
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap))
        tapRecognizer.numberOfTapsRequired = 1
        addGestureRecognizer(tapRecognizer)
    }
    
    func configure(with title: String) {
        textLabel?.text = title
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        selectedBackgroundView?.backgroundColor = .green
//        selectedBackgroundView?.setValue(nil, forKey: "_selectionEffectsView")
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(false, animated: animated)
        
//        selectedBackgroundView?.setValue(nil, forKey: "_selectionEffectsView")
    }
    
    @objc
    private func onTap(_ sender: UIGestureRecognizer) {
//        setHighlighted(true, animated: true)
        delegate?.mainMenuCellDidSelect(self)
        setSelected(true, animated: false)

    }
}

extension UIColor {

    func toRGBAString(uppercased: Bool = true) -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgba = [r, g, b, a].map { $0 * 255 }.reduce("", { $0 + String(format: "%02x", Int($1)) })
        return uppercased ? rgba.uppercased() : rgba
    }

}
