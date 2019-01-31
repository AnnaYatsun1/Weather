//
//  Wrap.swift
//  WetherApI2
//
//  Created by Anna Yatsun on 28/01/2019.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation

public class Wrapper {
    fileprivate let context: Any?
    fileprivate var dateFormatter: DateFormatter?
    
    public init(context: Any? = nil, dateFormatter: DateFormatter? = nil) {
        self.context = context
        self.dateFormatter = dateFormatter
    }
    
    public func wrap(object: Any) throws -> WrappedDictionary {
        return try self.wrap(object: object, enableCustomizedWrapping: false)
    }
}

public typealias WrappedDictionary = [String : Any]

public func wrap<T>(_ object: T, context: Any? = nil, dateFormatter: DateFormatter? = nil) throws -> WrappedDictionary {
    return try Wrapper(context: context, dateFormatter: dateFormatter).wrap(object: object, enableCustomizedWrapping: true)
}

public func wrap<T>(_ object: T, writingOptions: JSONSerialization.WritingOptions? = nil, context: Any? = nil, dateFormatter: DateFormatter? = nil) throws -> Data {
    return try Wrapper(context: context, dateFormatter: dateFormatter).wrap(object: object, writingOptions: writingOptions ?? [])
}


public func wrap<T>(_ objects: [T], context: Any? = nil, dateFormatter: DateFormatter? = nil) throws -> [WrappedDictionary] {
    return try objects.map { try wrap($0, context: context, dateFormatter: dateFormatter) }
}


public func wrap<T>(_ objects: [T], writingOptions: JSONSerialization.WritingOptions? = nil, context: Any? = nil, dateFormatter: DateFormatter? = nil) throws -> Data {
    let dictionaries: [WrappedDictionary] = try wrap(objects, context: context, dateFormatter: dateFormatter)
    return try JSONSerialization.data(withJSONObject: dictionaries, options: writingOptions ?? [])
}


public enum WrapKeyStyle {
    /// The keys in a dictionary produced by Wrap should match their property name (default)
    case matchPropertyName
    case convertToSnakeCase
}


public protocol WrapCustomizable {
   
    func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any?
    
    func keyForWrapping(propertyNamed propertyName: String) -> String?
   
    func wrap(propertyNamed propertyName: String, originalValue: Any, context: Any?, dateFormatter: DateFormatter?) throws -> Any?
}


public protocol WrappableKey {
    
    func toWrappedKey() -> String
}


public protocol WrappableEnum: WrapCustomizable {}


public protocol WrappableDate {
    func wrap(dateFormatter: DateFormatter) -> String
}




public enum WrapError: Error {
    
    case invalidTopLevelObject(Any)
    case wrappingFailedForObject(Any)
}


public extension WrapCustomizable {
    var wrapKeyStyle: WrapKeyStyle {
        return .matchPropertyName
    }
    
    func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return try? Wrapper(context: context, dateFormatter: dateFormatter).wrap(object: self)
    }
    
    func keyForWrapping(propertyNamed propertyName: String) -> String? {
        switch self.wrapKeyStyle {
        case .matchPropertyName:
            return propertyName
        case .convertToSnakeCase:
            return self.convertPropertyNameToSnakeCase(propertyName: propertyName)
        }
    }
    
    func wrap(propertyNamed propertyName: String, originalValue: Any, context: Any?, dateFormatter: DateFormatter?) throws -> Any? {
        return try Wrapper(context: context, dateFormatter: dateFormatter).wrap(value: originalValue, propertyName: propertyName)
    }
}


public extension WrapCustomizable {

    func convertPropertyNameToSnakeCase(propertyName: String) -> String {
        let regex = try! NSRegularExpression(pattern: "(?<=[a-z])([A-Z])|([A-Z])(?=[a-z])", options: [])
        let range = NSRange(location: 0, length: propertyName.count)
        let camelCasePropertyName = regex.stringByReplacingMatches(in: propertyName, options: [], range: range, withTemplate: "_$1$2")
        return camelCasePropertyName.lowercased()
    }
}

public extension WrappableEnum where Self: RawRepresentable {
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return self.rawValue
    }
}


extension Array: WrapCustomizable {
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return try? Wrapper(context: context, dateFormatter: dateFormatter).wrap(collection: self)
    }
}


extension Dictionary: WrapCustomizable {
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return try? Wrapper(context: context, dateFormatter: dateFormatter).wrap(dictionary: self)
    }
}


extension Set: WrapCustomizable {
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return try? Wrapper(context: context, dateFormatter: dateFormatter).wrap(collection: self)
    }
}


extension Int64: WrapCustomizable {
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return NSNumber(value: self)
    }
}


extension UInt64: WrapCustomizable {
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return NSNumber(value: self)
    }
}


extension NSString: WrapCustomizable {
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return self
    }
}


extension NSURL: WrapCustomizable {
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return self.absoluteString
    }
}


extension URL: WrapCustomizable {
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return self.absoluteString
    }
}



extension NSArray: WrapCustomizable {
    public func wrap(context: Any?, dateFormatter: DateFormatter?) -> Any? {
        return try? Wrapper(context: context, dateFormatter: dateFormatter).wrap(collection: Array(self))
    }
}




extension Date: WrappableDate {
    public func wrap(dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
}
private extension Wrapper {
    func wrap<T>(object: T, enableCustomizedWrapping: Bool) throws -> WrappedDictionary {
        if enableCustomizedWrapping {
            if let customizable = object as? WrapCustomizable {
                let wrapped = try self.performCustomWrapping(object: customizable)
                
                guard let wrappedDictionary = wrapped as? WrappedDictionary else {
                    throw WrapError.invalidTopLevelObject(object)
                }
                
                return wrappedDictionary
            }
        }
        
        var mirrors = [Mirror]()
        var currentMirror: Mirror? = Mirror(reflecting: object)
        
        while let mirror = currentMirror {
            mirrors.append(mirror)
            currentMirror = mirror.superclassMirror
        }
        
        return try self.performWrapping(object: object, mirrors: mirrors.reversed())
    }
    
    func wrap<T>(object: T, writingOptions: JSONSerialization.WritingOptions) throws -> Data {
        let dictionary = try self.wrap(object: object, enableCustomizedWrapping: true)
        return try JSONSerialization.data(withJSONObject: dictionary, options: writingOptions)
    }
    
    func wrap<T>(value: T, propertyName: String? = nil) throws -> Any? {
        if let customizable = value as? WrapCustomizable {
            return try self.performCustomWrapping(object: customizable)
        }
        
        if let date = value as? WrappableDate {
            return self.wrap(date: date)
        }
        
        let mirror = Mirror(reflecting: value)
        
        if mirror.children.isEmpty {
            if let displayStyle = mirror.displayStyle {
                switch displayStyle {
                case .enum:
                    if let wrappableEnum = value as? WrappableEnum {
                        if let wrapped = wrappableEnum.wrap(context: self.context, dateFormatter: self.dateFormatter) {
                            return wrapped
                        }
                        
                        throw WrapError.wrappingFailedForObject(value)
                    }
                    
                    return "\(value)"
                case .struct:
                    return [:]
                default:
                    return value
                }
            }
            
            if !(value is CustomStringConvertible) {
                if String(describing: value) == "(Function)" {
                    return nil
                }
            }
            
            return value
        } else if value is ExpressibleByNilLiteral && mirror.children.count == 1 {
            if let firstMirrorChild = mirror.children.first {
                return try self.wrap(value: firstMirrorChild.value, propertyName: propertyName)
            }
        }
        
        return try self.wrap(object: value, enableCustomizedWrapping: false)
    }
    
    func wrap<T: Collection>(collection: T) throws -> [Any] {
        var wrappedArray = [Any]()
        let wrapper = Wrapper(context: self.context, dateFormatter: self.dateFormatter)
        
        for element in collection {
            if let wrapped = try wrapper.wrap(value: element) {
                wrappedArray.append(wrapped)
            }
        }
        
        return wrappedArray
    }
    
    func wrap<K, V>(dictionary: [K : V]) throws -> WrappedDictionary {
        var wrappedDictionary = WrappedDictionary()
        let wrapper = Wrapper(context: self.context, dateFormatter: self.dateFormatter)
        
        for (key, value) in dictionary {
            let wrappedKey: String?
            
            if let stringKey = key as? String {
                wrappedKey = stringKey
            } else if let wrappableKey = key as? WrappableKey {
                wrappedKey = wrappableKey.toWrappedKey()
            } else if let stringConvertible = key as? CustomStringConvertible {
                wrappedKey = stringConvertible.description
            } else {
                wrappedKey = nil
            }
            
            if let wrappedKey = wrappedKey {
                wrappedDictionary[wrappedKey] = try wrapper.wrap(value: value, propertyName: wrappedKey)
            }
        }
        
        return wrappedDictionary
    }
    
    func wrap(date: WrappableDate) -> String {
        let dateFormatter: DateFormatter
        
        if let existingFormatter = self.dateFormatter {
            dateFormatter = existingFormatter
        } else {
            dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            self.dateFormatter = dateFormatter
        }
        
        return date.wrap(dateFormatter: dateFormatter)
    }
    
    func performWrapping<T>(object: T, mirrors: [Mirror]) throws -> WrappedDictionary {
        let customizable = object as? WrapCustomizable
        var wrappedDictionary = WrappedDictionary()
        
        for mirror in mirrors {
            for property in mirror.children {
                
                if (property.value as? WrapOptional)?.isNil == true {
                    continue
                }
                
                guard let propertyName = property.label else {
                    continue
                }
                
                let wrappingKey: String?
                
                if let customizable = customizable {
                    wrappingKey = customizable.keyForWrapping(propertyNamed: propertyName)
                } else {
                    wrappingKey = propertyName
                }
                
                if let wrappingKey = wrappingKey {
                    if let wrappedProperty = try customizable?.wrap(propertyNamed: propertyName, originalValue: property.value, context: self.context, dateFormatter: self.dateFormatter) {
                        wrappedDictionary[wrappingKey] = wrappedProperty
                    } else {
                        wrappedDictionary[wrappingKey] = try self.wrap(value: property.value, propertyName: propertyName)
                    }
                }
            }
        }
        
        return wrappedDictionary
    }
    
    func performCustomWrapping(object: WrapCustomizable) throws -> Any {
        guard let wrapped = object.wrap(context: self.context, dateFormatter: self.dateFormatter) else {
            throw WrapError.wrappingFailedForObject(object)
        }
        
        return wrapped
    }
}


private protocol WrapOptional {
    var isNil: Bool { get }
}

extension Optional : WrapOptional {
    var isNil: Bool {
        switch self {
        case .none:
            return true
        case .some(let wrapped):
            if let nillable = wrapped as? WrapOptional {
                return nillable.isNil
            }
            return false
        }
    }
}
