//
//  TimePickerView.swift
//  Sportified
//
//  Created by Tariq Mahmood   on 22/05/2024.
//

import SwiftUI

enum TimePickerViewTypes {
    case singleTime
    case rangeTime
}
enum PickerTypes {
    case time
    case date
}

struct TimePickerView: View {
    
    @Binding var selectedTime: String
    @State var startTimePicked = Date()
    var type: TimePickerViewTypes = .rangeTime
    var pickerType:PickerTypes = .time
    let cancelCallback: (() -> Void)
    let doneCallBack: (() -> Void)
    
    var body: some View {
        ZStack{
            ActivityIndicator()
            VStack(alignment: .center) {
                if pickerType == .time{
                    switch type {
                    case .singleTime:
                        HStack {
                            Text(StringConstants.selectTime).font(Font.mulishBold(size: 20))
                            Spacer()
                        }
                        
                        DatePicker("", selection: $startTimePicked, displayedComponents: .hourAndMinute).labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle()).frame(width: 220)
                    case .rangeTime:
                        VStack {
                            
                            
                            
                            DatePicker("", selection: $startTimePicked, displayedComponents: .hourAndMinute).labelsHidden()
                                .datePickerStyle(WheelDatePickerStyle()).frame(width: 220)
                            
                            
                        }
                        
                    }
                }else{
                    VStack {

                        DatePicker("", selection: $startTimePicked, displayedComponents: .date).labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle()).frame(width: 220)
                        
                    }
                }
                HStack(spacing: 30) {
                    Button(StringConstants.cancel) {
                        cancelCallback()
                    }
                    .frame(width: 120, height: 45)
                    .foregroundColor(Color.white)
                    .background(Color.red)
                    .cornerRadius(54)
                    .font(.mulishBold(size: 18.0))
                    .shadow(color: Color.gray.opacity(0.28), radius: 14, x: 0, y: 8)
                    
                    Button(StringConstants.done) {
                        
                        if pickerType == .time{
                            let startTime = formatTime(date: startTimePicked)
                            selectedTime = " \(startTime)"
                        }else{
                            let startTime = formatDate(date: startTimePicked)
                            selectedTime = " \(startTime)"
                        }
                        doneCallBack()
                        
                        
                    }
                    .frame(width: 120, height: 45)
                    .foregroundColor(Color.white)
                    .background(Color.appGreen)
                    .cornerRadius(54)
                    .font(.mulishBold(size: 18.0))
                    .shadow(color: Color.gray.opacity(0.28), radius: 14, x: 0, y: 8)
                }
            }.signupExpandedCardView().fixedSize(horizontal: true, vertical: false)
        }
    }
    
    func formatTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY:MM:dd"
        return formatter.string(from: date)
    }
}

struct TimePickerView_Previews: PreviewProvider {
    @State static var selectedTime = ""
    @State static var datePicked = Date()
    static var previews: some View {
        TimePickerView(selectedTime: $selectedTime) {
            print("Cancel Button Pressed")
        } doneCallBack: {
            print("Done Button Pressed")
            print(selectedTime)
        }
        
    }
}

struct SignupExpanedCardView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 40).padding(.top, 34).padding(.bottom, 24).background(Color.white).overlay(RoundedRectangle(cornerRadius: 34, style: .continuous).stroke(Color.strokColor, lineWidth: 1)).cornerRadius(34).shadow(color: Color.textFieldColor, radius: 22, x:0 , y: 13)
    }
}


