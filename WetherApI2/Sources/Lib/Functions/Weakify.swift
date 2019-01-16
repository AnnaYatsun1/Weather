//
//  WetherApI2
//
//  Created by Anna Yatsun on 16/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

func weakify<Value1: AnyObject, Value2: AnyObject, Result>(
    object1: Value1,
    object2: Value2,
    action: @escaping(Value1, Value2, Result) -> ()
)
    -> (Result) -> ()
{
    return { [weak object1, weak object2] parameter in
        if let object1 = object1, let object2 = object2 {
            action(object1, object2, parameter)
        }
    }
}
