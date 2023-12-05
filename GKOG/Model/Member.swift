//
//  Member.swift
//  GKOG
//
//  Created by Suji Lee on 11/29/23.
//

import Foundation

struct Member: Codable, Hashable, Identifiable {
    var id: Int?
    var isRegistered: Bool?
    var email: String?
    var profileImageUrl: String?
    var nickname: String?
}
