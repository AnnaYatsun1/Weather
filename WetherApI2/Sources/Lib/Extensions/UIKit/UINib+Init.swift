//
//  
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

extension UINib {
    
    public convenience init(_ viewClass: AnyClass, bundle: Bundle? = nil) {
        self.init(nibName: toString(viewClass), bundle: bundle)
    }
}
