//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

extension DispatchTime {
    
    public static func after(interval: TimeInterval) -> DispatchTime {
        return .now() + interval
    }
    
    public static func afterRandomInterval(in range: Range<Double>) -> DispatchTime {
        return self.after(interval: .random(in: range))
    }
    
    public static func afterRandomInterval(in range: ClosedRange<Double>) -> DispatchTime {
        return self.after(interval: .random(in: range))
    }
}
