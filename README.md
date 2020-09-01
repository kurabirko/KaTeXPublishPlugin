# KaTeXPublishPlugin

A [Publish](https://github.com/johnsundell/publish) plugin to render equations using [KaTeX](https://katex.org). This way you can remain JS free

## Installation

Until [JohnSundell/Ink#56](https://github.com/JohnSundell/Ink/pull/56) is merged, this repo uses my fork of [Ink](https://github.com/JohnSundell/Ink) and Publish. Since KaTeXPublishPlugin is using `JavaScriptCore`, there is currently no Linux support.

To install, add the following to your `Package.swift`.

```swift
import PackageDescription

let package = Package(
    ...
    dependencies: [
        .package(name: "Publish", url: "https://github.com/kurabirko/publish.git", .branch("master")),
        .package(name: "KatexPublishPlugin", url: "https://github.com/kurabirko/katexpublishplugin.git", .branch("main"))
    ],

    ...
    targets: [
        .target(
            name: "MyWebsite",
            dependencies: ["Publish", "KatexPublishPlugin"]
        )
    ]
)
```

Now you can simply install the plugin.

```swift
import KatexPlugin

struct MyWebsite: Website { ... }
try MyWebsite().publish(

    ...
    plugins: [
        .katex()
    ])
```

You can also use you own katex macros and choose not to trust equation sources [(see here)](https://katex.org/docs/options.html) while installing the plugin.

```swift
try MyWebsite().publish(

    ...
    plugins: [.katex(
        withKatexMacros: ["\\myMacro": "\\bold{#1}"],
        trustSources: false)])

```

Note that your theme needs to supply the Katex css and font files. Otherwise browsers cannot display the equations correctly. A reference theme based on John Sundell's Foundation theme is available. You can try it by importing `KatexFoundationTheme`

```swift
import KatexPlugin
import KatexFoundationTheme

...
try MyWebsite().publish(
    withTheme: .foundationKatex,
    plugins: [.katex()])
```

## Contributions

- This project uses some code from Publish which is licensed under MIT License
- This project uses KaTeX, which is also licensed under MIT License
