//
//  CreateCommentView.swift
//  GKOG
//
//  Created by 가은 on 11/19/23.
//

import PhotosUI
import SwiftUI

struct CreateCommentModal: View {
    @State var contents: String = ""
    @State var numberOfCharacters: Int = 0
    var commentImagePicker = CommentImagePicker()

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // 사진
                commentImagePicker
                // 내용(contents)
                VStack(alignment: .trailing, spacing: 10) {
                    // 글자수
                    Text("\(numberOfCharacters)/70")
                        .foregroundStyle(Color.hex7E7E7E)
                        .font(.system(size: 14))
                    // 텍스트필드
                    RoundedRectangle(cornerRadius: 5)
                        .strokeBorder(Color.hex000000.opacity(0.25), lineWidth: 0.5)
                        .frame(height: 170)
                        .overlay(alignment: .top, content: {
                            TextField("1~70자로 작성해주세요", text: $contents, axis: .vertical)
                                .font(.system(size: 14))
                                .accentColor(Color.hex000000.opacity(0.25))
                                .padding(20)
                        })
                    // 코멘트 작성 관련 정보 Text
                    Text("공백만으로 작성할 수 없습니다")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(Color.hex7E7E7E)
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(action: {
                        // TODO: dismiss modal
                    }, label: {
                        Text("취소")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(Color.hex5C5353)
                    })
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        // TODO: 코멘트 생성

                    }, label: {
                        Text("전송")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(Color.hex8161A8)
                    })
                }
            }
        }
        .padding(25)
    }
}

#Preview {
    CreateCommentModal()
}
