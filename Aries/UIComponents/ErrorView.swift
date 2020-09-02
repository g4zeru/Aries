//
//  ErrorView.swift
//  Aries
//
//  Created by Haruta Yamada on 2020/08/20.
//

import SwiftUI

struct ErrorView: View {
    enum ErrorCode: Int {
        case saveContext = 100
    }
    let code: ErrorCode
    var body: some View {
        VStack(spacing: 20) {
            Text("予期せぬエラーが発生しました")
                .font(.title2)
                .fontWeight(.semibold)
            Text("Code...\(code.rawValue)")
                .font(.headline)
                .fontWeight(.light)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(code: .saveContext)
    }
}

