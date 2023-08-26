//
//  MessageCellTableViewCell.swift
//  ChatApp
//
//  Created by Ashraf Eltantawy on 24/08/2023.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {

    @IBOutlet weak var imageRecver: UIImageView!
    @IBOutlet weak var imageSender: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var viewOfBody: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        viewOfBody.layer.cornerRadius = viewOfBody.frame.size.height / 2
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
