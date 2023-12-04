//
//  Comment.swift
//  GKOG
//
//  Created by Suji Lee on 11/29/23.
//

import Foundation

struct Comment: Codable, Hashable, Identifiable {
    var id: Int?
    var profileImageUrl: String?
    var nickname: String?
    var commentImageUrl: String?
    var contents: String?
}
