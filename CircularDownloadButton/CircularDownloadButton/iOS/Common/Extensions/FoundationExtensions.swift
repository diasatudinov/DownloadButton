//
//  FoundationExtensions.swift
//  CircularDownloadButton
//
//  Created by Atudinov Dias on 19.08.2023.
//

import Foundation

extension Double {
    func clean(places: Int) -> String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.\(places)f", self)
    }
}
