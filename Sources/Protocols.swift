//
//  Protocols.swift
//  Venom
//
//  Created by Daniel Fernandez Yopla on 03.04.2025.
//

public protocol DICRegistering {
    func register<Service>(_ type: Service.Type, scope: Scope, factory: @escaping (DICResolvering) -> Service)
    func register<Service, Arg1>(_ type: Service.Type, scope: Scope, factory: @escaping (DICResolvering, Arg1) -> Service)
}

public protocol DICResolvering {
    func resolve<Service>(_ type: Service.Type) -> Service
    func resolve<Service, Arg1>(_ type: Service.Type, arg1: Arg1) -> Service
}

public protocol DICProtocol: DICRegistering, DICResolvering {}

public extension DICResolvering {
    func resolve<Service>() -> Service {
        return self.resolve(Service.self)
    }
    
    func resolve<Service, Arg1>(arg1: Arg1) -> Service {
        return self.resolve(Service.self, arg1: arg1)
    }
}
