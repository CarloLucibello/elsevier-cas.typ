// Exercises options not covered by examples/sample.typ.
// Compile from the repository root, e.g.
//   typst compile --root . tests/features.typ --input long=true --input blind=true
#import "/src/lib.typ": *

#let flag(name) = sys.inputs.at(name, default: "false") == "true"

#show: els-cas.with(
  layout: sys.inputs.at("layout", default: "dc"),
  title: [A study of everything],
  alt-title: [An alternate title],
  subtitle: [A sub title],
  trans-title: [Un titre traduit],
  trans-subtitle: [Un sous-titre traduit],
  title-notes: [A single title note.],
  authors: (
    (
      name: "Ada Lovelace",
      affiliations: "lab",
      corresponding: true,
      footnotes: 1,
      email: "ada@example.org",
      twitter: "ada",
      linkedin: "ada-lovelace",
      degree: [PhD],
      credit: [Everything],
    ),
    (
      name: "Charles Babbage",
      affiliations: ("lab", "uni"),
      deceased: true,
      orcid: "0000-0002-0000-0000",
      facebook: "cbabbage",
      gplus: "cb",
    ),
  ),
  affiliations: (
    lab: [Analytical Engine Laboratory, London, UK],
    // no `country`: no separator after the last entry
    uni: (organization: [University of Cambridge], city: [Cambridge]),
  ),
  author-notes: [An author note.],
  abstract: [#lorem(if flag("long") { 700 } else { 60 })

    #lorem(30)],
  keywords: ([Babbage's engines], [computation]),
  msc: (year: 2020, codes: [68Q05, 01A55]),
  jel: [C63],
  blind: flag("blind"),
  long-title: flag("long"),
  logos: not flag("nologos"),
  review: flag("review"),
  line-numbers: flag("lines"),
  highlights: ([One], [Two]),
)

= Introduction <sec:intro>

#lorem(40) A body footnote#footnote[Body footnotes continue after the author notes, unless `blind`.].

A display equation
$ E = m c^2 $ <eq:e>
where this line continues the paragraph and must not be indented. #lorem(10)

$ a^2 + b^2 = c^2 $

This paragraph follows a blank line after the equation and is indented. See @eq:e and @sec:intro.

== A subsection

#lorem(30)

=== A subsubsection

#lorem(30)

==== A paragraph heading
#lorem(30)

===== A subparagraph heading
#lorem(20)

+ First
+ Second
  + Nested
- Bullet
  - Nested bullet

/ Term: Description of the term.

#lorem(100)

// A column break under `long` (double column), else a page break.
#pagebreak()

#show: appendix
= Proofs <app:proofs>
== Details
See @app:proofs. #lorem(50)

#print-credits()
#bio[#lorem(40)]
