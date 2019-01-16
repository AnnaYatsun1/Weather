//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

class AbstractCancellableObject<Storage> {
    
    public var value: Storage {
        get { return self.atomicCancellable.value }
        set { self.atomicCancellable.value = newValue }
    }
    
    private let atomicCancellable: Atomic<Storage>
    
    // MARK: - Initialization
    deinit {
        self.atomicCancellable.value = self.atomicCancellable.value
    }

    init(initial: Storage, dispose: @escaping (Storage) -> ()) {
        self.atomicCancellable = Atomic(initial, lock: .init(), willSet: { dispose($0.old) })
    }
}

class CancellableObject: AbstractCancellableObject<Cancellable?> {
    
    // MARK: - Initialization
    init() {
        super.init(initial: nil) {
            $0?.cancel() }
    }
}

class CompositeCancellableObject: AbstractCancellableObject<[Cancellable]> {
    
    // MARK: - Initialization
    init() {
        super.init(initial: []) {
            $0.forEach { $0.cancel()  }
        }
    }
}
