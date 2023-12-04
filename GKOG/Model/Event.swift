//
//  Event.swift
//  GKOG
//
//  Created by Suji Lee on 11/29/23.
//

import Foundation

struct Event: Codable, Hashable, Identifiable {
    var id: Int?
    var title: String?
    var detail: String?
    var startInfo: String? // "YY-mm-dd-hh-ss"
    var endInfo: String?// "YY-mm-dd-hh-ss"
    var lon: CGFloat?
    var lat: CGFloat?
    var category: String?
    var participants: [Member]?// 멤버 객체 리스트 List<Member>
    var comments : [Comment]? // 코멘트 객체 리스트 List<Comment>
}
