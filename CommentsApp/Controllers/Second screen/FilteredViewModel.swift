//
//  FilteredViewModel.swift
//  CommentsApp
//
//  Created by Vitalii on 26.09.2022.
//

import Foundation

class FilteredViewModel {
    private var comments: [Comment]
    
    init(comments: [Comment]) {
        self.comments = comments
    }
    
    func item(by indexPath: IndexPath) -> Comment {
        return comments[indexPath.item]
    }
    
    func dataSource(pagination: Pagination) -> [Comment] {
        let nxtCount = pagination.count
        if comments.count > nxtCount {
            return Array(comments.prefix(nxtCount))
        } else {
            return comments
        }
    }
    
    func isPosibleToLoadMore(pagination: Pagination) -> Bool {
        comments.count > pagination.count
    }
}
