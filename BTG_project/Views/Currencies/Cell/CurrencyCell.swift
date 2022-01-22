//
//  CurrencyCell.swift
//  BTG_project
//
//  Created by matheus.s.franca on 23/08/21.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var initials: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func configCell(data: CurrencyModel) {
        self.name.text = data.name
        self.initials.text = data.initials
    }
}
