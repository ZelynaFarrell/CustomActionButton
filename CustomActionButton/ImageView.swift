//
//  ImageView.swift
//  CustomActionButton
//
//  Created by Zelyna Sillas on 8/22/23.
//

import SwiftUI

struct ImageView: View {
    // wallpaper design ideas
    
    var body: some View {
        ZStack {
            Image(.wallpaper1)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: 10)
                .ignoresSafeArea()

            VStack {
                Image(.card)
                    .resizable()
                    .frame(width: 500, height: 450)
                    .scaledToFit()
                
                Group {
                    Text("Cryptocurrency")
                    Text("Trading")
                    
                }  .font(.system(size: 40))
                    .fontWeight(.heavy)
                    .foregroundStyle(.linearGradient(colors: [.white.opacity(0.8), .purple.opacity(0.6)], startPoint: .top, endPoint: .bottom))
                
                Text("Explore, invest in, and manage your\ntransactions with leading cryptocurrencies\nall in one place, at the press of a button.")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.white.opacity(0.8))
                    .padding(.top, 5)
                
                Spacer()
            }
            .multilineTextAlignment(.center)
        }
        .background(.black)
    }
}

#Preview {
    ImageView()
}
