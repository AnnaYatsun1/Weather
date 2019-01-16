//
//  //  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

extension NSLocking {
    
    public func `do`<Result>(_ action: () -> Result) -> Result {
        self.lock()
        defer { self.unlock() }
        
        return action()
    }
}

