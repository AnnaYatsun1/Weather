//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

protocol Identifiable: class, Hashable {
    
    var id: String { get }
}

extension Identifiable {
    
    var id: String {
        return ObjectIdentifier(self).hashValue.description
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }

    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
