//
//  ListTableViewCell.swift
//  EU
//
//  Created by Korlin Favara on 1/4/22.
//

import UIKit

protocol ListTableViewCellDelegate: AnyObject {
    func euroBoxButtonToggled(sender: ListTableViewCell)
}

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var euroBoxButton: UIButton!
    
    weak var delegate: ListTableViewCellDelegate?
    
    var nation: Nation! {
        didSet {
            nameLabel.text = nation.name
            capitalLabel.text = "Capital: \(nation.capital)"
            euroBoxButton.isSelected = nation.euro
        }
    }
    
    
    @IBAction func euroButtonToggled(_ sender: UIButton) {
        delegate?.euroBoxButtonToggled(sender: self )
    }
    
    
}
