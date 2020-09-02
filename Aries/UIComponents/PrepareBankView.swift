//
//  PrepareBankView.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/19.
//

import SwiftUI

struct PrepareBankView: View {
    var body: some View {
        VStack {
            Text("貯金箱を用意しましょう")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(.displayP3, white: 0, opacity: 0.85))
            Image("chokinbako")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 50)
            TextBox(text: "貯金箱でなくてもマグカップやお菓子の空き缶など様々なものを貯金箱として使ってみるのもOK!")
                .lineSpacing(10.0)
                .padding()
            AriesLink(destination: InputPaymentView(), text: "準備できた！")
                .frame(maxWidth: .infinity)
                .cornerRadius(8.0)
                .padding(.top, 50)
        }
        .padding(.horizontal, 20)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PrepareBankView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            PrepareBankView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        }
    }
}
