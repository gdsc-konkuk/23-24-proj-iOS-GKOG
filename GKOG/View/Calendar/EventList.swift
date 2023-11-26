//
//  WorkList.swift
//  GKOG
//
//  Created by 박성근 on 11/23/23.
//

import SwiftUI

struct EventList: View {
    var body: some View {
        // 가장 큰 테두리 사각형
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.hex8F8F8F, lineWidth: 0.5)
            .frame(width: 320, height: 65)
            // 뱃지, 텍스트, 버튼을 담기 위한 overlay
            .overlay {
                Image("Study_badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    // 위치가 사각형의 왼쪽 상단으로 고정, 표시를 위한 뱃지이므로 position으로 위치 고정
                    .position(x: 0, y: 0)
                HStack {
                    Text("스터디")
                        .fontWeight(.semibold)
                        .font(.system(size: 15.5))
                    Spacer()
                    // 참여 버튼
                    Button(action: {
                        // action function
                    }, label: {
                        // 버튼의 모양
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.hexD0BBEB)
                            .frame(width: 80, height: 33)
                            // 참여 버튼 안의 텍스트
                            .overlay {
                                Text("참여하기")
                                    .fontWeight(.medium)
                                    .font(.system(size: 13))
                                    .foregroundColor(.hex000000)
                            }
                    })
                }
                .padding()
            }
            .padding()
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.hex8F8F8F, lineWidth: 0.5)
            .frame(width: 320, height: 65)
            .overlay {
                Image("Hongbo_badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .position(x: 0, y: 0)
                HStack {
                    Text("GDSC 밋업 홍보")
                        .fontWeight(.semibold)
                        .font(.system(size: 15.5))
                    Spacer()
                    Button(action: {
                        // action function
                    }, label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.hexD0BBEB)
                            .frame(width: 80, height: 33)
                            .overlay {
                                Text("참여하기")
                                    .fontWeight(.medium)
                                    .font(.system(size: 13))
                                    .foregroundColor(.hex000000)
                            }
                    })
                }
                .padding()
            }
            .padding()
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.hex8F8F8F, lineWidth: 0.5)
            .frame(width: 320, height: 65)
            .overlay {
                Image("Study_badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .position(x: 0, y: 0)
                HStack {
                    Text("스터디")
                        .fontWeight(.semibold)
                        .font(.system(size: 15.5))
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.hexD0BBEB)
                            .frame(width: 80, height: 33)
                            .overlay {
                                Text("참여하기")
                                    .fontWeight(.medium)
                                    .font(.system(size: 13))
                                    .foregroundColor(.hex000000)
                            }
                    })
                }
                .padding()
            }
            .padding()
    }
}
