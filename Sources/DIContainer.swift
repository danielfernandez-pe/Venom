//
//  Venom.swift
//  Venom
//
//  Created by Daniel Fernandez Yopla on 21.03.2025.
//

import Swinject
import Foundation

public final class DIContainer: DICProtocol, @unchecked Sendable {
    public static let shared = DIContainer()
    
    private var factories: [String: Any] = [:]
    private var singletons: [String: Any] = [:]
    private var scopes: [String: Scope] = [:]
    private let container = Container()
    
    private init() {}
    
    public func register<Service>(_ type: Service.Type, scope: Scope, factory: @escaping () -> Service) {
        let key = String(describing: type)
        factories[key] = factory
        scopes[key] = scope
    }
    
    public func register<Service, Arg1>(type: Service.Type, scope: Scope, factory: @escaping (Arg1) -> Service) {
        let key = String(describing: type) + "_1"
        factories[key] = factory
        scopes[key] = scope
    }
    
    public func resolve<Service>(_ type: Service.Type) -> Service {
        let key = String(describing: type)
        guard let scope = scopes[key] else {
            fatalError("Service scope wasn't register properly")
        }
        
        switch scope {
        case .container:
            if let instance = singletons[key] as? Service {
                return instance
            }
            
            guard let factory = factories[key] as? () -> Service else {
                fatalError("Service wasn't register previously")
            }
            
            let instance = factory()
            singletons[key] = instance
            return instance
        case .transient:
            guard let factory = factories[key] as? () -> Service else {
                fatalError("Service wasn't register previously")
            }
            return factory()
        }
    }
    
    public func resolve<Service, Arg1>(_ type: Service.Type, arg1: Arg1) -> Service {
        let key = String(describing: type) + "_1"
        guard let scope = scopes[key] else {
            fatalError("Service scope wasn't registered properly")
        }
        
        switch scope {
        case .container:
            guard let factory = factories[key] as? (Arg1) -> Service else {
                fatalError("Service wasn't registered previously with this argument type")
            }
            return factory(arg1)
        case .transient:
            guard let factory = factories[key] as? (Arg1) -> Service else {
                fatalError("Service wasn't registered previously with this argument type")
            }
            return factory(arg1)
        }
    }
}
