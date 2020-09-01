/**
*  KaTeXPublishPlugin
*  Copyright (c) Utku Birkan 2020
*  MIT license, see LICENSE file for details
*/

import XCTest
@testable import Ink
@testable import KatexPlugin

final class InkModifierTests: XCTestCase {
    func testInkModifier() {
        let parser = MarkdownParser(modifiers: [Modifier.katexBlock()])
        let res = parser.html(from: #"\(\sqrt{2}\)"#)
        XCTAssert(res.hasPrefix(#"<p><span class="katex">"#))
    }
    
    static var allTests = [
        ("testInkModifier", testInkModifier)
    ]
}

