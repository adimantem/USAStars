//
//  ContentView.swift
//  USAStars
//
//  Created by Don Jose on 1/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { geometry in
            let portrait = geometry.size.width < geometry.size.height
            let hoist = 1.0; let fly = 1.9
            let aspectRatio = portrait ? hoist/fly : fly/hoist
            
            Stripes()
                .aspectRatio(aspectRatio, contentMode: .fit)
        }
    }
}

#Preview {
    ContentView()
}

extension Color {
    static let USAOldGloryRed = Color(#colorLiteral(red: 0.6980392157, green: 0.1333333333, blue: 0.2039215686, alpha: 1))
    static let USAOldGloryBlue = Color(#colorLiteral(red: 0.2352941176, green: 0.231372549, blue: 0.431372549, alpha: 1))
}

struct Stripes: View {
    var body: some View {
        GeometryReader { geometry in
            let portrait = geometry.size.width < geometry.size.height
            
            if portrait {
                let starsRectangleBackgroundWidth = geometry.size.width * (7/13)
                let starsRectangleBackgroundHeight = geometry.size.height * 0.4
                let radius = min(starsRectangleBackgroundWidth,
                                 starsRectangleBackgroundHeight) / 13 * 0.8
                
                Group {
                    Color.USAOldGloryBlue
                    
                    VStack (spacing: 0) {
                        ForEach(0 ..< 6) { _ in
                            HStack (spacing: 0) {
                                ForEach(0 ..< 5) { _ in
                                    Group {
                                        Star()
                                            .frame(width: radius, height: radius)
                                            .foregroundStyle(.white)
                                            .rotationEffect(.degrees(270))
                                    }
                                    .frame(width: starsRectangleBackgroundWidth/5,
                                           height: starsRectangleBackgroundHeight/6)
                                    
                                }
                            }
                        }
                    }
                    
                    VStack (spacing: 0) {
                        ForEach(0 ..< 5) { _ in
                            HStack (spacing: 0) {
                                ForEach(0 ..< 4) { _ in
                                    Group {
                                        Star()
                                            .frame(width: radius, height: radius)
                                            .foregroundStyle(.white)
                                            .rotationEffect(.degrees(270))
                                    }
                                    .frame(width: starsRectangleBackgroundWidth/5,
                                           height: starsRectangleBackgroundHeight/6)
                                }
                            }
                        }
                    }
                }
                .frame(width: starsRectangleBackgroundWidth,
                       height: starsRectangleBackgroundHeight)
                
            }
            else {
                let starsRectangleBackgroundWidth = geometry.size.width * 0.4
                let starsRectangleBackgroundHeight = geometry.size.height * (7/13)
                let radius = min(starsRectangleBackgroundWidth,
                                 starsRectangleBackgroundHeight) / 13 * 0.8
                
                Group {
                    Color.USAOldGloryBlue
                    
                    VStack (spacing: 0) {
                        ForEach(0 ..< 5) { _ in
                            HStack (spacing: 0) {
                                ForEach(0 ..< 6) { _ in
                                    Group {
                                        Star()
                                            .frame(width: radius, height: radius)
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: starsRectangleBackgroundWidth/6,
                                           height: starsRectangleBackgroundHeight/5)
                                    
                                }
                            }
                        }
                    }
                    
                    VStack (spacing: 0) {
                        ForEach(0 ..< 4) { _ in
                            HStack (spacing: 0) {
                                ForEach(0 ..< 5) { _ in
                                    Group {
                                        Star()
                                            .frame(width: radius, height: radius)
                                            .foregroundStyle(.white)
                                    }
                                    .frame(width: starsRectangleBackgroundWidth/6,
                                           height: starsRectangleBackgroundHeight/5)
                                }
                            }
                        }
                    }
                }
                .frame(width: starsRectangleBackgroundWidth,
                       height: starsRectangleBackgroundHeight)
            }
        }
    }
}

struct Star: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            for index in 0 ..< 5 {
                let angle = (270 + Double(index) * 144) * (.pi/180)
                let point = CGPoint(x: rect.midX + cos(angle) * rect.width,
                                    y: rect.midY + sin(angle) * rect.width)
                
                index == 0 ? path.move(to: point) : path.addLine(to: point)
            }
            path.closeSubpath()
        }
    }
}


/*
 Hoist (height) of the flag: A = 1.0
 Fly (width) of the flag: B = 1.9
 Hoist (height) of the canton ("union"): C = 0.5385 (A × 7/13, spanning seven stripes)
 Fly (width) of the canton: D = 0.76 (B × 2/5, two-fifths of the flag width)
 E = F = 0.0538 (C/10, one-tenth of the height of the canton)
 G = H = 0.0633 (D/12, one twelfth of the width of the canton)
 Diameter of star: K = 0.0616 (approximately L × 4/5, four-fifths of the stripe width)
 Width of stripe: L = 0.0769 (A/13, one thirteenth of the flag height)
 */
