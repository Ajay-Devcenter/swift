// RUN: %target-typecheck-verify-swift -swift-version 3

public struct Pair<A, B> {}

public struct PublicStruct {
  public struct Inner {}
  @available(*, unavailable)
  internal struct Obsolete {} // expected-note * {{marked unavailable here}}
}

@available(*, unavailable, renamed: "PublicStruct")
public typealias ObsoleteAlias = PublicStruct // expected-note {{marked unavailable here}}

public let a: ObsoleteAlias.Inner?
public let b: ObsoleteAlias.Obsolete? // expected-error {{'Obsolete' is unavailable}}
public let c: Pair<ObsoleteAlias.Inner, PublicStruct.Obsolete>? // expected-error {{'Obsolete' is unavailable}}
public let c2: Pair<PublicStruct.Obsolete, ObsoleteAlias.Inner>? // expected-error {{'Obsolete' is unavailable}}
public let d: ObsoleteAlias? // expected-error {{'ObsoleteAlias' has been renamed to 'PublicStruct'}}
