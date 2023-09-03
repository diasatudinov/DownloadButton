//
//  ContentView.swift
//  CircularDownloadButton
//
//  Created by Atudinov Dias on 19.08.2023.
//

import SwiftUI

struct MainView: View {
    //MARK: - Variables
    @State private var circleTrim: CGFloat = 0
    @State private var arrowEnd: CGFloat = 0

    @State private var downloadState: DownloadState = .notInitiated
    
    @State private var downloadPercentage: Double = 0
    @State private var time: CGFloat = 0.5
    
    @State private var animatableX: CGFloat = 0
    @State private var fillOffset: CGFloat = 0
    
    @State private var arrowYOffset: CGFloat = -40
    @State private var lineDifference: CGFloat = 0
    
    @State private var animationDuration: TimeInterval = 4
    
    let arrowHeight: CGFloat = 100
    let fillColor: Color = .blue
    
    //MARK: - Views
    var body: some View {
        GeometryReader { proxy in
            ZStack{
                Color.background
                    .edgesIgnoringSafeArea(.all)
                ZStack {
                    //fill
                    ZStack {
                        WaveFill(curve: time * 0.5, curveHeight: 10, curveLength: 5)
                            .fill(fillColor.opacity(0.975))
                            .offset(y: self.downloadState != .notInitiated ? fillOffset : -fillOffset + 5)
                        WaveFill(curve: time * 0.25, curveHeight: 5, curveLength: 10)
                            .fill(fillColor.opacity(0.9))
                            .offset(y: self.downloadState != .notInitiated ? fillOffset : -fillOffset + 7)
                    }
                    .animation(.linear(duration: animationDuration), value: downloadState)
                    .mask(Circle().scaleEffect(0.91))
                    
                    Circle()
                        .stroke(lineWidth: 10)
                        .fill(fillColor)
                        .opacity(0.85)
                    
                    ZStack {
                        ArrowShape(lineWidth: arrowHeight, animatableX: animatableX, lineDifference: lineDifference)
                            .trim(from: 0, to: arrowEnd)
                            .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                            .offset(y: arrowYOffset)
                            .animation(.easeOut(duration: 0.35).delay(0.075), value: downloadState)
                        
                        TickShape(scaleFactor: 1)
                            .trim(from: 0, to: self.downloadState == .downloaded ? 1 : 0)
                            .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
                            .offset(y: 6)
                            .animation(.easeInOut(duration: 0.35).delay(0.075), value: downloadState)
                    }
                    
                    ZStack{
                        Circle()
                            .trim(from: 0, to: circleTrim)
                            .stroke(style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round))
                            .rotation(.degrees(-90))
                            .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0))
                        
                        Circle()
                            .trim(from: 0, to: circleTrim)
                            .stroke(style: StrokeStyle(lineWidth: 11, lineCap: .round, lineJoin: .round))
                            .rotation(.degrees(90))
                        
                        Text("\(downloadPercentage.clean(places: 2))%")
                            .font(.system(size: 64, weight: .semibold, design: .monospaced))
                            .foregroundColor(.label)
                            .frame(minWidth: 300)
                            .opacity(self.downloadState == .downloading ? 1 : 0)
                            .animation(.easeInOut(duration: 0.3), value: downloadState)
                    }
                }
                .frame(width: proxy.size.width * 0.6)
                .offset(y: -24)
            }
            .overlay(alignment: .topTrailing) {
                Button {
                    reset()
                } label: {
                    Image(systemName: "gobackward")
                        .font(.system(size: 24, weight: .semibold))
                }
                .buttonStyle(.plain)
                .opacity(self.downloadState == .downloaded ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: downloadState)

            }
            .padding(24)
            .onTapGesture {
                guard downloadState == .notInitiated else { return }
                initiateDownload()
            }
        }
        .onAppear() {
            fillOffset = -150
            
            withAnimation(.spring()) {
                arrowYOffset = 0
            }
            
            withAnimation(.easeInOut(duration: 0.4)){
                arrowEnd = 1
            }
        }
    }
    //MARK: - Functions
    func initiateDownload() {
        withAnimation(.default) {
            arrowYOffset = -20
        }
        
        withAnimation(.easeInOut(duration: 0.3)) {
            animatableX = arrowHeight / 3
        }
        
        withAnimation(.easeInOut(duration: 0.5).delay(0.2)) {
            lineDifference = arrowHeight
            arrowYOffset = arrowHeight
        }
        
        withAnimation(.default.delay(0.45)) {
            animatableX = arrowHeight / 3 + 10
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
            animate()
        }
        
    }
    
    func animate() {
        animationDuration = 4
        downloadState = .downloading
        
        withAnimation(.linear(duration: animationDuration)) {
            circleTrim += 0.5
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration / 100, repeats: true) { timerBlock in
            downloadPercentage += 1
            
            if downloadPercentage == 100 {
                downloadState = .downloaded
                timerBlock.invalidate()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { waveTimer in
            guard self.downloadState == .downloading else {
                waveTimer.invalidate()
                return
            }
            
            withAnimation(.default) {
                time += 0.05
            }
        }
    }
    
    func reset() {
        animationDuration = 0
        downloadPercentage = 0
        
        withAnimation(.easeInOut(duration: 0.5)) {
            circleTrim = 0
            time = 0.5
            downloadState = .notInitiated
        }
        
        withAnimation(.default) {
            fillOffset = -150
        }
        
        withAnimation(.spring().delay(0.3)) {
            arrowYOffset = 0
        }
        
        withAnimation(.easeInOut(duration: 0.4).delay(0.35)) {
            arrowEnd = 1
            lineDifference = 0
        }
        
        withAnimation(.default.delay(0.375)) {
            animatableX = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
