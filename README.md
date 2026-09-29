# els-cas

A Typst port of Elsevier's CAS LaTeX classes, `cas-sc.cls` (single column) and `cas-dc.cls` (double column), version 2.4. It reproduces the page geometry, front matter, first-page notes, running heads and body styles of the LaTeX output. The design takes cues from [`elsearticle`](https://github.com/maucejo/elsearticle), the Typst port of `elsarticle.cls`.

![Title page of the sample article](thumbnail.png)

## Usage

```typ
#import "@preview/els-cas:0.1.0": *

#show: els-cas.with(
  layout: "dc", // "dc" = cas-dc (double column), "sc" = cas-sc (single column)
  title: [Title of the article],
  short-title: [Running head],
  authors: (
    (name: "Ada Lovelace", affiliations: 1, corresponding: true, email: "ada@example.org"),
    (name: "Charles Babbage", affiliations: (1, 2), orcid: "0000-0002-0000-0000"),
  ),
  affiliations: (
    "1": (organization: [Analytical Engine Laboratory], city: [London], country: [UK]),
    "2": [University of Cambridge, Cambridge, UK],
  ),
  abstract: [...],
  keywords: ([engines], [computation]),
)

= Introduction
...
#bibliography("refs.bib")
```

[`template/main.typ`](template/main.typ) is a port of `cas-dc-sample.tex` that uses every feature. Change `layout: "dc"` to `"sc"` to get the single-column version. Start a new project from it with `typst init @preview/els-cas`.

Until the package is on Typst Universe, install it locally. Clone this repository to `~/.local/share/typst/packages/local/els-cas/0.1.0` on Linux, or `~/Library/Application Support/typst/packages/local/els-cas/0.1.0` on macOS, then import `@local/els-cas:0.1.0`.

## Options of `els-cas`

| Option | Default | Description |
| --- | --- | --- |
| `layout` | `"dc"` | `"dc"`: 210×280 mm, two columns. `"sc"`: 192×262 mm, one column. |
| `title` | `none` | Article title. |
| `alt-title`, `subtitle`, `trans-title`, `trans-subtitle` | `none` | The other `\title[mode=...]` variants. |
| `short-title` | `auto` | Running head from page 2 on; defaults to `title`. |
| `short-authors` | `auto` | Author part of the footer; defaults to "A. Author et al.". |
| `authors` | `()` | Array of author dictionaries (see below). |
| `affiliations` | `(:)` | Dictionary from id to content or to a structured address (see below). |
| `title-notes` | `()` | Notes attached to the title, marked ⋆, ⋆⋆, … |
| `corresponding-notes` | `auto` | Texts for the marks ∗, ∗∗, …; defaults to "Corresponding author". |
| `author-notes` | `()` | Numbered author footnotes 1, 2, …; referenced by an author's `footnotes`. |
| `nonum-notes` | `()` | First-page notes without a mark. |
| `abstract`, `abstract-title` | `none`, `[Abstract]` | Abstract and its heading. |
| `keywords`, `keywords-title` | `()`, `[Keywords]` | Keywords, one per line in the "Article info" box. |
| `msc`, `jel`, `pacs` | `none` | Classification codes, also shown in the "Article info" box. `msc` accepts `(year: 2020, codes: [...])`. |
| `graphical-abstract` | `none` | Content of a graphical-abstract page placed before the article. |
| `highlights` | `()` | Research highlights, printed on their own page before the article. |
| `journal` | `[Elsevier]` | Footer text: "Preprint submitted to *journal*". |
| `blind` | `false` | Double-blind review: hides authors, affiliations, author notes, CRediT roles and biographies. |
| `review` | `false` | Double line spacing. |
| `long-title` | `false` | Allows front matter longer than one page (`longmktitle`). In the double-column layout the body then starts below it. |
| `logos` | `true` | Icons in front of emails, URLs and social links; `false` writes "Email address:", "URL:" and so on instead. |
| `fleqn` | `true` | Display equations aligned left and indented. |
| `line-numbers` | `false` | Line numbers restarting on each page. |
| `paper` | `auto` | Paper size; `auto` uses the CAS trim size of `layout`. |
| `fonts` | `(:)` | Overrides of `serif`, `sans`, `mono` and `math`. |
| `lang` | `"en"` | Document language. |

### Authors

Each author is a dictionary. Only `name` is required.

| Key | Description |
| --- | --- |
| `name` | A string is split at the last space into given names (printed grey, as in CAS) and surname. `(given: "William", family: "J. Hansen")` sets the split explicitly. |
| `style` | `"chinese"`: surname first, split at the first space. |
| `affiliations` | One id or an array of ids from `affiliations`, printed as letters a, b, … |
| `corresponding` | `true` or `n`: corresponding-author mark with `n` asterisks. The mark refers to the `n`-th entry of `corresponding-notes`. |
| `footnotes` | Number or array of numbers of `author-notes`. |
| `email`, `url`, `orcid` | Strings or arrays of strings. They are collected into first-page notes. |
| `twitter`, `facebook`, `linkedin`, `gplus` | Account names or full URLs. |
| `credit` | CRediT contribution roles, printed by `print-credits()`. |
| `prefix`, `suffix`, `degree`, `role` | For example `[Sir]`, `[Jr]`, `[PhD]`, `[Researcher]`. |
| `deceased` | Adds the ✠ mark and a "Deceased author." note. |

### Affiliations

An affiliation is either plain content or a dictionary like the keys of `\affiliation`. The entries are printed in the given order, each followed by a comma. The exception is `country`, which gets no separator. Add `<key>sep` to change the separator after an entry:

```typ
"2": (organization: [World Scientific University], addressline: [Street 29],
      postcode: [1011 NX], postcodesep: none, city: [Amsterdam], country: [The Netherlands]),
```

## Other functions

| Function | LaTeX equivalent |
| --- | --- |
| `new-theorem("theorem", [Theorem])` | `\newtheorem{theorem}{Theorem}`: bold heading, italic body. Pass `counter: "theorem"` to share numbering. Theorems can be labelled and referenced. |
| `new-definition("rmk", [Remark])` | `\newdefinition{rmk}{Remark}`: same as a theorem, with an upright body. |
| `new-proof("pf", [Proof])` | `\newproof{pf}{Proof}`: small-caps heading, no number. Use `qed` for the end-of-proof box. |
| `#show: appendix` | `\appendix`: sections are numbered A, B, … |
| `#print-credits()` | `\printcredits` |
| `#bio(image("photo.jpg"))[...]` | `\bio{photo} ... \endbio`. The photo is optional. |
| `toprule`, `midrule`, `bottomrule` | booktabs rules, for use inside `table(...)`. |

The environments defined by `new-theorem` and `new-definition` take an optional title:

```typ
#let theorem = new-theorem("theorem", [Theorem])
#theorem(title: [Fermat])[No three positive integers satisfy ...] <thm:fermat>
```

### Figures and tables

Figures and tables are captioned in a small sans-serif font: "**Figure 1:** …" below the figure, and "**Table 1**" on its own line above the table. Figures stay where they are written, as usual in Typst. Use `placement: auto` to let a figure float, and add `scope: "parent"` for a figure or table spanning both columns (`figure*`, `table*`):

```typ
#figure(image("wide.png"), caption: [...], placement: top, scope: "parent")
```

Tables have no strokes by default. Draw booktabs-style rules with `toprule`, `midrule` and `bottomrule`:

```typ
#figure(caption: [...], table(columns: 3, toprule, [A], [B], [C], midrule, [1], [2], [3], bottomrule))
```

### Bibliography

The default style is `elsevier-harvard` (author–year), the scheme of `cas-model2-names.bst`. For numbered references, pass `#bibliography("refs.bib", style: "elsevier-with-titles")`.

## Fonts

The LaTeX classes use STIX Two for text and math, Computer Modern Sans for the running head, footer and captions, and Inconsolata for code. The template looks for "STIX Two Text", "STIX Two Math" and "New Computer Modern Sans". If they are missing, it falls back to New Computer Modern, Helvetica or Arial, and DejaVu Sans Mono. Typst prints a warning for each font family it cannot find. To pick other fonts:

```typ
#show: els-cas.with(
  fonts: (sans: "Latin Modern Sans", mono: "Inconsolata"),
  // ...other options
)
```

## Differences from the LaTeX classes

- Author groups (`augroup`, `collaboration`) and affiliations printed as footnotes (`\address[..][foot=true]`) are not ported.
- Biography text runs beside the photo; it does not wrap below it.
- Second-level enumerations are labelled "a." instead of "(a)".
- Table captions span the column rather than the table width.
- First-page notes always sit at the bottom of the first page or column.

## License

The Typst code is released under the MIT license. The icons in `assets/` and the sample figures in `template/figs/` come from Elsevier's CAS LaTeX bundle, distributed under the LaTeX Project Public License.
