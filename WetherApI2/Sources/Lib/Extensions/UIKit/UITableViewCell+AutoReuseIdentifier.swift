//
// 
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

extension UITableViewCell {

    public var autoReuseIdentifier: String {
        return toString(type(of: self))
    }
}
