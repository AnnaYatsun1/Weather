//
//  
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.

import UIKit

extension CGSize {

    public func minimum() -> CGFloat {
        return min(self.width, self.height)
    }
    
    public func maximum() -> CGFloat {
        return max(self.width, self.height)
    }
}
