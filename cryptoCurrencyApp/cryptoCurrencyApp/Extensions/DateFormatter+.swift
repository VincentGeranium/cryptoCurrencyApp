//
//  DateFormatter+.swift
//  cryptoCurrencyApp
//
//  Created by Kwangjun Kim on 2022/04/23.
//

import Foundation
import UIKit

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    static let commonDateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.fffffff"
        return formatter
    }()
}
