//
//  InputPaymentView.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/20.
//

import SwiftUI

struct InputPaymentView: View {
    @AppStorage(wrappedValue: 300, AppStorageKey.depositValue.rawValue) var value
    var intProxy: Binding<String> {
            Binding<String>(
                get: { String(value) },
                set: {
                    if let value = NumberFormatter().number(from: $0) {
                        self.value = value.intValue
                    } else {
                        self.value = 0
                    }
                }
            )
        }
    var body: some View {
        print(value)
        return VStack {
            Text("一回分の貯金金額は？")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(.displayP3, white: 0, opacity: 0.85))
            TextField("300円", text: intProxy)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .padding()
            TextBox(text: "毎日ちょっとずつ貯金するのがおすすめです！自分に合った頻度で始めましょう")
                .lineSpacing(10.0)
                .padding()
            AriesLink(destination: PushNotificationsSettingView(), text: "決定！", style: value == 0 ? .gray : .yellow)
                .frame(maxWidth: .infinity)
                .disabled(value == 0)
                .cornerRadius(8.0)
                .padding(.top, 50)
        }
        .padding(.horizontal, 30)
    }
}

struct InputPaymentView_Previews: PreviewProvider {
    static var previews: some View {
        InputPaymentView()
    }
}
