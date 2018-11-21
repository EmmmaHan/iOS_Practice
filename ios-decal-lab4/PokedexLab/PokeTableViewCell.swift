//
//  PokeTableViewCell.swift
//  PokedexLab
//
//  Created by Emma Han on 10/17/18.
//  Copyright © 2018 iOS Decal. All rights reserved.
//

import Foundation
import UIKit

class PokeTableViewCell: UITableViewCell {
    @IBOutlet weak var pokeimage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var keyStats: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
