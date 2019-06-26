//
//  tableviewcellEvent.swift
//  Eventmanage
//
//  Created by Jenish on 25/06/19.
//  Copyright © 2019 Jenish. All rights reserved.
//

import UIKit

class tableviewcellEvent: UITableViewCell {
    
    
    @IBOutlet weak var labelEventname: UILabel!
    @IBOutlet weak var labelEventPlaceName: UILabel!
    @IBOutlet weak var labelEventDateTime: UILabel!
    @IBOutlet weak var imageEventImages: UIImageView!
    @IBOutlet weak var imageEventLike: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()

        imageEventImages.layer.borderWidth = 0
        imageEventImages.layer.masksToBounds = false
        imageEventImages.layer.borderColor = UIColor.black.cgColor
        imageEventImages.layer.cornerRadius = imageEventImages.frame.height / 8
        imageEventImages.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
}
