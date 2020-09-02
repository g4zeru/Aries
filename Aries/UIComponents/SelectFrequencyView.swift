//
//  SelectFrequencyView.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/20.
//

import SwiftUI

struct SelectFrequencyView: View {
    @AppStorage(wrappedValue: Frequency.everyDay, AppStorageKey.frequency.rawValue) var currentFrequency: Frequency
    @AppStorage(wrappedValue: true, AppStorageKey.isFirstLaunch.rawValue) var isFirstLaunch
    var body: some View {
        VStack {
            Text("通知する頻度は？")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(Color(.displayP3, white: 0, opacity: 0.85))
            Picker(selection: $currentFrequency, label: Text(""), content: {
                ForEach(Frequency.allCases, id: \.self) { frequency in
                    Text(frequency.kana).tag(frequency)
                }
            })
                .labelsHidden()
            TextBox(text: "毎日ちょっとずつ貯金するのがおすすめです！自分に合った頻度で始めましょう")
                .lineSpacing(10.0)
                .padding()
            AriesButton(action: {
                var notificationTime = DateComponents()
                notificationTime.hour = 15
                notificationTime.minute = 00
                switch currentFrequency {
                case .everyDay: break
                case .everyWeek: notificationTime.weekday = 1
                case .everyMonth: notificationTime.day = 1
                }
                let content = UNMutableNotificationContent()
                content.body = "貯金してる？"
                content.sound = UNNotificationSound.default
                let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: true)
                UNUserNotificationCenter.current().removeAllDeliveredNotifications()
                UNUserNotificationCenter.current().add(.init(identifier: UUID().uuidString, content: content, trigger: trigger), withCompletionHandler: nil)
                isFirstLaunch = false
            }, text: "決定！")
                .frame(maxWidth: .infinity)
                .cornerRadius(8.0)
                .padding(.top, 50)
        }
        .padding(.horizontal, 30)
    }
}

struct SelectFrequencyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectFrequencyView()
    }
}
