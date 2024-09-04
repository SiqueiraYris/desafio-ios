@testable import NetworkKit

final class ReachabilitySpy: ReachabilityProtocol {
    var allowsCellularConnection = true
    var connection: NetworkKit.Reachability.Connection = .wifi
}
