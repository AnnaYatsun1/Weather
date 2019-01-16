//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

extension Sequence {
    
    public func array() -> [Element] {
        return self.map { $0 }
    }
}
