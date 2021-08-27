//
//  File.swift
//  
//
//  Created by Victor Capilla Developer on 27/8/21.
//

import Foundation
// ["id": 1, "completed": 0, "userId": 1, "title": delectus aut autem]
struct ExampleModel: Codable {
    let id: Int
    let userId: Int
    let title: String
    let completed: Bool
}
