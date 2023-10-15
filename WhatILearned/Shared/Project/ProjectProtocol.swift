//
//  ProjectProtocol.swift
//  WhatILearned
//
//  Created by Ghadirian, Hamed, HSE DE on 09.10.23.
//

import Foundation
import SwiftUI

protocol ProjectProtocol: Identifiable {
    var id: UUID { get }
    var name: String { get }
    static func project() -> any ProjectProtocol
    static func run() -> AnyView
}

extension ProjectProtocol {
    var name: String { "\(Self.self)" }
    var id: UUID { UUID() }
}