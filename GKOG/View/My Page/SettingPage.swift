//
//  SettingPage.swift
//  GKOG
//
//  Created by Suji Lee on 12/19/23.
//

import SwiftUI

struct SettingPage: View {
    
    var version: String = "1.0.0"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 55) {
                VStack {
                    Text("Settings")
                        .font(.system(size: 30, weight: .bold))
                }
                VStack(spacing: 0) {
                    NavigationLink(destination: {
                        AccountPage()
                    }, label: {
                        BlockCell(icon: "person", label: "계정 정보")
                    })
                    Button(action: {
                        if let url = URL(string: "https://www.notion.so/gkog/cdce92cc9f314784b5d4d4fb2825a57a") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        BlockCell(icon: "doc.text.magnifyingglass", label: "이용 약관")
                    })
                    Button(action: {
                        if let url = URL(string: "https://www.notion.so/gkog/362ef2f4816048318d92b329743f7409") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        BlockCell(icon: "doc.text.magnifyingglass", label: "위치 기반 서비스 이용 약관")
                    })
                    Button(action: {
                        if let url = URL(string: "https://www.notion.so/gkog/cfeae0f91ef64362a2fc8dbb8b57c84e") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        BlockCell(icon: "lock", label: "개인 정보 처리 방침")
                    })
                    Button(action: {
                        if let url = URL(string: "https://www.notion.so/gkog/ae9215076dff4f628d284178cb3f6c10") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        BlockCell(icon: "lock", label: "개인 정보 수집 및 이용 동의서")
                    })
                    Button(action: {
                        if let url = URL(string: "https://www.notion.so/gkog/f1781bb0e097430186e9a16c9d05e48c") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        BlockCell(icon: "megaphone", label: "공지사항")
                    })
                    BlockCell(icon: "info.circle", label: "문의처")
                        .padding(.bottom, 40)
                    Text("버전 정보 : \(version)")
                        .foregroundColor(.gray.opacity(0.9))
                        .font(.system(size: 13.5))
                }
                .padding(.top, 40)
            }
            .padding(.top, 50)
        }
    }
    
    @ViewBuilder
    func BlockCell(icon: String, label: String) -> some View {
        VStack {
            Rectangle()
                .stroke(Color.gray.opacity(0.5), lineWidth: 0.2)
                .foregroundColor(.clear)
                .frame(width: screenWidth, height: 55)
                .overlay(
                    HStack(spacing: 15) {
                        Image(systemName: icon)
                            .font(.system(size: 18))
                            .padding(.leading)
                        Text(label)
                            .font(.system(size: 17))
                        Spacer()
                        if label == "계정 정보" {
                            Image(systemName: "greaterthan")
                                .font(.system(size: 17))
                                .padding(.trailing)
                        }
                        if label == "문의처" {
                            Text("sujilee.ku@gmail.com")
                                .foregroundColor(.gray.opacity(0.8))
                                .font(.system(size: 14))
                                .padding(.trailing)
                        }
                    }
                )
        }
        .foregroundStyle(Color.hex000000)
    }
}

#Preview {
    SettingPage()
}
