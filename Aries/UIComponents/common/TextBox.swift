//
//  TextBox.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/19.
//

import SwiftUI

struct TextBox: View {
    let text: String
    var body: some View {
        ZStack {
            Text(text)
                .foregroundColor(Color(.displayP3, white: 0, opacity: 0.6))
                .font(.footnote)
                .fontWeight(.light)
                .padding(.all, 18)
        }
        .background(Color.ariesBackgroundYellow)
        .cornerRadius(8)
    }
}

struct TextBox_Previews: PreviewProvider {
    static var previews: some View {
        TextBox(text: "毎日ちょっとずつ貯金するのがおすすめです！自分に合った頻度で始めましょう")
    }
}
