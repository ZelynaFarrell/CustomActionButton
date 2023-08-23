//
//  ContentView.swift
//  CustomActionButton
//
//  Created by Zelyna Sillas on 8/21/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager = MotionManager()
    @State var showIcons = false
    
    var body: some View {
        ZStack {
            Image(.wallpaperUI1)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(50)
                .overlay(motion)
                .scaleEffect(showIcons ? 0.93 : 1)
            
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay(Rectangle().fill(.black.opacity(0.5)).blendMode(.overlay))
                .mask(canvas)
                .shadow(color: .white.opacity(0.2), radius: 0, x: -1, y: -1)
                .shadow(color: .black.opacity(0.2), radius: 0, x: 1, y: 1)
                .shadow(color: .black.opacity(0.5), radius: 10, x: 10, y: 10)
                .overlay(icons)
                .background(
                    circle.frame(width: 208)
                        .overlay(circle.frame(width: 60))
                        .overlay(circle.frame(width: 80))
                        .offset(x: 60, y: 60)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .opacity(showIcons ? 1 : 0)
                        .scaleEffect(showIcons ? 1 : 0.8, anchor: .bottomTrailing)
                        .animation(.easeOut(duration: 0.3), value: showIcons)
                )
                .offset(y: -19)
                .onTapGesture {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                        showIcons.toggle()
                    
                    }
                }
        }
        .ignoresSafeArea()
        .preferredColorScheme(.dark)
    }
    
    var circle: some View {
        // creates connecting strokes between each icon
        Circle().stroke().fill(.linearGradient(colors: [.white.opacity(0.3), .clear], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
    var icons: some View {
        ZStack {
            Image(systemName: "plus")
                .font(.system(size: 30))
                .rotationEffect(.degrees(showIcons ? 45 : 0))
                .offset(x: -28, y: -28)
            
            Group {
                Image(systemName: "creditcard")
                    .offset(x: -28, y: -129)
                
                Image(systemName: "key.icloud")
                    .offset(x: -130, y: -31)
                
                Image(systemName: "faceid")
                    .offset(x: -113, y: -114)
            }
            .font(.system(size: 20))
            .opacity(showIcons ? 1 : 0)
            //adds depth during animation
            .blur(radius: showIcons ? 0 : 10)
            .scaleEffect(showIcons ? 1 : 0.5)
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
    }
    
    var motion: some View {
        // creates a holographic effect for UI when device is in motion
        ZStack {
            // reflection to the UI perimeter
            RoundedRectangle(cornerRadius: 50)
                .stroke(.linearGradient(colors: [.white.opacity(0.2), .white.opacity(0.5), .clear], startPoint: .topLeading, endPoint: UnitPoint(x: abs(manager.roll) * 5 + 1, y: abs(manager.roll) * 5 + 1)))
           
            // reflection to the entire screen
            LinearGradient(colors: [.clear, .white.opacity(0.5), .clear], startPoint: .topLeading, endPoint: UnitPoint(x: abs(manager.roll) * 10 + 1, y: abs(manager.roll) * 10 + 1))
                .cornerRadius(50)
            // soften the reflection color
            LinearGradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 0.8456191498))], startPoint: .topLeading, endPoint: .bottomTrailing)
                .blendMode(.softLight)
        }
        .opacity(showIcons ? 1 : 0)
    }
    
    var canvas: some View {
        // draw circles that go around the icons
        Canvas { context, size in
            // blur and alpha combined creates a liquid effect
            context.addFilter(.alphaThreshold(min: 0.8))
            context.addFilter(.blur(radius: 10))
            context.drawLayer { ctx in
                for index in 1...4 {
                    if let symbol = context.resolveSymbol(id: index) {
                        ctx.draw(symbol, at: CGPoint(x: size.width - 44, y: size.height - 44))
                    }
                }
            }
        } symbols: {
            Circle()
                .frame(width: 76)
                .tag(1)
            
            Circle()
                .frame(width: 76)
                .tag(2)
                .offset(x: showIcons ? -100 : 0)
            
            Circle()
                .frame(width: 76)
                .tag(3)
                .offset(y: showIcons ? -100 : 0)
            
            Circle()
                .frame(width: 76)
                .tag(4)
                .offset(x: showIcons ? -84 : 0, y: showIcons ? -84 : 0)
        }
    }
}

#Preview {
    ContentView()
}
