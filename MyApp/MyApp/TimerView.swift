//
//  TimerView.swift
//  MyApp
//
//  Created by 國澤 on 2021/09/11.
//

import SwiftUI

struct TimerView: View {
    
    @State var timerHandler : Timer?
    @State var count = 0
    @AppStorage("timer_hours") var hours = 0
    @AppStorage("timer_minutes") var minutes = 0
    @AppStorage("timer_seconds") var seconds = 0
    var timerValue: Int{
        get {
            3600 * hours + 60 * minutes + seconds
        }
    }
    @State var button_switch: Int = 0
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30.0) {
                Spacer()
                HStack {
                    Text("\((timerValue - count)/3600) : \(((timerValue - count)/60)%60) : \((timerValue - count)%60)")
                        .font(.system(size: 70))
                        .padding()
                    
                    
                        
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        if let unwrapedTimerHandler = timerHandler {
                            if unwrapedTimerHandler.isValid == true {
                                unwrapedTimerHandler.invalidate()
                            }
                        }
                        count = 0
                        button_switch = 0
                    }) {
                        Image(systemName: "goforward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.red)
                    }
                    Spacer()
                    if button_switch == 0 {
                        Button(action: {
                            if timerValue == 0 {
                                showAlert = true
                            }else{
                                startTimer()
                                button_switch = 1
                            }
                        }) {
                            Image(systemName: "play.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.red)
                        }
                    }else {
                        Button(action: {
                            if let unwrapedTimerHandler = timerHandler {
                                if unwrapedTimerHandler.isValid == true {
                                    unwrapedTimerHandler.invalidate()
                                    button_switch = 0
                                }
                            }
                        }) {
                            Image(systemName: "pause.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.red)
                        }
                    }
                    Spacer()
                }
                
                Spacer()
            
            }
            
            .onAppear {
                if let unwrapedTimerHandler = timerHandler {
                    if unwrapedTimerHandler.isValid == true {
                        unwrapedTimerHandler.invalidate()
                    }
                }
                count = 0
                button_switch = 0
                
            }
            .navigationBarTitle("タイマー", displayMode: .inline)
            .navigationBarItems(trailing:
                NavigationLink(
                    destination: TimerSettingView()){
                    Text("秒数設定")
                }
            )
            .alert(isPresented: $showAlert) {
                Alert(title: Text("終了"),
                      message: Text("タイマー終了時間です"),
                      dismissButton: .default(Text("OK"),
                                              action: {
                                                count = 0
                                                button_switch = 0
                                              }))
            }
        }
    }
    
    func countDownTimer() {
        count += 1
        
        if timerValue - count <= 0 {
            timerHandler?.invalidate()
            showAlert = true
        }
    }
    
    func startTimer() {
        
        if let unwrapedTimerHandler = timerHandler {
            if unwrapedTimerHandler.isValid == true {
                return
            }
        }
        
        if timerValue - count <= 0 {
            count = 0
        }
        
        timerHandler = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            countDownTimer()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
