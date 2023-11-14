//
//  File.swift
//  GKOG
//
//  Created by 박성근 on 11/11/23.
//

import SwiftUI

var screenWidth = UIScreen.main.bounds.size.width
var screenHeight = UIScreen.main.bounds.size.height

struct EntryView: View {
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("EntryBackgroundView")
                VStack {
                    Spacer()
                    Image("Logo")
                        .padding(.bottom, screenHeight * 0.15)
                    VStack(spacing: 40){
                        Rectangle()
                            .frame(width: screenWidth * 0.8, height: 1)
                        VStack(spacing : 15){
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                //애플 로그인 버튼 삽입시 적절한 크기로 생성
                                Text("애플 로그인")
                            })
                            .frame(width: screenWidth * 0.8, height: 50)
                            Button(action: {}, label: {
                                // 구글 로그인 버튼 삽입시 적절한 크기로 생성
                                Text("구글 로그인")
                            })
                            .frame(width: screenWidth * 0.8, height: 50)
                        }
                        Rectangle()
                            .frame(width: screenWidth * 0.8, height: 1)
                    }
                    Spacer()
                        .frame(height: screenHeight * 0.2)
                    Text("GDSC Konkuk iOS Team.")
                        .font(.footnote)
                        .frame(alignment: .bottom)
                        .padding(20)
                }
            }
            .foregroundColor(.white)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    EntryView()
}

