//
//  RegisterPage.swift
//  GKOG
//
//  Created by Suji Lee on 11/13/23.
//

import SwiftUI

// 필드 검증을 위한 enum
enum NicknameValidation {
    case noInput
    case dupulicated
    case wrongInput
    case validate
}

struct RegisterPage: View {
    
    @EnvironmentObject var stateManager: StateManager
    
    @State var member: Member = Member()
    
    @State var nicknameValidation: NicknameValidation = .noInput
    @State var nickname: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 45) {
                    // 헤더
                    HStack {
                        VStack(alignment: .leading) {
                            Text("회원가입")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.hexA98ACE)
                                .padding(.bottom)
                            VStack(alignment: .leading, spacing: 4) {
                                Text("나를 잘 나타내는 사진과 닉네임을 정해주세요")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.hex4E483C)
                                Text("프로필은 모든 사람들에게 보여집니다")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.hex7E7E7E)
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom)
                    // 프로필 이미지
                    VStack {
                        ProfileImagePicker()
                    }
                    // 닉네임 필드
                    VStack {
                        CustomTextField()
                        Rectangle()
                            .foregroundStyle(Color.hexBABABA)
                            .frame(height: 1)
                        // 유효성 알림 메세지
                        HStack {
                            AlertMessage()
                            Spacer()
                        }
                    }
                }
                .padding(.vertical, 30)
            }
            .padding(30)
        }
        .toolbar(content: {
            ToolbarItem(placement: .confirmationAction, content: {
                    Button(action: {
                        stateManager.userRegistered = true
                    }, label: {
                        Text("완료")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(nicknameValidation == .validate ? Color.hexA98ACE : Color.hexBABABA)
                    })
                    .disabled(nicknameValidation != .validate)
            })
        })
    }
    
    @ViewBuilder
    func CustomTextField() -> some View {
        VStack {
            TextField("닉네임 (변경 불가)", text: $nickname)
            // 키보드 영역 외 태핑 시 키보드 collapse
                .onAppear {
                    UIApplication.shared.hideKeyboard()
                }
                .onChange(of: nickname, {
                    // checkNicknameDuplication(nickname: newValue)
                })
                .onChange(of: nickname, {
                    // .onChange 반영 시간 딜레이 0.8초
                    // 초성 인풋을 한국어가 아니라고 인식하기 때문에 필요
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        let koreanCharacters = CharacterSet(charactersIn: "\u{AC00}"..."\u{D7A3}")
                        // 닉네임 길이, 한글 포함 검사
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
        
        let fontSize: CGFloat = 15
        
        switch nicknameValidation {
        case .noInput:
            Text("닉네임은 필수입니다")
                .font(.system(size: fontSize))
                .foregroundColor(.hexD76565)
        case .wrongInput:
            Text("닉네임은 한글로만 구성된 2~6자여야 합니다")
                .font(.system(size: fontSize))
                .foregroundColor(.hexD76565)
        case .dupulicated:
            Text("중복된 닉네임입니다")
                .font(.system(size: fontSize))
                .foregroundColor(.hexD76565)
        case .validate:
            Text("사용할 수 있는 닉네임입니다")
                .font(.system(size: fontSize))
                .foregroundColor(.hexA98ACE)
        }
    }
}

#Preview {
    RegisterPage()
}
