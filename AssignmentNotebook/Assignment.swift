//
//  Assignment.swift
//  AssignmentNotebook
//
//  Created by Emmett Hasley on 2/27/19.
//  Copyright © 2019 John Heresy High School. All rights reserved.
//

import Foundation

class Assignment : Codable {
    var name : String
    var due : String
    var classsss : String
    
    init(_ name : String, _ classs : String, _ due : String) {
        self.name = name
        classsss = classs
        self.due = due
    }
    enum CodingKeys : String, CodingKey {
        case name
        case classsss
        case due
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        classsss = try container.decode(String.self, forKey: .classsss)
        due = try container.decode(String.self, forKey: .due)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(classsss, forKey: .classsss)
        try container.encode(due, forKey: .due)
    }
    
}
