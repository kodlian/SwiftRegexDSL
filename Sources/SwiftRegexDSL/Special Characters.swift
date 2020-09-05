//
//  Special Characters.swift
//  
//
//  Created by Jeremy Marchand on 05/09/2020.
//

import Foundation

/// Match a BELL, \u0007.
public struct Bell: Regex {
    public var body: Regex {
        return UnsafeText(#"\a"#)
    }
}

/// Match an ESCAPE, \u001B.
public struct Escape: Regex {
    public var body: Regex {
        return UnsafeText(#"\e"#)
    }
}

/// Match a FORM FEED, \u000C.
public struct Form: Regex {
    public var body: Regex {
        return UnsafeText(#"\f"#)
    }
}

/// Match a LINE FEED, \u000A.
public struct Line: Regex {
    public var body: Regex {
        return UnsafeText(#"\n"#)
    }
}

/// Match a CARRIAGE RETURN, \u000D.
public struct CarriageReturn: Regex {
    public var body: Regex {
        return UnsafeText(#"\r"#)
    }
}

/// Match a HORIZONTAL TABULATION, \u0009.
public struct Tab: Regex {
    public var body: Regex {
        return UnsafeText(#"\t"#)
    }
}
