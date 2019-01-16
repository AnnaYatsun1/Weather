//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import UIKit

protocol RootViewRepresentable: class {
    
    associatedtype RootView
    
    var rootView: RootView? { get }
}

extension RootViewRepresentable where Self: UIViewController {
    
    var rootView: RootView? {
        return when(self.isViewLoaded) { cast(self.view) }
    }
}
