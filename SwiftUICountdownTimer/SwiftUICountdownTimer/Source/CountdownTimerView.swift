//
//  CountdownTimerView.swift
//  SwiftUICountdownTimer
//
//  Created by ibrahimyilmaz on 23.11.2020.
//

import SwiftUI

struct CountdownTimerView: View {
        
    @State var isCounting: Bool
    @State var remainingSeconds: Int
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("\(timeString(from: remainingSeconds))")
                .onReceive(timer) { _ in
                    if isCounting && remainingSeconds > 0 {
                        remainingSeconds -= 1
                    }
                }
        }.padding()
        
        VStack {
            HStack {
                Button("+10 SEC") {
                    remainingSeconds += 10
                }.padding()
                Button("+20 SEC") {
                    remainingSeconds += 20
                }.padding()
            }.padding()
            
            HStack {
                Button("START") {
                    isCounting = true
                }.padding()
                Button("STOP") {
                    isCounting = false
                }.padding()
            }.padding()
        }
    }
    
    init(seconds: Int, isCounting: Bool = false) {
        _remainingSeconds = State(initialValue: seconds)
        _isCounting = State(initialValue: isCounting)
    }
    
    private func timeString(from totalSeconds: Int) -> String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format:"%02i:%02i:%02i",hours,minutes, seconds)
    }
}

struct CountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerView(seconds: 40)
    }
}
