//
//  FilterATSResumeApp.swift
//  PDFParser
//  Created by Lakshmi Kumar on 29/05/26.

import Foundation
import PDFKit

final class PDFParser {

    func extractText(from url: URL) -> String {

        guard let pdf = PDFDocument(url: url) else {
            return ""
        }

        var text = ""

        for index in 0..<pdf.pageCount {
            text += pdf.page(at: index)?.string ?? ""
        }

        return text
    }
}
