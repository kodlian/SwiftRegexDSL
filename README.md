# SwiftRegexDSL

Most of us, Swift developers, are not using and creating regular expressions on day to day basis. But each time we need it, we rely on web search, old documentations, deal with unsafety, and perform many runs before getting the good result. It feels a heavy rollback of what we are used too when coding with modern language and IDE such as Swift and XCode.
All is due to the fact that regexes in Swift are basically strings, which result to no edition/compile time check and code completion.
In addition regexes by nature are mostly write-only things. Unless you make an effort or have a master degree on regex, this will never be as easy to understand as the rest of your code base. Just imagine if your view was described like so "v[l(title)i(logo)s].p(a|v|x)", not great isn't it.   

This brings SwiftRegexDSL, a Declarative Structured Language for regular expressions in Swift. The idea is to leverage the same "magic" that powers SwiftUI, ~~Function Builder~~ [Result Builder](https://github.com/apple/swift-evolution/blob/main/proposals/0289-result-builders.md) to regex. The DSL makes the expressions readable, far more suitable for composition, in addition to bringing safety. To summarise, no, at least less,  headaches with regex. 

## Installation
SwiftRegex comes as a Swift package, you can simply add it from XCode in your iOS or macOS project in `File > Swift Packages > Add Package Dependency` and looking for `https://github.com/kodlian/SwiftRegexDSL.git`

If you are doing things manually, you can add the dependency in `Package.swift`

```swift
dependencies: [

dependencies: [
    .package(url: "https://github.com/kodlian/SwiftRegexDSL.git", .upToNextMajor(from: "0.1.0"))
]
```

## How to?
Like SwiftUI view you declare your regex as a struct preferably in separate file and use an annotation `@RegexBuilder` .
```swift
import SwiftRegexDSL

struct MyRegex: Regex {
  @RegexBuilder
  var body: Regex {
    Digit()
     .oneOrMore()  
    Word()
  }
}

```

### Pattern
SwiftRegexDSL implements the most common pattern found in the [`ICU`](http://userguide.icu-project.org/strings/regexp) API used by the Swift foundation.

#### The basic
Most common character classes and special characters are supported such as `AnyCharacter`, `Digit`, `NotDigit`, `Word`, `Whitespace`. Please refer to `CharacterClass.swift` and `SpecialCharacters.swift` to see the full coverage. 

Of course, you can add any strings in your regex body, either directly or by using the `Text` regex.
```swift
@RegexBuilder
var pattern: Regex {
 "Title"
 Text("-") 
  .quantified(0..<2)
 Digit()
}
```
Take notice that a `String` is not a `Regex`, but rather an expression convertible to a Regex. Which means, If you need to apply a modifier wrap it in a `Text`.

#### Quantifier
You can attach a quantifier using the `quantified(...)`  modifier or any shortcuts `zeroOrMore`,  `oneOrMore`,  `zeroOrOne`,  `exactly`  to specify the number of occurrences a pattern should match.
```swift
@RegexBuilder
var pattern: Regex {
 Text("-")
   .zeroOrOne()  
 Digit()
   .quantified(1..<4)
}
```

#### Group and Assertion
Grouping for readability and for applying a modifier can be added to the body of regex using `Group`.
```swift
Digit()
Group {
   Word()
   Digit()
}.zeroOrMore()
...
```
In addition, the DSL supports:
- A or B pattern using `Alternative` regex
- Assertions using `LookAheadAssertion`, `NegativeLookAheadAssertion`,... to match but by not advancing the input position 
- Capturing group `CaptureGroup` for retrieving a range matching a sub expression
- Applying pattern option such as `caseInsensitive` using the `.options(...)` modifier on any pattern

#### Regex Set
Set can be defined as Array or using Swift Set using either `Character` or range of characters.
```swift
Digit()
[`a`,`c`...`z`]
...
```
Excluding set can be created using `ExclusionSet` structure.

#### Anchor 
Anchor to match a particular area of the input string using  either `StartAnchor` or `EndAnchor` can be added in the body
```swift
StartAnchor.line
Digit()
...
```

#### Unicode
The DSL supports pattern by unicode name, hexadecimal or property using `UnsafeUnicode`. Although it is considered to be unsafe as parameter are strings and not bounded for hexadecimal.

#### Composition, Parametrisation and Custom
SwiftRegexDSl is designed to be extensible, you compose your regex using other regex:
```swift
import SwiftRegexDSL

struct DomainRegex: Regex { ... }
struct ExtensionRegex: Regex { ... }

struct HostRegex: Regex {
  var body: Regex {
     DomainRegex()
     "."
     ExtensionRegex()
  }
}

```

As regex is defined as a `Struct` and the DSL supports control flows, it is easy to define parameters as a type property:
```swift
import SwiftRegexDSL

struct TitleRegex: Regex {

  let shouldStartWithDigit: Bool
  
  @RegexBuilder
  var body: Regex {
    if shouldStartWithDigit {
      Digit()
        .oneOrMore()  
    }
    AnyCharacter()
      .oneOrMore()
  }
}
```

If the framework is missing something such as a regex metacharacters, you can use a `UsafeRawText` in your regex body as `Text` in the DSL are automatically escaped for safety.
If such case appear, don't hesitate to contribute to the framework to improve the coverage of the regex standard. 

### Regex usage
When your regex is ready, the framework offers various extensions on `String`:
- check if a string match a regex by using `.match(regex)`
- find the range in string matching the regex using  `.range(of: regex)` 
- find ranges of capturing groups  `.capturedGroupsRanges(of: regex, with: "foo")` 
- replace a part of a string using `.replacingOccurrences(of: regex, with: "foo")`

`NSRegularExpression` can also be created from a `Regex`. 

## Future Direction and final note
It is a young project and many improvements can be done: 
- Unicode regex by name or property offers tons of possibilities. Having enum to describe the most used ones could be a nice addition, offering safety and discoverability.
-  Retrieving the ranges of capturing group is still not very convenient with the framework. Perhaps a system could exist where a binding or callback is directly defined within the body of the Regex. 
- Matching digit is easy with Regex, but number is always a pain. Take for instance IPV4 where each part should not be superior to 255 resulting in quite long regex hard to read and painful to create, here the way to match 0 to 255:
```25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?```
Creating a regex matching closed range of number will be a time saviour. 
- Anchors are currently a little bit raw and can be anywhere in an expression. There is certainly more safety and conveniency to add around then.
- Set are limited to `Character`, which for now for digit we need to use the `Character` representation of this digit.

Final word, I am definitely not an expert in Regex hence the existence of this framework to ease my pain working with them: so I may have missed and done some mistakes. By making it open source, I hope the swift community contributions will bring it to the next level.
