/**
*  KaTeXPublishPlugin
*  Copyright (c) Utku Birkan 2020
*  MIT license, see LICENSE file for details
*/

import Publish
import Ink
import Foundation

public extension Plugin {
    static func katex(withKatexMacros katexMacros: [String: String]? = nil, trustSources: Bool = true) -> Self {
        return Plugin(name: "Katex") { context in
            context.markdownParser.addModifier(
                .katexBlock(withKatexMacros: katexMacros, trust: trustSources))
        }
    }
}


struct KatexPluginError: Error {
    let reason: String
    
    init(_ reason: String) {
        self.reason = reason
    }
}
