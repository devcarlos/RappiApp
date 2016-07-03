//
//  CollectionAppCell.swift
//  RappiApp
//
//  Created by Carlos Alcala on 7/3/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

import UIKit
import AlamofireImage

class CollectionAppCell: UICollectionViewCell {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(app: App) {
        
        //placeholder image
        let placeholderImage = UIImage(named: "placeholder")!
        self.imageView.image = placeholderImage
        
        //download image URL async if internet is available
        if InternetHandler.shared.isReachable() {
            let URL = NSURL(string: app.imageURL)!
            
            //change radius
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: imageView.frame.size,
                radius: 10.0
            )
            
            self.imageView.af_setImageWithURL(
                URL,
                placeholderImage: placeholderImage,
                filter: filter
            )
        }
        
        
        //app name
        self.nameLabel.text = app.name
        
        self.layer.cornerRadius = 10
        
    }

}
