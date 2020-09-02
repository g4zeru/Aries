//
//  Frequency.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/20.
//

import Foundation

enum Frequency: String, Hashable, CaseIterable, RawRepresentable {
    typealias RawValue = String
    
    case everyDay
    case everyWeek
    case everyMonth
}

extension Frequency {
    var kana: String {
        switch self {
        case .everyDay: return "毎日"
        case .everyWeek: return "毎週"
        case .everyMonth: return "毎月"
        }
    }
}
