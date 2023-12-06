//
//  ListView.swift
//  GKOG
//
//  Created by Suji Lee on 11/7/23.
//

import SwiftUI

// Category 및 Category별 색상을 enum으로 설정.
enum Category {
    case study
    case club
    case bungae
    case notice
    var representColor: Color {
        switch self {
        case .study:
            return Color.hexF4E698
        case .club:
            return Color.hexC8E48B
        case .bungae:
            return Color.hexBBE8F6
        case .notice:
            return Color.hexF6BFBB
        }
    }
}

struct EventData: Hashable {
    let category: Category
    let title: String
    let tag: String
    let time: String
    let location: String
}

let eventDataList: [EventData] = [
        EventData(category: .club, title: "이벤트", tag: "#iOS #비정규 #노회식", time: "23-12-06 - 23-12-06", location: "지존iOS 광진구 정복"),
        EventData(category: .club, title: "이벤트", tag: "#iOS #비정규 #노회식", time: "23-12-06 - 23-12-06", location: "지존iOS 광진구 정복"),
        EventData(category: .study, title: "이벤트", tag: "#iOS #비정규 #노회식", time: "23-12-06 - 23-12-06", location: "지존iOS 광진구 정복"),
        EventData(category: .bungae, title: "이벤트", tag: "#iOS #비정규 #노회식", time: "23-12-06 - 23-12-06", location: "지존iOS 광진구 정복"),
        EventData(category: .notice, title: "이벤트", tag: "#iOS #비정규 #노회식", time: "23-12-06 - 23-12-06", location: "지존iOS 광진구 정복"),
        EventData(category: .notice, title: "이벤트", tag: "#iOS #비정규 #노회식", time: "23-12-06 - 23-12-06", location: "지존iOS 광진구 정복"),
        EventData(category: .bungae, title: "이벤트", tag: "#iOS #비정규 #노회식", time: "23-12-06 - 23-12-06", location: "지존iOS 광진구 정복")
    ]


struct ListView: View {
    
    @State private var showEventDetail: Bool = false
    @State var eventSearchText: String = ""
    
    var body: some View {
        VStack(spacing: 40) {
            //이벤트 모아보기 제목
            HStack {
                Text("# 진행중")
                    .font(.system(size: 24, weight: .semibold))
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, -17)
            //이벤트 검색창
            RoundedRectangle(cornerRadius: 20)
                .stroke()
                .frame(width: screenWidth * 0.9, height: screenHeight * 0.045)
                .overlay(alignment: .leading, content: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("", text: $eventSearchText)
                    }
                    .padding(16)
                })
                .foregroundColor(.hexBABABA)
            //이벤트 카드
            ScrollView(content: {
                ForEach(eventDataList, id: \.self) { event in
                    assignedEventCard(category: event.category,
                                      title: event.title,
                                      tag: event.tag,
                                      time: event.time,
                                      location: event.location)
                }
            })
            //이벤트 생성 버튼
//            Spacer()
            Button(action: {
                self.showEventDetail = true
            }, label: {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.hexB38DE2)
                    .frame(width:screenWidth * 0.92, height: screenHeight * 0.063)
                    .overlay(content: {
                        Text("이벤트 생성")
                            .font(.system(size: 15))
                            .foregroundColor(.hexFFFFFF)
                    })
            })
            .sheet(isPresented: self.$showEventDetail, content: {
                DetailView()
            })
            
        }
        .padding()
        
    }
    //이벤트 카드
    @ViewBuilder
    func assignedEventCard(category: Category, title: String, tag: String, time: String, location: String) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .frame(width: 3, height: 50)
                .foregroundColor(category.representColor)
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.hex4E483C)
                    Text(tag)
                        .font(.system(size: 10))
                        .foregroundColor(.hex8161A8)
                    Spacer()
                    Text(time)
                        .font(.system(size: 10))
                        .foregroundColor(.hex8F8F8F)
                }
                .padding(.bottom, 9)
                //장소?
                Text(location)
                    .font(.system(size: 11))
                    .foregroundStyle(.hex4E483C)
            }
            .padding()
        }
    }

}

#Preview {
    ListView()
}
