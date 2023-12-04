//
//  AgreementView.swift
//  GKOG
//
//  Created by Suji Lee on 11/13/23.
//

import SwiftUI

struct AgreementPage: View {
    // 각각의 항목에 check 유무를 확인하는 배열
    @State var agreement: [Bool] = Array(repeating: false, count: 4)
    
    // 모든 항목이 동의된 경우를 확인하는 계산된 속성
    var allAgreed: Bool {
        // Swift 배열 메소드 -> agreement 요소들이 모두 true이면
        // allAgreed -> true , 아니면 false
        return agreement.allSatisfy { $0 }
    }
    @State var member: Member = Member()
    
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
                        CheckAllBox(agreement: $agreement)
                    }
                    .padding(.horizontal)
                    Rectangle()
                        .frame(width: screenWidth * 0.9, height: 2)
                    //상세 동의
                    VStack(spacing: 17) {
                        AgreementCard(label: "만 14세 이상", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4", idx: 0, agreement: $agreement)
                        AgreementCard(label: "이용약관", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4", idx: 1, agreement: $agreement)
                        AgreementCard(label: "위치기반 서비스 이용약관", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4", idx: 2, agreement: $agreement)
                        AgreementCard(label: "개인정보 수집 및 이용 동의", url: "https://www.notion.so/mocacong/78a169a2532a4e9e94fe2ae2da41c6a4", idx: 3, agreement: $agreement)
                    }
                    .padding(.vertical)
                }
                .padding(.bottom, screenHeight * 0.02)
                //가입하기 버튼
                VStack {
                    NavigationLink(destination: {
                        RegisterPage(member: $member)
                    }, label: {
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: screenWidth * 0.87, height: 50)
                            .foregroundColor(allAgreed ? Color.hexA98ACE : Color.hex7E7E7E)
                            .overlay {
                                Text("가입하기")
                                    .foregroundColor(.hexFFFFFF)
                            }
                    })
                    .disabled(!allAgreed)
                }
                .padding(.bottom, screenHeight * 0.25)
            }
            .frame(width: screenWidth * 0.9)
        }
    }
}

@ViewBuilder
// CheckBox(인덱스, agreement 배열)
// 인덱스에 입력된 agreement이 true면은 checkmark 표시, false면 checkmark 가림
func CheckBox(idx: Int, agreement: Binding<[Bool]>) -> some View {
    Button(action: {
        agreement.wrappedValue[idx] = !agreement.wrappedValue[idx]
    }, label: {
        RoundedRectangle(cornerRadius: 6)
            .stroke(Color.hex7E7E7E, lineWidth: 0.5)
            .frame(width: 25, height: 25)
            .overlay(
                Image(systemName: agreement.wrappedValue[idx] ? "checkmark" : "square")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(agreement.wrappedValue[idx] ? .hexA98ACE : .clear)
            )
    })
}

@ViewBuilder
func CheckAllBox(agreement: Binding<[Bool]>) -> some View {
    Button(action: {
        let allTrue = Array(repeating: true, count: agreement.wrappedValue.count)
        agreement.wrappedValue = allTrue
        
        // 동시에 각 CheckBox의 상태를 갱신
        for idx in 0..<allTrue.count {
            CheckBox(idx: idx, agreement: agreement)
        }
        
    }, label: {
        RoundedRectangle(cornerRadius: 6)
            .stroke(Color.hex7E7E7E, lineWidth: 0.5)
            .frame(width: 25, height: 25)
            .overlay(
                Image(systemName: agreement.wrappedValue.allSatisfy { $0 } ? "checkmark" : "square")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(agreement.wrappedValue.allSatisfy { $0 } ? .hexA98ACE : .clear)
            )
    })
}


@ViewBuilder
// 기존 AgreementCard 에서 idx, agreement을 인자로 받아줌
// idx -> agreement[idx]에 해당되는 값을 true, false로 toggle
func AgreementCard(label: String, url: String, idx: Int, agreement: Binding<[Bool]>) -> some View {
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
        CheckBox(idx: idx, agreement: agreement)
    }
    .padding(.horizontal)
}

#Preview {
    AgreementPage()
}
