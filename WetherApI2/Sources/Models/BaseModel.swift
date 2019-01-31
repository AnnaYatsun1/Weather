//
//  BaseModel.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 29/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class BaseModel: ObservableObject<State> {
    
    public var isUpdating = Atomic(false)
    
    override func notify(new: State, object: ObservableObject<State>.Object? = nil) {
        self.isUpdating.modify {
            switch new {
            case .updateStarted: $0 = true
            case .updateFinished: fallthrough
            case .updateFailed: fallthrough
            case .updateCancelled: $0 = false
            }
            
            super.notify(new: new)
        }
    }

}
