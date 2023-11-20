//
//  RegisterPage.swift
//  GKOG
//
//  Created by Suji Lee on 11/13/23.
//

import SwiftUI

enum NicknameValidation {
    case noInput
    case dupulicated
    case wrongInput
    case validate
}

struct RegisterPage: View {
    
    @State var nicknameValidation: NicknameValidation = .noInput
    @Binding var member: Member
    @State var nickname: String = ""
    
    var body: some View {
        VStack(spacing: 50) {
            //헤더
            HStack {
                VStack(alignment: .leading) {
                    Text("회원가입")
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(Color.hexA98ACE)
                        .padding(.bottom, 50)
                    Text("프로필 설정")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.hex4E483C)
                    VStack(alignment: .leading) {
                        Text("나를 잘 나타내는 사진과 닉네임을 정해주세요")
                            .font(.system(size: 14.5))
                        Text("프로필은 모든 사람들에게 보여집니다")
                            .font(.system(size: 13))
                        
                    }
                    .foregroundStyle(.hex7E7E7E)
                }
                Spacer()
            }
            //프로필 이미지
            VStack {
                ProfileImagePicker(member: $member)
            }
            //닉네임 필드
            VStack {
                CustomTextField()
                Rectangle()
                    .foregroundStyle(Color.hexBABABA)
                    .frame(height: 1)
                VStack(alignment: .leading) {
                    AlertMessage()
                }
            }
        }
        .frame(width: screenWidth * 0.9)
        .padding()
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing, content: {
                Button(action: {
                    
                }, label: {
                    Text("완료")
                        .foregroundStyle(Color.hexA98ACE)
                })
            })
        })
    }
    
    @ViewBuilder
    func CustomTextField() -> some View {
        VStack {
            TextField("닉네임 (변경 불가)", text: $nickname)
            //키보드 영역 외 태핑 시 키보드 collapse
                .onAppear {
                    UIApplication.shared.hideKeyboard()
                }
                .onChange(of: nickname, {
                    // checkNicknameDuplication(nickname: newValue)
                })
                .onChange(of: nickname, {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        
                        let koreanCharacters = CharacterSet(charactersIn: "\u{AC00}"..."\u{D7A3}")
                        // 닉네임 길이 검사
                        if nickname.count < 2 || nickname.count > 6 || !nickname.unicodeScalars.allSatisfy(koreanCharacters.contains) {
                            nicknameValidation = .wrongInput
                        } else {
                            nicknameValidation = .validate
                        }
                    }
                })
        }
    }
    
    @ViewBuilder
    func AlertMessage() -> some View {
        
        switch nicknameValidation {
        case .noInput:
            Text("예시) 초성ㄴㄴ")
                .font(.system(size: 13))
                .foregroundColor(.hexA98ACE)
        case .wrongInput:
            Text("닉네임은 한글로만 구성된 2~6자여야 합니다")
                .font(.system(size: 13))
                .foregroundColor(.hexD76565)
        case .dupulicated:
            Text("중복된 닉네임입니다")
                .font(.system(size: 13))
                .foregroundColor(.hexD76565)
        case .validate:
            Text("사용할 수 있는 닉네임입니다")
                .font(.system(size: 13))
                .foregroundColor(.hexA98ACE)
        }
    }
}

#Preview {
    RegisterPage(member: .constant(Member()))
}
