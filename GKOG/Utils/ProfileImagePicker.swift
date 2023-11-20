//
//  ImagePicker.swift
//  GKOG
//
//  Created by Suji Lee on 11/20/23.
//

import SwiftUI
import PhotosUI

struct ProfileImagePicker: View {
    
    @Binding var member: Member
    @State var selectedPhotos: [PhotosPickerItem] = []
    
    var profileImage: Image {
        if let imageData = member.profileImageData, let uiImage = UIImage(data: imageData) {
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
                .frame(width: 230, height: 230)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.hex787878.opacity(0.4), lineWidth: 1)
                )
        }
        .onChange(of: selectedPhotos) { newItem in
            guard let item = selectedPhotos.first else { return }
            item.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data {
                        member.profileImageData = data
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


#Preview {
    ProfileImagePicker(member: .constant(Member(nickname: "sdfsdf")), selectedPhotos: [])
}
