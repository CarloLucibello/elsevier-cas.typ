// Constants shared by the els-cas modules. Values mirror cas-common.sty,
// cas-sc.cls and cas-dc.cls (v2.4) and the 10pt LaTeX `article` class
// they build on.

/// Font sizes of the 10pt `article` class as `(size, baselineskip)` pairs.
#let sizes = (
  scriptsize: (7pt, 8pt),
  footnotesize: (8pt, 9.5pt),
  small: (9pt, 11pt),
  normal: (10pt, 12pt),
  large: (12pt, 14pt),
  Large: (14.4pt, 18pt),
  LARGE: (17.28pt, 22pt),
)

/// Fonts. The LaTeX classes use STIX for text and math, Computer Modern Sans
/// for the running head, footer and captions, and Inconsolata for monospace.
/// The lists are kept short because Typst warns about every family it cannot
/// find; override any entry through the `fonts` argument.
#let default-fonts = (
  serif: ("STIX Two Text", "New Computer Modern"),
  sans: ("New Computer Modern Sans", "Helvetica", "Arial"),
  mono: "DejaVu Sans Mono",
  math: ("STIX Two Math", "New Computer Modern Math"),
)

// Text lines are `1em` tall (0.7em above and 0.3em below the baseline), so
// `leading = baselineskip - size` reproduces LaTeX's baselineskip exactly.
#let top-edge = 0.7em
#let bottom-edge = -0.3em

#let link-color = rgb("#2f4f4f") // hscolor = DarkSlateGrey
#let rule-color = luma(50%) // \dashrule colour: black!50
#let given-name-color = luma(50%) // first names in the author list: black!50

/// Page geometry of cas-sc.cls (single column) and cas-dc.cls (double column).
#let layouts = (
  sc: (width: 192mm, height: 262mm, top: 19mm, bottom: 19mm, x: 13.7mm, columns: 1),
  dc: (width: 210mm, height: 280mm, top: 19.5mm, bottom: 18.2mm, x: 18.1mm, columns: 2),
)
#let column-gutter = 18pt
#let par-indent = 1.5em
#let math-indent = 2.5em // \mathindent under the `fleqn` option

/// Document-wide information needed after the front matter (by
/// `print-credits` and `bio`).
#let cas-info = state("els-cas-info", (authors: (), blind: false))
