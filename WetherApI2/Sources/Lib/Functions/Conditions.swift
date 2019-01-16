//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public func when<Result>(_ condition: Bool, execute: () -> Result?) -> Result? {
    return condition ? execute() : nil
}

public func unless<Result>(_ condition: Bool, exetute: () -> Result? ) -> Result? {
    return when(!condition, execute: exetute)
}


