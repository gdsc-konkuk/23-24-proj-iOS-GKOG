//
//  MapView.swift
//  GKOG
//
//  Created by Suji Lee on 11/7/23.
//
import SwiftUI
//애플 지도 SDK를 사용하
import MapKit

struct MapPage: View {
    
    //지도의 위치제어를 위한 매니저
    @StateObject var locationManager = LocationManager()
    //지도에서 보여줄 장소
    @State var region = MKCoordinateRegion.defaultRegion
    // 지도 출현 시 사용자의 현재 위치를 중앙에 보여주기 위한 사용자 위치 데이터 로딩 상태값
    @State var isLoadingUserLocationInfo = true

    var body: some View {
        NavigationView {
            ZStack {
                // 사용자의 위치 정보를 성공적으로 로드하면 MapView()를 랜더링
                if let userLocation = locationManager.lastKnownLocation, !isLoadingUserLocationInfo {
                    MapView(region: $region, userLocation: userLocation)
                    // 사용자의 위치를 지도의 중앙으로 표시하는 버튼
                    CurrentLocationButton { zoomToCurrentLocation() }
                } else {
                    // 사용자의 위치 정보를 가져오는 중에는 UX를 위해 ProgressView()를 랜더링
                    ProgressView()
                }
            }
            // 사용자의 위치 정보가 변할 때마다 해당 정보(location)을 구독해 그 정보를 감지하고 region(화면 상 지도의 지역)에 주입합니다
            .onReceive(locationManager.$lastKnownLocation) { location in
                   if let location = location {
                       // 사용자 위치 정보 로딩이 성공적으로 완료되면 로딩 플래그값을 false로 설정해 ProgressView()가 아닌 MapView()를 보여주도록 합니다
                       isLoadingUserLocationInfo = false
                       region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan.defaultSpan)
                   }
               }
        }
    }

    // 지도의 중앙을 사용자의 현재 위치로 옮기는 로직을 구현한 메서드
    private func zoomToCurrentLocation() {
        
        //만약 사용자의 현재 위치 정보를 가지고 있다면 해당 지역의 정보를 region에 주입합니다
        // region은 Map이 인자로 받아 화면에 그려낼 지역의 정보입니다.
        if let location = locationManager.lastKnownLocation {
            withAnimation {
                region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan.defaultSpan)
            }
        }
    }
}

// 지도 자체를 랜더링하는 View
struct MapView: View {
    
    // 현재 화면 상 지도에 그려질 지역
    @Binding var region: MKCoordinateRegion
    // 사용자의 위치
    var userLocation: CLLocation?

    var body: some View {
        // 임베드 될 지도이며, region을 인자로 받아 해당 region에 대한 지도를 사용자 화면에 그려냅니다
        Map(coordinateRegion: $region, showsUserLocation: true)
            .ignoresSafeArea()
    }
}

// 지도의 중앙을 사용자의 현재위치로 옮기는 버튼
struct CurrentLocationButton: View {
    
    //해당 버튼을 클릭했을 때 트리커할 액션을 클로저로 받습니다
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


// 기본 지역 초기화 -> 어차피 기본 지역(지도 출현시 보이는 지역)을 사용자의 현재 위치로 설정할 것이니 기본값으로 토기화
extension MKCoordinateRegion {
    static var defaultRegion: MKCoordinateRegion {
        MKCoordinateRegion(center: CLLocationCoordinate2D(), span: MKCoordinateSpan.defaultSpan)
    }
}

// 기본 span -> 기본 줌 레벨이라고 생각하면 편합니다
extension MKCoordinateSpan {
    static var defaultSpan: MKCoordinateSpan {
        MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    }
}

// 지도 위치제어 매니저
// Observable 프로토콜을 준수하기 때문에 View에서 해당 클래스의 인스턴스를 구독해 그 변화를 감지하고 뷰를 새로 랜더링할 수 있다.
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    // 사용자의 위치 정보라고 생각하시면 됩니다
    @Published var lastKnownLocation: CLLocation?

    //초기화. 저도 자세한 내용은 잘 모릅니다
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
