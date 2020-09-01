/**
*  KaTeXPublishPlugin
*  Copyright (c) Utku Birkan 2020
*  MIT license, see LICENSE file for details
*/

import XCTest
@testable import KatexPlugin

final class KatexRenderTests: XCTestCase {
    func testReadKatexJS() throws {
        let contents = try XCTUnwrap(KatexJS.content)
        XCTAssert(contents.starts(with: "(function(f)"))
    }
        
    func testInlineRender() {
        let renderer = KatexRenderer()

        guard let result = try? renderer.render("\\sqrt{2}") else {
            XCTFail()
            return
        }
        XCTAssert(result.hasPrefix(#"<span class="katex">"#))
    }
    
    func testDisplayRender() {
        let renderer = KatexRenderer()

        guard let result = try? renderer.render("\\sqrt{2}", as: .displayMode) else {
            XCTFail()
            return
        }
        XCTAssert(result.hasPrefix(#"<span class="katex-display">"#))
    }
    
    func testRenderError() {
        let renderer = KatexRenderer()
        
        guard let result = try? renderer.render("\\sqrt{{2}", as: .displayMode) else {
            XCTFail()
            return
        }
        
        // span tag is not closed with this one
        XCTAssert(result.hasPrefix(#"<span class="katex-error""#))
    }
    
    func testRenderWithMacros() {
        let renderer = KatexRenderer(with: ["\\myBra": "\\vert{#1}\\rangle"])
        guard let result = try? renderer.render("\\myBra{0}") else {
            XCTFail()
            return
        }
        XCTAssert(result.hasPrefix(#"<span class="katex">"#))
    }
    
    static var allTests = [
        ("testReadKatexJS", testReadKatexJS),
        ("testInlineRender", testInlineRender),
        ("testDisplayRender", testDisplayRender),
        ("testRenderError", testRenderError),
        ("testRenderWithMacros", testRenderWithMacros)
    ]

}
