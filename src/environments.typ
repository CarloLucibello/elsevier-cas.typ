// Body-matter helpers: theorem-like environments, appendix, CRediT
// statement, biographies and booktabs rules.
#import "globals.typ": *
#import "utils.typ": *

// Tables -------------------------------------------------------------------

/// Booktabs rules (`\toprule`, `\midrule`, `\bottomrule`) for use in `table`.
#let toprule = table.hline(stroke: 0.8pt)
#let midrule = table.hline(stroke: 0.5pt)
#let bottomrule = table.hline(stroke: 0.8pt)

// Theorems -----------------------------------------------------------------

#let thm-kind-prefix = "cas-thm:"

/// Define a numbered theorem-like environment (`\newtheorem`): bold heading
/// "Theorem 1." followed by an italic body. Environments sharing a `counter`
/// are numbered together (`\newtheorem{lemma}[theorem]{Lemma}`).
///
/// ```typ
/// #let theorem = new-theorem("theorem", [Theorem])
/// #let lemma = new-theorem("lemma", [Lemma], counter: "theorem")
/// #theorem(title: [Fermat])[No three positive integers ...] <thm:fermat>
/// ```
/// - name (str): identifier of the environment.
/// - supplement (content): heading word, also used by references.
/// - counter (str, none): name of the environment whose counter is shared.
/// - italic (bool): set the body in italics.
/// -> function
#let new-theorem(name, supplement, counter: none, italic: true) = {
  let kind = thm-kind-prefix + if counter == none { name } else { counter }
  (title: none, body) => figure(
    kind: kind,
    supplement: supplement,
    numbering: "1",
    outlined: false,
    caption: title,
    if italic { emph(body) } else { body },
  )
}

/// Like `new-theorem`, with an upright body (`\newdefinition`).
#let new-definition(name, supplement, counter: none) = new-theorem(
  name,
  supplement,
  counter: counter,
  italic: false,
)

/// Define an unnumbered proof-like environment (`\newproof`): heading in
/// small capitals, upright body.
#let new-proof(name, supplement) = (title: none, body) => block(
  width: 100%,
  breakable: true,
  above: 10pt,
  below: 10pt,
  {
    set par(first-line-indent: (amount: par-indent, all: false))
    [#smallcaps[#supplement#if title != none [ (#title)].] #body]
  },
)

/// End-of-proof square pushed to the right margin (`\qed`).
#let qed = [#h(1fr)$square$]

/// Render theorem figures created by `new-theorem`; applied by `els-cas`.
#let show-theorem(it) = {
  if type(it.kind) != str or not it.kind.starts-with(thm-kind-prefix) {
    return it
  }
  let title = if it.caption != none { it.caption.body }
  block(width: 100%, breakable: true, above: 10pt, below: 10pt, {
    set align(left)
    set par(first-line-indent: (amount: par-indent, all: false))
    let number = context it.counter.display(it.numbering)
    [#strong[#it.supplement #number#if title != none [ (#title)].] #it.body]
  })
}

// Appendix -----------------------------------------------------------------

/// Start the appendices (`\appendix`): sections are numbered A, B, ...
/// Use as `#show: appendix`.
#let appendix(body) = {
  set heading(
    numbering: (..n) => if n.pos().len() <= 3 { numbering("A.1", ..n) },
    supplement: [Appendix],
  )
  counter(heading).update(0)
  body
}

// CRediT authorship statement ----------------------------------------------

/// Print the CRediT authorship contribution statement from the `credit`
/// entries of the authors (`\printcredits`).
#let print-credits(
  title: [CRediT authorship contribution statement],
) = context {
  let info = cas-info.get()
  let credited = info.authors.filter(a => a.at("credit", default: none) != none)
  if credited.len() > 0 {
    heading(numbering: none, outlined: false, title)
    if info.blind { v(10mm) } else {
      credited.map(a => [*#full-name(a):* #a.credit]).join(". ") + [.]
    }
  }
}

// Biographies --------------------------------------------------------------

/// An author biography (`\bio ... \endbio`), with an optional photo that is
/// set 25.5mm wide to the left of the text. Hidden for double-blind review.
///
/// ```typ
/// #bio[Biography without photo.]
/// #bio(image("photo.jpg"))[Biography with photo.]
/// ```
#let bio(..args) = context {
  let pos = args.pos()
  assert(pos.len() in (1, 2), message: "bio takes an optional photo and a body")
  let body = pos.last()
  let photo = if pos.len() == 2 { pos.first() }
  assert(
    type(photo) != str,
    message: "pass the photo as `image(\"...\")`, not as a path string",
  )
  if not cas-info.get().blind {
    // \casbiographyfont
    with-size((8pt, 10pt), {
      set par(first-line-indent: 0pt)
      if photo == none {
        block(above: 6.4pt, below: 6.4pt, body)
      } else {
        block(above: 20.7pt, below: 20.7pt, grid(
          columns: (25.5mm, 1fr),
          column-gutter: 5pt,
          {
            set image(width: 25.5mm)
            photo
          },
          body,
        ))
      }
    })
  }
}
