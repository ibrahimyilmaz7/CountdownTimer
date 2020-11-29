//
//  CountdownTimerView.swift
//  SwiftUICountdownTimer
//
//  Created by ibrahimyilmaz on 23.11.2020.
//

import SwiftUI

struct CountdownTimerView: View {
        
    private let predefinedSeconds: [Int] = [10, 30, 60, 120, 300]
    private let symbolActive = "play.circle.fill"
    private let symbolInactive = "pause.circle.fill"
    private let timerFont = Font.custom("DBLCDTempBlack", size: 50)
    
    @State var isCounting: Bool
    @State var remainingSeconds: Int
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(getTimeString(from: remainingSeconds))")
                .onReceive(timer) { _ in
                    if isCounting && remainingSeconds > 0 {
                        remainingSeconds -= 1
                    } else {
                        isCounting = false
                    }
                }.font(timerFont)
        }.padding()
        
        VStack {
            HStack {
                ForEach (predefinedSeconds, id: \.self) { seconds in
                    Button(getButtonString(from: seconds)) {
                        addSeconds(seconds)
                    }.padding(5)
                }
            }.padding()
            
            Button(action: {
                isCounting.toggle()
            }, label: {
                Image(systemName: isCounting ? symbolInactive : symbolActive)
                    .font(.system(size: 100))
            }).padding()
        }
    }
    
    init(seconds: Int, isCounting: Bool = false) {
        _remainingSeconds = State(initialValue: seconds)
        _isCounting = State(initialValue: isCounting)
    }
    
    private func addSeconds(_ seconds: Int) {
        remainingSeconds += seconds
    }
    
    private func getTimeString(from totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = totalSeconds / 60 % 60
        let seconds = totalSeconds % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    private func getButtonString(from totalSeconds: Int) -> String {
        if totalSeconds >= 60 {
            return "+\(totalSeconds / 60) min"
        } else {
            return "+\(totalSeconds) sec"
        }
    }
}

struct CountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerView(seconds: 40)
    }
}
