//
//  HomeViewTemplate.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/20.
//

import SwiftUI

struct HomeViewTemplate: View {
    struct Report {
        let deposit: Int
        let usedMoney: Int
    }
    let totalDeposit: Int
    let weeklyDeposit: [Report]
    let disabledButton: Bool
    let saveMoney: () -> Void
    let useMoney: () -> Void
    @State var showingAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 0) {
                Text("Total")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                Text("¥\(totalDeposit)")
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray)
            }
            VStack {
                Text("Weekly reports")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                VStack(spacing: 20) {
                    ForEach(0..<weeklyDeposit.count) { index in
                        if weeklyDeposit[index].deposit != 0 || weeklyDeposit[index].usedMoney != 0 {
                            VStack(spacing: 5) {
                                if weeklyDeposit[index].deposit != 0 {
                                    Text("\(index == 0 ? "今週" : "\(index)週間前")は ¥\(weeklyDeposit[index].deposit)貯金した!")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                }
                                if weeklyDeposit[index].usedMoney != 0 {
                                    Text("\(index == 0 ? "今週" : "\(index)週間前")は ¥\(weeklyDeposit[index].usedMoney)使ってしまった、、。")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .foregroundColor(.ariesRed)
                                }
                                Rectangle().frame(height: 1, alignment: .center)
                            }
                        }
                    }
                }
            }.padding(.bottom, 30)
            HStack(alignment: .center, spacing: 10) {
                AriesButton(action: {
                    showingAlert = true
                }, text: "貯金を使う", style: totalDeposit == 0 ? .gray : .red)
                    .cornerRadius(8.0)
                    .disabled(totalDeposit == 0)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("本当に貯金を使いますか？"),
                              message: Text("貯金を使う場合は全額使用することになります。"),
                              primaryButton: .cancel(Text("キャンセル")),
                              secondaryButton: .destructive(Text("使う"), action: useMoney))
                    }
                AriesButton(action: saveMoney, text: "貯金する", style: disabledButton ? .gray : .yellow)
                    .cornerRadius(8.0)
                    .disabled(disabledButton)
            }
            TextBox(text: "貯金は1日1回まで！ゆっくり焦らず貯金を進めるのが大事。まずはじめは貯めている金額よりも、貯める事をルーティンとして続けられるようになろう！")
        }
        .padding(20).navigationTitle("Aries")
    }
    
    func weeklyKey(record: Record) -> String {
        let week = Calendar.shared.component(.weekOfYear, from: record.entryDate!)
        let year = Calendar.shared.component(.yearForWeekOfYear, from: record.entryDate!)
        return "\(year)/\(week)"
    }
    
    func compareKey(currentKey: String, nextKey: String) -> Bool {
        let currentKeyComponents = currentKey.components(separatedBy: "/").compactMap { Int($0) }
        let nextkeyComponents = nextKey.components(separatedBy: "/").compactMap { Int($0) }
        return currentKeyComponents[0] < nextkeyComponents[1] && currentKeyComponents[1] < nextkeyComponents[1]
    }
}

struct HomeViewTemplate_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewTemplate(totalDeposit: 2700, weeklyDeposit: [.init(deposit: 2700, usedMoney: 3000), .init(deposit: 4000, usedMoney: 0), .init(deposit: 4000, usedMoney: 0)], disabledButton: true, saveMoney: {}, useMoney: {})
    }
}
