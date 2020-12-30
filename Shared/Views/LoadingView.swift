//
//  LoadingView.swift
//  herosMarvel
//
//  Created by JOSE LUIS BUSTOS ESTEBAN on 30/12/20.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var shouldAnimate = false
    
    var body: some View {
        HStack{
            Circle()
                .fill(Color.blue)
                .frame(width: 30, height: 30, alignment: .center)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever())
            
            Circle()
                .fill(Color.blue)
                .frame(width: 30, height: 30, alignment: .center)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.25))
            
            
            Circle()
                .fill(Color.blue)
                .frame(width: 30, height: 30, alignment: .center)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.5))
        }
        .padding()
        .background(
            //vista dentro del backenground
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.gray.opacity(0.4))
        )
        .onAppear {
            self.shouldAnimate = true
        }
        .onDisappear{
            self.shouldAnimate = false
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
