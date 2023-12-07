//
//  ImagePicker.swift
//  gdsc-ios-tutorial-by-sujileelea
//
//  Created by Suji Lee on 10/21/23.
//

import SwiftUI
import PhotosUI

struct ProfileImagePicker: View {
    
    @State var profileImageData: Data?
    @State var selectedPhotos: [PhotosPickerItem] = []
    
    var profileImage: Image {
        if let imageData = profileImageData, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return Image("Default_Profile")
        }
    }
    
    var body: some View {
        PhotosPicker(selection: $selectedPhotos, maxSelectionCount: 1, matching: .images) {
            profileImage
                .resizable()
                .scaledToFill()
                .frame(width: 190, height: 190)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.hexBABABA.opacity(0.4), lineWidth: 1)
                )
        }
        .onChange(of: selectedPhotos) {
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
