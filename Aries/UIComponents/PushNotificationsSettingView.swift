//
//  PushNotificationsSettingView.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/19.
//

import SwiftUI

struct PushNotificationsSettingView: View {
    @AppStorage(wrappedValue: true, AppStorageKey.isFirstLaunch.rawValue) var isFirstLaunch
    @State var isPushed: Bool = false
    var body: some View {
        ZStack {
            VStack {
                Text("通知の設定をしましょう")
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(.displayP3, white: 0, opacity: 0.85))
                Image(systemName: "app.badge")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100)
                    .foregroundColor(.ariesRed)
                    .padding(.vertical, 100)
                TextBox(text: "貯金を一人でするのはなかなか大変なのでアプリが貯金をする日にお知らせします")
                    .lineSpacing(10.0)
                    .padding()
                AriesButton(action: {
                    let center = UNUserNotificationCenter.current()
                    center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
                        if granted {
                            isPushed = true
                        } else {
                            isFirstLaunch = false
                        }
                    })
                }, text: "設定する")
                    .frame(maxWidth: .infinity)
                    .cornerRadius(8.0)
                    .padding(.top, 50)
            }
            .padding(.horizontal, 20)
            NavigationLink(
                destination: SelectFrequencyView(),
                isActive: $isPushed,
                label: {
                    Text("")
                })

        }
    }
}

struct PushNotificationsSettingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PushNotificationsSettingView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            PushNotificationsSettingView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE (2nd generation)"))
        }
    }
}
