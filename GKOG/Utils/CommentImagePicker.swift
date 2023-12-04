//
//  CommentImagePicker.swift
//  GKOG
//
//  Created by 가은 on 11/28/23.
//

import PhotosUI
import SwiftUI

struct CommentImagePicker: View {
    @State var commentPhotoData: Data?
    @State var selectedPhotos: [PhotosPickerItem] = []

    var commentPhoto: Image {
        if let imageData = commentPhotoData, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return Image("")
        }
    }

    var body: some View {
        HStack(spacing: 20) {
            PhotosPicker(selection: $selectedPhotos, maxSelectionCount: 1, matching: .images) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.hexBABABA.opacity(0.38))
                    .overlay(
                        Image("Default_Camera")
                    )
            }
            .onChange(of: selectedPhotos, initial: false) { _, _ in
                guard let item = selectedPhotos.first else { return }
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case .success(let data):
                        if let data = data {
                            commentPhotoData = data
                        } else {
                            print("data is nil")
                        }
                    case .failure(let failure):
                        fatalError("\(failure)")
                    }
                }
            }
            ZStack {
                // 선택한 사진이 없을 때 보이는 뷰
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(lineWidth: 0.2)
                    .overlay(
                        Image(systemName: "plus")
                            .foregroundColor(.hex7E7E7E)
                            .frame(width: 20, height: 20)
                    )
                // 선택한 사진 띄우기
                commentPhoto
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .overlay(alignment: .topTrailing, content: {
                Button(action: {
                    // 선택한 사진 삭제
                    commentPhotoData = nil
                    selectedPhotos.removeAll()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.hexD28F8F)
                        .offset(CGSize(width: 10, height: -10))
                })
            })
        }
        .frame(height: 180)
        .padding(.horizontal, 10)
    }
}
