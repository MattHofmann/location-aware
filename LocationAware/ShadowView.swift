//
//  ShadowView.swift
//  LocationAware
//
//  Created by Matthias Hofmann on 03.10.16.
//  Copyright © 2016 MatthiasHofmann. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // add dropshadow
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 15.0
    }
    
    
}
