//
//  TimerSettingView.swift
//  MyApp
//
//  Created by 國澤 on 2021/09/11.
//

import SwiftUI

struct TimerSettingView: View {
    
    @AppStorage("timer_hours") var hours = 0
    @AppStorage("timer_minutes") var minutes = 0
    @AppStorage("timer_seconds") var seconds = 0
    
    var body: some View {
        HStack {
            Picker(selection: $hours, label: Text("hour")) {
                ForEach(0 ..< 24) { index in
                    Text("\(index)")
                        .tag(index)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80, height: 100)
            .clipped()
            
            Text("時間")
                .font(.headline)
            
            Picker(selection: $minutes, label: Text("minute")) {
                ForEach(0 ..< 60) { index in
                    Text("\(index)")
                        .tag(index)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80, height: 100)
            .clipped()
            
            Text("分")
                .font(.headline)
            
            Picker(selection: $seconds, label: Text("second")) {
                ForEach(0 ..< 60) { index in
                    Text("\(index)")
                        .tag(index)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 80, height: 100)
            .clipped()
            
            Text("秒")
                .font(.headline)
            
        }
    }
}

struct TimerSettingView_Previews: PreviewProvider {
    static var previews: some View {
        TimerSettingView()
    }
}
