//
//  SpotifyHeaderView.swift
//  arithmetical
//
//  Created by Pedro Sandoval on 1/15/17.
//  Copyright © 2017 Sandoval Software. All rights reserved.
//

import UIKit

class SpotifyHeaderView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var streakProgressView: UIProgressView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        Bundle.main.loadNibNamed("SpotifyHeaderView", owner: self, options: nil)
        self.addSubview(view)
    }

}
