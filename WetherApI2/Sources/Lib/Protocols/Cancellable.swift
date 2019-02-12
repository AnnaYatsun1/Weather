//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

enum States {
    case didLoad
    case inLoad
    case idle
    case canceled
}

protocol Cancellable {
    
    var isCancelled: Bool { get }
    
    func cancel()
}

//protocol CancellableWith<States> {
//    
//    var isCancelled: Bool { get }
//    
//    func cancel()
//}
