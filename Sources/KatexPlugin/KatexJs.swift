/**
*  KaTeXPublishPlugin
*  Copyright (c) Utku Birkan 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

struct KatexJS {
    static let name: StaticString = "katex.js"
    static let location: StaticString = "Sources/KatexPlugin/Resources"
    
    static var content: String? {
        let fm = FileManager()
        let absoulutePath = URL(fileURLWithPath: "\(location)/\(name)", isDirectory: false, relativeTo: fm.packageRoot)
        
        do {
            let fileContents = try String(contentsOf: absoulutePath)
            return fileContents
        } catch (let err) {
            print(err)
            return nil
        }
    }
}

extension FileManager {
    enum Existance: Equatable {
        case doesNotExist
        case isDirectory
        case isFile
    }

    var packageRoot: URL? {
        var currentDirectory = URL(fileURLWithPath: #file, isDirectory: false).deletingLastPathComponent()
        
        while case Existance.isDirectory = existanceOf(currentDirectory) {
            let packagePath = currentDirectory.appendingPathComponent("Package.swift")
            if case Existance.isFile = existanceOf(packagePath) {
                return currentDirectory
            }
            currentDirectory.deleteLastPathComponent()
        }
        return nil
    }
    
    func existanceOf(_ file: URL) -> Existance {
        var isDirectory: ObjCBool = false
        let exists = fileExists(atPath: file.path, isDirectory: &isDirectory)
        
        switch (exists, isDirectory.boolValue) {
        case (false, _): return .doesNotExist
        case (true, true): return .isDirectory
        case (true, false): return .isFile
        }
    }
}
