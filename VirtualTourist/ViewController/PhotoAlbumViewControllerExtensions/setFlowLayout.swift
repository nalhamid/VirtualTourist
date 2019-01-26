//
//  setFlowLayout.swift
//  VirtualTourist
//
//  Created by Moviefreak89 on 20/01/2019.
//  Copyright © 2019 Moviefreak89. All rights reserved.
//

import UIKit

extension PhotoAlbumViewController {
    // Mark: setFlowLayout
    func setFlowLayout()  {
        // set space sizes
        let space:CGFloat = 3.0
        let width = (view.frame.size.width - (2 * space)) / 3.0
        let height = (view.frame.size.height - (2 * space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
}
