//
//  CalendarView.swift
//  GKOG
//
//  Created by Suji Lee on 11/7/23.
//

import SwiftUI

struct CalendarView: View {
    let days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
    
    @State var selectedMonth = 1;
    @State var selectedDate = Date()

    var body: some View {
        VStack {
            VStack {
                // 연도 출력
                Text(selectedDate.printYear())
                    .foregroundStyle(.hex4E483C)
                    .fontWeight(.semibold)
                    .font(.system(size: 21))
                    .padding(.top, 60)
                HStack {
                    Spacer()
                    //  <
                    Button {
                        withAnimation {
                            selectedMonth -= 1
                        }
                    } label: {
                        Image(systemName: "arrowtriangle.left.fill")
                            .frame(width: 18, height: 18)
                    }
                    
                    Spacer()
                    // 월
                    Text(selectedDate.printMonth())
                        .foregroundStyle(.hexB38DE2)
                        .fontWeight(.semibold)
                        .font(.system(size: 40))
                    // >
                    Spacer()
                    Button {
                        withAnimation {
                            selectedMonth += 1
                        }
                    } label: {
                        Image(systemName: "arrowtriangle.right.fill")
                            .frame(width: 18, height: 18)
                    }
                    
                    Spacer()
                }
            }
            .padding()
            
            // 요일 출력
            HStack {
                ForEach(days, id:\.self) { day in
                    Text(day)
                        .frame(width: 40, height: 34)
                }
            }
            
            // 일 출력
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(fetchDates()){ value in
                    ZStack {
                        if value.day != -1 {
                            Text("\(value.day)")
                                .foregroundStyle(.hex4E483C)
                                .font(.system(size: 20))
                                .frame(width: 32, height: 48)
                        } else {
                            Text("")
                        }
                    }
                }
            }
            .frame(width: screenWidth * 0.85, height: screenHeight * 0.4)
            Spacer()
        }
        .onChange(of: selectedMonth) {
                updateDate()
        }
        .ignoresSafeArea()
    }
    
    // 버튼 클릭 후 월을 변경하면 날짜도 달에 맞게 변경
    func updateDate() -> Void {
        selectedDate = fetchSelectedMonth()
    }
    
    func fetchDates() -> [CalendarDate] {
        let calendar = Calendar.current
        let currentMonth = fetchSelectedMonth()
        
        var dates = currentMonth.datesOfMonth().map({CalendarDate(day: calendar.component(.day, from: $0), date: $0)})
        
        let firstDayOfWeek = calendar.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        
        return dates
    }
    
    func fetchSelectedMonth() -> Date {
        let calendar = Calendar.current
        let month = calendar.date(byAdding: .month, value: selectedMonth, to: Date())
        return month!
    }
}

struct CalendarDate: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
}

extension Date {
    
    func printYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        
        return formatter.string(from: self)
    }
    func printMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        
        return formatter.string(from: self)
    }
    
    func datesOfMonth() -> [Date] {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: self)
        let currentYear = calendar.component(.year, from: self)
        
        var startDateComponents = DateComponents()
        startDateComponents.year = currentYear
        startDateComponents.month = currentMonth
        startDateComponents.day = 1
        let startDate = calendar.date(from: startDateComponents)!
        
        var endDateComponets = DateComponents()
        endDateComponets.month = 1
        endDateComponets.day = -1
        let endDate = calendar.date(byAdding: endDateComponets, to: startDate)!
        
        var dates: [Date] = []
        var currentDate = startDate
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        return dates
    }
}

#Preview {
    CalendarView()
}
