//
//  TabBarView.swift
//  GKOG
//
//  Created by 가은 on 11/14/23.
//

import SwiftUI

struct TabBarView: View {
    @State var selectedIdx = 0
    
    let screenWidth = UIScreen.main.bounds.size.width
    let tabBarInfo = [["지도", "map.fill"], ["달력", "calendar"], ["모아보기", "magnifyingglass"], ["my", "person.fill"]]
    
    var body: some View {
        VStack {
            // 뷰
            ZStack {
                switch selectedIdx {
                case 0: MapView()       // 지도 탭
                case 1: CalendarView()  // 달력 탭
                case 2: ListView()      // 모아보기 탭
                case 3: MyPageView()    // my 탭
                default: EmptyView()
                }
            }
            Spacer()
            
            // 탭바
            HStack(spacing: 60) {
                ForEach(0..<tabBarInfo.count, id: \.self) { idx in
                    VStack(spacing: 8) {
                        Image(systemName: tabBarInfo[idx][1])
                        Text(tabBarInfo[idx][0])
                            .font(.system(size: 12, weight: .medium))
                    }
                    .foregroundColor(Color.hex4E483C)
                    .padding(.top, 15)
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                selectedIdx = idx
                            }
                    )
                }
            }
            .frame(width: screenWidth)
            .background(Color.hexF8F8F8)
        }
    }
}

#Preview {
    TabBarView()
}
