//
//  AgreementView.swift
//  GKOG
//
//  Created by Suji Lee on 11/13/23.
//

import SwiftUI

struct AgreementPage: View {
    var body: some View {
        NavigationStack {
            VStack {
                //헤더
                VStack(alignment: .leading) {
                    //앱 이름
                    Text("지콕")
                    //안내 메세지
                    Text("""
                    서비스 이용을 위해
                    아래 항목에 동의해주세요
                    """)
                }
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
                        AgreementCard(label: "만 14세 이상", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4")
                        AgreementCard(label: "만 14세 이상", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4")
                        AgreementCard(label: "만 14세 이상", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4")
                    }
                    .padding(.vertical)
                }
                //가입하기 버튼
                VStack {
                    NavigationLink(destination: {
                        RegisterPage()
                    }, label: {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: screenWidth * 0.87, height: 50)
                            .foregroundColor(Color.hexA98ACE)
                    })
                }
            }
            .frame(width: screenWidth * 0.9)
        }
    }
}

@ViewBuilder
func CheckBox() -> some View {
    RoundedRectangle(cornerRadius: 6)
        .stroke(Color.hex7E7E7E, lineWidth: 0.5)
        .frame(width: 25, height: 25)

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
