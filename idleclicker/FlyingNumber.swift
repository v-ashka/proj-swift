//
//  FlyingNumber.swift
//  idleclicker
//
//  Created by student on 09/01/2024.
//
import SwiftUI

struct FlyingNumber: View {
    let number: Int
    @State private var positionX: Int = Int.random(in: -70..<70)
    @State private var positionY: Int = Int.random(in: 1..<150)
    @State private var offset: CGFloat = 0
    var body: some View {
        if number != 0 {
            Text("\(number)")
                .font(.largeTitle)
                .foregroundColor(number < 0 ? .red : .green)
                .shadow(color: .black, radius: 1.5 , x: 1, y: 1)
                .offset(x: CGFloat(positionX), y: CGFloat(positionY))
                .opacity(offset != 0 ? 0 : 1)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.5)){
                        offset = number < 0 ? 100 : -100
                    }
                }
                .onDisappear{
                    offset = 0
                    positionX = 0
                    positionY = 0
                }
        }
    }
}

struct FlyingNumber_Previews: PreviewProvider {
    static var previews: some View {
        FlyingNumber(number: 5)
    }
}
