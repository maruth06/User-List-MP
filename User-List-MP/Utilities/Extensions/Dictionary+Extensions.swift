//
//  Dictionary+Extension.swift
//  Users-Miho
//
//  Created by Mac on 9/8/20.
//  Copyright © 2020 Miho. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func toJSON() -> String? {
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            let string = String(data: jsonData, encoding: .utf8)
            
            return string
        } else {
            return nil
        }
    }
}
