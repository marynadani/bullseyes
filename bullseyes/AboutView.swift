//
//  AboutView.swift
//  bullseyes
//
//  Created by Maryna Danilova on 21.07.2024.
//

import SwiftUI

struct AboutView: View {
    let beige = Color(red: 1.0, green: 0.87, blue: 0.7)
    var body: some View {
        Group{
            VStack{
                Text("🎯 Bullseye 🎯")
                    .modifier(AboutHeadingStyle())
                    .navigationTitle("About Bullseye")
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                    .modifier(AboutBodyStyle())
                Text("Your goal is to place the slider as close as possibleto the target value. The closer you are, the more points you score.")
                    .modifier(AboutBodyStyle())
                Text("Enjoy!")
                    .modifier(AboutBodyStyle())
            }
            .background(beige)
        }
        .background(Image("background"))
    }
}

struct AboutHeadingStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Ariel Rounded MT Bold", size: 30))
            .foregroundColor(Color.black)
            .padding(.top, 20)
            .padding(.bottom, 20)
    }
}

struct AboutBodyStyle : ViewModifier {
    func body(content: Content) -> some View {
        content
             .font(Font.custom("Ariel Rounded MT Bold", size: 16))
            .foregroundColor(Color.black)
            .lineLimit(nil)
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.bottom, 20)
    }
}

#Preview {
    AboutView()
}
