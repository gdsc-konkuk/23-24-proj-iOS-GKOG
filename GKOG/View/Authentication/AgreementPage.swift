//
//  AgreementView.swift
//  GKOG
//
//  Created by Suji Lee on 11/13/23.
//

import SwiftUI

// 뷰 전체 폭 길이
let screenWidth = UIScreen.main.bounds.size.width
    
// 뷰 전체 높이 길이
let screenHeight = UIScreen.main.bounds.size.height

struct AgreementPage: View {
    
    // 각각의 항목에 check 유무를 확인하는 배열
    @State var agreement: [Bool] = Array(repeating: false, count: 4)
    // 모두 동의 버튼 클릭 유무를 확인하는 배열
    @State var allAgree: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                //헤더
                VStack {
                    //앱 이름
                    HStack {
                        VStack(alignment: .leading) {
                            Text("지콕")
                                .foregroundColor(.hexA98ACE)
                                .font(.system(size: 26, weight: .semibold))
                            //안내 메세지
                            Text("서비스 이용을 위해")
                            Text("아래 항목에 동의해주세요")
                        }
                        .foregroundColor(.hex4E483C)
                        .font(.system(size: 18.5))
                        .padding(.leading, screenWidth * 0.05)
                        Spacer()
                    }
                    .padding(.top, screenHeight * 0.1)
                }
                .padding(.bottom, screenHeight * 0.1)
                Spacer()
                //동의란
                VStack {
                    //모두 동의
                    HStack {
                        Spacer()
                        Text("모두 동의")
                            .foregroundStyle(Color.hexA98ACE)
                            .font(.system(size: 16, weight: .semibold))
                        CheckBox()
                    }
                    .padding(.horizontal)
                    Rectangle()
                        .frame(width: screenWidth * 0.9, height: 2)
                    //상세 동의
                    VStack(spacing: 17) {
                        AgreementCard(label: "만 14세 이상", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4")
                        AgreementCard(label: "이용약관", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4")
                        AgreementCard(label: "위치기반 서비스 이용약관", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4")
                        AgreementCard(label: "개인정보 수집 및 이용 동의", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4")
                    }
                    .padding(.vertical)
                }
                .padding(.bottom, screenHeight * 0.02)
                //가입하기 버튼
                VStack {
                    NavigationLink(destination: {
                        RegisterPage()
                    }, label: {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: screenWidth * 0.87, height: 50)
                            .foregroundColor(Color.hexA98ACE)
                            .overlay {
                                Text("가입하기")
                                    .foregroundColor(.hexFFFFFF)
                            }
                    })
                }
                .padding(.bottom, screenHeight * 0.25)
            }
            .frame(width: screenWidth * 0.9)
        }
    }
}

@ViewBuilder
func CheckBox() -> some View {
    Button(action: {
        
    }, label: {
        //if agreement :
        RoundedRectangle(cornerRadius: 6)
            .stroke(Color.hex7E7E7E, lineWidth: 0.5)
            .frame(width: 25, height: 25)
    })
}

@ViewBuilder
func AgreementCard(label: String, url: String) -> some View {
    HStack {
        Text(label)
        Spacer()
        Button(action: {
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        }, label: {
            Text("내용보기")
                .foregroundColor(.hex7E7E7E)
                .font(.system(size: 14))
        })
        CheckBox()
    }
    .padding(.horizontal)
}

#Preview {
    AgreementPage()
}
