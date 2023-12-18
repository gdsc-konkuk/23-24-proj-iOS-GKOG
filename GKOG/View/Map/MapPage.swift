//
//  MapView.swift
//  GKOG
//
//  Created by Suji Lee on 11/7/23.
//
import SwiftUI
import MapKit

struct MapPage: View {
    @StateObject var locationManager = LocationManager()
    @State var region = MKCoordinateRegion.defaultRegion
    @State var isLoadingUserLocationInfo = true // 위치 데이터 로딩 상태를 추적

    var body: some View {
        NavigationView {
            ZStack {
                if let userLocation = locationManager.lastKnownLocation, !isLoadingUserLocationInfo {
                    MapView(region: $region, userLocation: userLocation)
                    CurrentLocationButton { zoomToCurrentLocation() }
                } else {
                    ProgressView()
                }
            }
            .onReceive(locationManager.$lastKnownLocation) { location in
                   if let location = location {
                       isLoadingUserLocationInfo = false
                       region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan.defaultSpan)
                   }
               }
        }
    }

    private func zoomToCurrentLocation() {
        if let location = locationManager.lastKnownLocation {
            withAnimation {
                region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan.defaultSpan)
            }
        }
    }
}

struct MapView: View {
    @Binding var region: MKCoordinateRegion
    var userLocation: CLLocation?

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
            .onReceive(NotificationCenter.default.publisher(for: .newLocationAvailable)) { _ in
                if let location = userLocation {
                    region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan.defaultSpan)
                }
            }
    }
}

struct CurrentLocationButton: View {
    var action: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button(action: action, label: {
                    Image(systemName: "scope")
                        .font(.system(size: 20))
                        .frame(width: 10, height: 10)
                        .padding(14)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 2)
                })
                .padding()
                .padding(.leading, 5)
                Spacer()
            }
            Spacer()
        }
    }
}

extension MKCoordinateRegion {
    static var defaultRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan.defaultSpan)
    }
}

extension MKCoordinateSpan {
    static var defaultSpan: MKCoordinateSpan {
        MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var lastKnownLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.last
        NotificationCenter.default.post(name: .newLocationAvailable, object: nil)
    }
}

extension Notification.Name {
    static let newLocationAvailable = Notification.Name("newLocationAvailable")
}
