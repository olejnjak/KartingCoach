//
//  DisplayableError.swift
//  KartingCoach
//
//  Created by Lukáš Hromadník on 10.09.17.
//

import Foundation

protocol DisplayableError {
    var title: String? { get }
    var message: String? { get }
}
