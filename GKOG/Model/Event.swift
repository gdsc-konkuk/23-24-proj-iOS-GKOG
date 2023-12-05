//
//  Event.swift
//  GKOG
//
//  Created by Suji Lee on 11/29/23.
//

import Foundation

struct Event: Codable, Hashable, Identifiable {
    var id: Int? // 카카오mapId
    var hasJoined: Bool?
    var title: String?
    var detail: String?
    var startInfo: String? // "YY-mm-dd-hh-ss"
    var endInfo: String? // "YY-mm-dd-hh-ss"
    var roadAddress: String?
    var longitude: CGFloat? //경도 (x)
    var latitude: CGFloat? // 위도 (y)
    var category: String?
    var participants: [Member]?// 멤버 객체 리스트 List<Member>
    var comments : [Comment]? // 코멘트 객체 리스트 List<Comment>
}
