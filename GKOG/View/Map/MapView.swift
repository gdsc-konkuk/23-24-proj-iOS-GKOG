//
//  MapView.swift
//  GKOG
//
//  Created by Suji Lee on 11/7/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5400566, longitude: 127.0702592), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    @State var inputText: String = ""
    
    var cameraPosition: MapCameraPosition {
        MapCameraPosition.region(region)
    }
    
    var body: some View {
        ZStack {
            Map(position: .constant(cameraPosition), bounds: nil, interactionModes: .all, scope: nil)
                .overlay {
                    VStack {
                        Spacer()
                            .frame(width: screenWidth * 0.6, height: screenHeight * 0.08)
                        RoundedRectangle(cornerRadius: 10)
                            .overlay{
                                HStack(spacing: 0) {
                                    Button(action: {
                                        // function
                                    }, label: {
                                        Image(systemName: "magnifyingglass")
                                    })
                                    .frame(width: 19, height: 19)
                                    .padding()
                                    .foregroundColor(.gray)
                                    TextField("키워드로 검색", text: $inputText)
                                        .foregroundColor(.black)
                                }
                            }
                            .foregroundColor(.hexFFFFFF)
                            .frame(width: screenWidth * 0.9, height: 47)
                        Spacer()
                    }
                }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MapView()
}
