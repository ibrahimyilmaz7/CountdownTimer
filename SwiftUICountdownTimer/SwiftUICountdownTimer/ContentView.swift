//
//  ContentView.swift
//  SwiftUICountdownTimer
//
//  Created by ibrahimyilmaz on 23.11.2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CountdownTimerView(seconds: 60)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
