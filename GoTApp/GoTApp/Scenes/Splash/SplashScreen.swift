//
//  SplashScreen.swift
//  GoTApp
//
//  Created by Sena Kurtak on 26.07.2023.
//
//

import SwiftUI

struct SplashScreen: View {
    // MARK: Properties

    @State var isActive: Bool = false
    
    // MARK: UI Elements

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black
                HStack {
                    if self.isActive {
                        HomeScreen()
                    } else {
                        Image("SplashImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width - 30, height: geometry.size.width * 8.18 - 30)
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                    }
                }
            }
            .ignoresSafeArea(.container)
            .background(Color.black)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
