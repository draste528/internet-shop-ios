import Foundation

protocol ServiceLocating: Sendable {
    func register<Service>(_ service: Service, for type: Service.Type)
    func resolve<Service>(_ type: Service.Type) -> Service?
}

final class ServiceLocator: ServiceLocating, @unchecked Sendable {
    static let shared = ServiceLocator()

    private let lock = NSLock()
    private var services: [ObjectIdentifier: Any] = [:]

    init() {}

    func register<Service>(_ service: Service, for type: Service.Type) {
        lock.lock()
        defer { lock.unlock() }
        services[ObjectIdentifier(type)] = service
    }

    func resolve<Service>(_ type: Service.Type) -> Service? {
        lock.lock()
        defer { lock.unlock() }
        return services[ObjectIdentifier(type)] as? Service
    }
}
