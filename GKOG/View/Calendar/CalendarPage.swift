//
//  CalendarView.swift
//  GKOG
//
//  Created by Suji Lee on 11/7/23.
//

import SwiftUI

// 날짜 구조체
struct CalendarDate: Identifiable {
    // id값
    let id = UUID()
    // 몇 일 e.g -> day: 27, day: 28 ...
    var day: Int
    // 전체 날짜 정보
    var date: Date
}

struct CalendarPage: View {
    // 요일 배열
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    // 선택된 월, 날짜를 관리하는 상태 속성
    @State var selectedMonth = 0
    @State var selectedDate = Date()
    
    var body: some View {
        VStack {
            VStack {
                // 달력 UI 생성하는 CalendarFunction
                CalendarView()
                // 해당 날짜의 계획된 세션을 ScrollView를 통해 조정
                ScrollView {
                    EventList()
                }
                // Height를 우선적으로 screenHeight * 0.3으로 설정
                .frame(maxHeight: screenHeight * 0.3)
                Spacer()
            }
            // 화살표를 통해 월을 바꾸면 달력 내 모양도 바뀌는 것을 반영하기 위한 updateDate 함수
            .onChange(of: selectedMonth) {
                updateDate()
            }
            .ignoresSafeArea()
        }
    }
    
    // 달력 UI 생성
    @ViewBuilder
    func CalendarView() -> some View {
        VStack {
            // 연도 출력
            Text(selectedDate.printYear())
                .foregroundStyle(Color.hex4E483C)
                .fontWeight(.semibold)
                .font(.system(size: 21))
                .padding(.top, 60)
            // 양 옆 화살표, 월 정보를 출력
            HStack {
                //  '<' 버튼 -> 이전 월로 이동하는 버튼
                Button {
                    selectedMonth -= 1
                } label: {
                    Image(systemName: "arrowtriangle.left.fill")
                        .frame(width: 18, height: 18)
                }
                .foregroundStyle(Color.hex000000)
                
                Spacer()
                
                // 현재 월 표시
                Text(selectedDate.printMonth())
                    .foregroundStyle(.hexB38DE2)
                    .fontWeight(.semibold)
                    .font(.system(size: 40))
                
                Spacer()
                
                // '>' 버튼 -> 다음 월로 이동하는 버튼
                Button {
                    selectedMonth += 1
                } label: {
                    Image(systemName: "arrowtriangle.right.fill")
                        .frame(width: 18, height: 18)
                }
                .foregroundStyle(Color.hex000000)
            }
        }
        .padding(.horizontal, 36)
        
        // 요일 출력
        HStack {
            // 반복문으로 요일 배열 내부 요소들 출력
            ForEach(days, id:\.self) { day in
                Text(day)
                    .foregroundStyle(Color.hex000000)
                    .font(.system(size: 14))
                    .frame(width: 40, height: 20)
            }
        }
        .padding(.horizontal, 27)
        
        // 일 출력
        // LazyVGrid -> 수평 방향으로 나열된 그리드 레이아웃 생성하는 SwiftUI 컨테이너
        // GridItem -> flexible 한 너비를 가진, count : 7개의 열로 된 그리드를 생성
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            // fetchDates를 통해 나온 행에 맞춰 7개씩 출력
            ForEach(fetchDates()){ value in
                VStack {
                    if value.day != -1 {
                        // 날짜가 있는 경우 텍스트 표시
                        Text("\(value.day)")
                            .foregroundStyle(Color.hex4E483C)
                            .font(.system(size: 20))
                    } else {
                        // 빈 날짜의 경우 빈 텍스트로 표시
                        Text("")
                    }
                }
                .frame(width: 40, height: 46)
            }
        }
        .padding(.horizontal, 32)
    }
        
    
    // 월 변경 시 날짜를 업데이트 해주는 함수
    func updateDate() -> Void {
        selectedDate = fetchSelectedMonth()
    }
    
    // 선택된 월의 날짜를 가져오는 함수
    func fetchSelectedMonth() -> Date {
        // Calendar.current를 통해 현재 사용 중인 달력을 얻음
        let calendar = Calendar.current
        
        // caldendar.date를 사용해 현재 날짜 + selectedMonth 만큼의 월을 더한 날짜를 얻음 , .month : 월을 더하는 단위
        let month = calendar.date(byAdding: .month, value: selectedMonth, to: Date())
        
        // date에서 옵셔널 'Date?' 를 반환하므로 강제 언래핑을 해줌 -> date에서 nil 이 반환되는 경우 에러 처리
        return month!
    }
    
    // 선택된 월의 날짜를 가져오는 함수
    func fetchDates() -> [CalendarDate] {
        // 현재 달력을 사용하기 위해 현재 월을 가져옴
        let calendar = Calendar.current
        let currentMonth = fetchSelectedMonth()
        
        // 현재 월에 속하는 날짜들을 가져와서 각 날짜를 CalendarDate로 매핑
        // 즉, dates는 CalendarDate 구조체로 이루어진 배열
        var dates = currentMonth.datesOfMonth().map({CalendarDate(day: calendar.component(.day, from: $0), date: $0)})
        
        // 현재 달의 첫 날이 무슨 요일인지 확인 -> (월요일, 1), (화요일, 2) ... 이런식으로 저장 -> 일요일 기준 시 "-1"부분 삭제
        let firstDayOfWeek = calendar.component(.weekday, from: dates.first?.date ?? Date())
        
        // 첫 주의 공백을 채우기 위해 빈 날짜를 -1로 추가
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        
        // CaldendarDate(날짜) 배열 반환
        return dates
    }
}

// extension을 Date() 날짜 관련 기능 확장
extension Date {
    
    // 연도 출력해주는 함수
    func printYear() -> String {
        // DateFormatter 를 사용하여 날짜를 특정 포맷의 문자열로 변환
        let formatter = DateFormatter()
        
        // 대문자 Y는 연도를 나타냄
        formatter.dateFormat = "YYYY"
        
        return formatter.string(from: self)
    }
    
    // 월 출력 함수
    func printMonth() -> String {
        let formatter = DateFormatter()
        
        // 대문자 M은 월을 나타냄
        formatter.dateFormat = "MM"
        
        return formatter.string(from: self)
    }
    
    // 해당 월의 모든 날짜를 반환해주는 함수
    func datesOfMonth() -> [Date] {
        // Calendar.current를 통해 현재 사용 중인 달력의 월, 연도를 얻음
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        // DateComponents 함수를 통해 시작일의 연도와 월을 설정하고 날짜는 1로 설정
        var startDateComponents = DateComponents()
        startDateComponents.year = currentYear
        startDateComponents.month = currentMonth
        startDateComponents.day = 1
        
        // startDate를 통해 startDateComponents에서 생성된 날짜를 얻음
        let startDate = calendar.date(from: startDateComponents)!
        
        // DateComponents 함수를 통해 종료일의 월을 1로 설정하고, 날짜를 -1로 설정
        var endDateComponets = DateComponents()
        endDateComponets.month = 1
        endDateComponets.day = -1
        
        // startDate + endDateComponents를 더하여 종료일을 얻음
        let endDate = calendar.date(byAdding: endDateComponets, to: startDate)!
        
        // Date 배열 생성
        var dates: [Date] = []
        var currentDate = startDate
        
        // currentDate -> endDate 까지 해당 월에 속하는 모든 날짜가 포함됨
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        // 날짜
        return dates
    }
}

#Preview {
    CalendarPage()
}
