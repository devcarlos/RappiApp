//
//  AppCell.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/2/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import AlamofireImage

class AppCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(app: App) {
        
        //icon image
        let placeholderImage = UIImage(named: "placeholder")!
        self.icon.image = placeholderImage
        
        //download image URL async if internet is available
        if InternetHandler.shared.isReachable() {
            let URL = NSURL(string: app.imageURL)!
            
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: icon.frame.size,
                radius: 10.0
            )
            
            self.icon.af_setImageWithURL(
                URL,
                placeholderImage: placeholderImage,
                filter: filter
            )
        }

        
        //app name
        self.nameLabel.text = app.name
        
        //summary
        self.summaryLabel.text = app.summary
        
    }
    
}
