//
//  Pagination.swift
//  CommentsApp
//
//  Created by Vitalii on 26.09.2022.
//

struct Pagination {
    var page: Int // def:1
    var offset: Int // def:10
    
    var count: Int {
        return page * offset
    }
    
    static var `default`: Pagination {
        return Pagination(page: 1, offset: 10)
    }
}
