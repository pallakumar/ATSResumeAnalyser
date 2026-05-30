//
//  FilterATSResumeApp.swift
//  ResumeViewModel
//
//  Created by Lakshmi Kumar on 29/05/26.
//

import Foundation
import SwiftUI

@MainActor
final class ResumeViewModel: ObservableObject {

    @Published var atsScore = 0
    @Published var suggestions: [String] = []

    private let parser = PDFParser()

    func uploadPDF(_ url: URL) {

        let text = parser.extractText(from: url)

        analyze(text)
    }

    private func analyze(_ text: String) {

        let keywords = [
            "SwiftUI",
            "MVVM",
            "iOS",
            "Clean Architecture",
        ]

        let matched = keywords.filter {
            text.lowercased().contains($0.lowercased())
        }

        atsScore = (matched.count * 100) / keywords.count

        suggestions = [
            "Add measurable achievements",
            "Improve keyword optimization",
            "Mention architecture patterns",
            "Add production app experience"
        ]
    }
}
