/**
*  KaTeXPublishPlugin
*  Copyright (c) Utku Birkan 2020
*  MIT license, see LICENSE file for details
*/

import Publish
import Ink
import Foundation

public extension Modifier {
    static func katexBlock(withKatexMacros macros: [String: String]? = nil, trust: Bool = true) -> Self {
        let renderer = KatexRenderer(with: macros, trust: trust)
        
        return Modifier(target: .math) { html, markdown in
            guard let renderResult = try? renderer.render(markdown.dropFistLast(2), as: html.renderStyle) else {
                return html
            }
            return renderResult
        }
    }
}

extension String {
    var renderStyle: KatexRenderer.RenderStyle {
        if self.starts(with: #"<span class="math display">"#) {
            return .displayMode
        } else {
            return .inline
        }
    }
}

extension Substring {
    func dropFistLast(_ k: Int = 1) -> String {
        var substring = self.dropFirst(k)
        substring = substring.dropLast(k)
        return String(substring)
    }
}
