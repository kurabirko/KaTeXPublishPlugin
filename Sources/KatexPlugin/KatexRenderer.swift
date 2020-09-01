/**
*  KaTeXPublishPlugin
*  Copyright (c) Utku Birkan 2020
*  MIT license, see LICENSE file for details
*/

import Foundation
import JavaScriptCore

public class KatexRenderer: NSObject {
    let macros: [String: String]?
    let trust: Bool
    
    lazy var context: JSContext? = {
        guard let katexScript = KatexJS.content else {
            return nil
        }
    
        guard let context = JSContext() else {
            return nil
        }
        
        context.evaluateScript(katexScript)
        context.evaluateScript("var renderToString = Katex.renderToString")
        
        return context
    }()
    
    public init(with macros: [String: String]? = nil, trust: Bool = true) {
        self.macros = macros
        self.trust = trust
    }
}

public extension KatexRenderer {
    enum RenderStyle {
        case inline
        case displayMode
    }
    
    func render(_ text: String, as style: RenderStyle = .inline) throws -> String {
        guard let context = context else {
            throw KatexPluginError("JSContext is nil")
        }
                
        var options: [String: Any] = [
            "displayMode": style.asBool,
            "throwOnError": false,
            "trust": trust
        ]
        
        if let macros = self.macros {
            options["macros"] = macros
        }
        
        guard let function = getRenderFunction(from: context) else {
            throw KatexPluginError("Could not get render function from JSContext")
        }
        
        guard let result = function.call(withArguments: [text, options]) else {
            throw KatexPluginError("Could not render using JSContext")
        }

        guard !result.isUndefined else{
            throw KatexPluginError("Could not get render function from JSContext")

        }
        
        return result.toString()
    }
}

private extension KatexRenderer {
    func getRenderFunction(from context: JSContext) -> JSValue? {
        guard let function = context.objectForKeyedSubscript("renderToString") else {
            return nil
        }
        
        guard !function.isUndefined else {
            return nil
        }
        
        return function
    }
}

private extension KatexRenderer.RenderStyle {
    var asBool:Bool {
        switch self {
        case .displayMode:
            return true
        case .inline:
            return false
        }
    }
}
