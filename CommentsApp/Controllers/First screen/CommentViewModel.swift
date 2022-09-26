//
//  CommentViewModel.swift
//  CommentsApp
//
//  Created by Vitalii on 24.09.2022.
//

import Foundation

class CommentViewModel {
    private(set) var objects = [Comment]()
    
    var updateCall: ((Error?) -> Void)? = nil
    
    // MARK: -
    init() {
        fetchAllComments()
    }
    
    func fetchAllComments() {
        let request = URLRequest(url: URL(string: "https://jsonplaceholder.typicode.com/comments")!)
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in
            DispatchQueue.main.async {   
                if let error {
                    self?.updateCall?(error)
                } else {
                    if let objects = try? JSONDecoder().decode([Comment].self, from: data!) {
                        self?.objects = objects
                        self?.updateCall?(nil)
                    }
                }
            }
        }.resume()
    }
    
    func fetchComments(fromIndex: Int, toIndex: Int) -> [Comment]? {
        if fromIndex >= 1 && fromIndex <= 499, toIndex >= 2 && toIndex <= 500 {
            return objects
                .filter { $0.id >= fromIndex && $0.id <= toIndex }
                .sorted { $0.id < $1.id }
            
        } else {
            return nil
        }
    }
}
