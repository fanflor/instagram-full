//
//  PostCell.swift
//  instagram
//
//  Created by searto  on 10/14/20.
//

import UIKit

class PostCell: UITableViewCell {

    
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
