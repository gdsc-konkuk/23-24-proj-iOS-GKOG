//
//  ImagePicker.swift
//  gdsc-ios-tutorial-by-sujileelea
//
//  Created by Suji Lee on 10/21/23.
//

import SwiftUI
import PhotosUI

struct ProfileImagePicker: View {
    
    @Binding var member: Member
    @State var profileImageData: Data?
    @State var selectedPhotos: [PhotosPickerItem] = []
    
    var profileImage: Image {
        if let imageData = profileImageData, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return Image("기본_프로필")
        }
    }
    
    var body: some View {
        PhotosPicker(selection: $selectedPhotos, maxSelectionCount: 1, matching: .images) {
            profileImage
            //이미지의 사이즈를 내가 원하는대로 재조정
                .resizable()
            //추후 설명
                .scaledToFill()
                .frame(width: 230, height: 230)
            //이미지를 Circle() 모양으로 자름
                .clipShape(Circle())
                .overlay(
                    Circle()
                )
        }
        .onChange(of: selectedPhotos) { newItem in
            guard let item = selectedPhotos.first else { return }
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        profileImageData = data
                    } else {
                        print("data is nil")
                    }
                case .failure(let failure):
                    fatalError("\(failure)")
                }
            }
        }
    }
}
