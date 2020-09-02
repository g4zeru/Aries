//
//  HomeView.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/18.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Record.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Record.entryDate, ascending: true)], predicate: NSPredicate(format: "entryDate >= %@", Calendar.shared.startOfWeek(for: Date()) as CVarArg)) var thisWeekRecord: FetchedResults<Record>
    @FetchRequest(entity: Record.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Record.entryDate, ascending: true)], predicate: NSPredicate(format: "entryDate >= %@ And entryDate < %@", argumentArray: [Calendar.shared.move(Date(), byWeeks: -1), Calendar.shared.startOfWeek(for: Date())])) var lastWeekRecord: FetchedResults<Record>
    @FetchRequest(entity: Record.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Record.entryDate, ascending: true)], predicate: NSPredicate(format: "entryDate >= %@ And entryDate < %@", argumentArray: [Calendar.shared.move(Date(), byWeeks: -2), Calendar.shared.move(Date(), byWeeks: -1)])) var weekBeforeLastRecord: FetchedResults<Record>
    @FetchRequest(entity: Bank.entity(), sortDescriptors: []) var banks: FetchedResults<Bank>
    @AppStorage(wrappedValue: 300, AppStorageKey.depositValue.rawValue) var amount
    
    @State var isPushed: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: ErrorView(code: .saveContext), isActive: $isPushed, label: { Text("") })
                HomeViewTemplate(totalDeposit: Int(banks.first?.totalDeposit ?? 0),
                                 weeklyDeposit: [thisWeekRecord, lastWeekRecord, weekBeforeLastRecord].map(calculateDeposit(records:)),
                                 disabledButton: !thisWeekRecord.filter { Calendar.shared.isDate($0.entryDate!, inSameDayAs: Date()) }.isEmpty,
                                 saveMoney: saveMoney,
                                 useMoney: useMoney)
            }
        }
    }
    
    func calculateDeposit(records: FetchedResults<Record>) -> HomeViewTemplate.Report {
        HomeViewTemplate.Report(deposit: records.compactMap { Int($0.amount) }.filter { $0 > 0 }.reduce(0) { $0 + $1 },
                                usedMoney: records.compactMap { Int($0.amount) }.filter { $0 < 0 }.reduce(0) { $0 - $1 })
    }
    
    func saveMoney() {
        let bank = banks.first ?? Bank(context: context)
        let record = Record(context: context)
        record.amount = Int32(amount)
        record.entryDate = Date()
        bank.totalDeposit += Int64(amount)
        do {
            try context.save()
        } catch {
            isPushed = true
        }
    }
    
    func useMoney() {
        let bank = banks.first ?? Bank(context: context)
        let record = Record(context: context)
        let payout = 0 - Int(bank.totalDeposit)
        record.amount = Int32(payout)
        record.entryDate = Date()
        bank.totalDeposit = 0
        do {
            try context.save()
        } catch {
            isPushed = true
        }
    }
}
