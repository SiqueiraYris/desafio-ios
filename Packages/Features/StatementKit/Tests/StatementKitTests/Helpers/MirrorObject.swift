import Foundation

open class MirrorObject {
    public let mirror: Mirror

    public init(reflecting: Any) {
        self.mirror = Mirror(reflecting: reflecting)
    }

    public func extract<T>(variableName: StaticString = #function) -> T? {
        return mirror.descendant("\(variableName)") as? T
    }
}
