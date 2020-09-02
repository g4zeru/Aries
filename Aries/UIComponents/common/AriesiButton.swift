//
//  AriesButton.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/19.
//

import SwiftUI

struct AriesButton: View {
    enum Style {
        case yellow
        case red
        case gray
    }
    let action: () -> Void
    let text: String
    var style: Style = .yellow
    var body: some View {
        Button(action: action) {
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

struct AriesButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AriesButton(action: {}, text: "Hello world", style: .yellow)
            AriesButton(action: {}, text: "Hello world", style: .red)
        }
    }
}
