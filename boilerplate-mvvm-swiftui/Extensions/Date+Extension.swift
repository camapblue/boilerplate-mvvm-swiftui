//
//  Date+Extension.swift
//  boilerplate-swiftui-bloc
//
//  Created by @camapblue on 12/31/21.
//

import Foundation

extension Date {
    func age(now: Calendar = Calendar.current) -> Int { now.dateComponents([.year], from: self, to: Date()).year! }
}
