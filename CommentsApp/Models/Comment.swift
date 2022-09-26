//
//  Comment.swift
//  CommentsApp
//
//  Created by Vitalii on 24.09.2022.
//

import Foundation

struct Comment: Decodable {
    var id: Int
    var name: String
    var email: String
    var body: String
}

extension Comment {
    static var example: Comment {
        return Comment(id: 1, name: "test name", email: "test@email", body: "text body")
    }
}
