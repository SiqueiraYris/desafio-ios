import RouterKit

final class DescriptorsManager {
    private let routingHub: RoutingHub

    init(routingHub: RoutingHub) {
        self.routingHub = routingHub
    }

    func setup() {
        routingHub.register(descriptor: LoginRouteDescriptor())
        routingHub.register(descriptor: StatementRouteDescriptor())
        routingHub.register(descriptor: LauncherRouteDescriptor())
    }
}
