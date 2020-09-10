//
//  RootDecodable.swift
//  Users-Miho
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation

extension CodingUserInfoKey {
    static let jsonDecoderRootKeyName = CodingUserInfoKey(rawValue: "rootKeyName")!
}

class DecodableRoot<T: Codable>: Codable {

    let value: T

    class PrivateCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        var value: String?

        required init() {
            self.stringValue = ""
            self.intValue = nil
        }

        required init?(stringValue: String) {
            self.stringValue = stringValue
        }

        required init?(intValue: Int) {
            self.intValue = intValue
            stringValue = "\(intValue)"
        }

        static func key(named name: String) -> PrivateCodingKeys? {
            return PrivateCodingKeys(stringValue: name)
        }

    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PrivateCodingKeys.self)

        guard
            let keyName = decoder.userInfo[.jsonDecoderRootKeyName] as? String,
            let key = PrivateCodingKeys.key(named: keyName) else {
                throw DecodingError.valueNotFound(
                    T.self,
                    DecodingError.Context(codingPath: [], debugDescription: "Value not found at root level.")
                )
        }

        value = try container.decode(T.self, forKey: key)
    }

}
