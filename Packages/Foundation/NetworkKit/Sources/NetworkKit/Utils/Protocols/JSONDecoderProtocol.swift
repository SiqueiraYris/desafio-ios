import Foundation

protocol JSONDecoderProtocol: AnyObject {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension JSONDecoder: JSONDecoderProtocol { }
