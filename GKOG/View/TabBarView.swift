//
//  TabBarView.swift
//  GKOG
//
//  Created by 가은 on 11/14/23.
//

import SwiftUI

struct TabBarView: View {
    @State var selectedIdx = 0
    
    var body: some View {
        VStack {
            // 탭뷰
            TabView {
                // 지도 탭
                MapView()
                    .tabItem({
                        Label("지도", systemImage: "map.fill")
                    })
                // 달력 탭
                CalendarView()
                    .tabItem({
                        Label("달력", systemImage: "calendar")
                    })
                // 모아보기 탭
                ListView()
                    .tabItem({
                        Label("모아보기", systemImage: "magnifyingglass")
                    })
                // my 탭
                MyPageView()
                    .tabItem({
                        Label("my", systemImage: "person.fill")
                    })
            }
            .accentColor(Color.hex000000)
        }
    }
}

#Preview {
    TabBarView()
}
