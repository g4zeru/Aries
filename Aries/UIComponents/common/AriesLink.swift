//
//  AriesLink.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/20.
//

import SwiftUI

struct AriesLink<Destination> : View where Destination: View {
    enum Style {
        case yellow
        case red
        case gray
    }
    let destination: Destination
    let text: String
    var style: Style = .yellow
    var body: some View {
        NavigationLink(destination: destination) {
            Text(text)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
        }.background({ () -> Color in
            switch style {
            case .red: return .ariesRed
            case .yellow: return .ariesYellow
            case .gray: return .gray
            }
        }())
    }
}

struct AriesLink_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AriesLink(destination: Text("働け"), text: "Hello world", style: .yellow)
            AriesLink(destination: Text("働け"), text: "Hello world", style: .red)
        }
    }
}
