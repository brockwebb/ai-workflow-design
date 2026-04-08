// Running headers: show current chapter title in page header
// Suppress on pages where a new chapter (level-1 heading) starts
#set page(
  header: context {
    // Check if a level-1 heading starts on this page — if so, suppress header
    let page_headings = query(heading.where(level: 1))
    let dominated = false
    for h in page_headings {
      if counter(page).at(h.location()) == counter(page).at(here()) {
        dominated = true
      }
    }
    if dominated {
      // Chapter opening page: no running header, just page number
      h(1fr)
      set text(size: 9pt)
      counter(page).display()
    } else {
      let elems = query(heading.where(level: 1).before(here()))
      if elems.len() > 0 {
        let current = elems.last()
        set text(size: 9pt, style: "italic")
        current.body
        h(1fr)
        counter(page).display()
      }
    }
  },
  footer: [],
)

// Table styling: left-align cell text (prevents grotesque justified spacing
// in narrow columns) and clean up borders
#show table.cell: set par(justify: false)
#show table: set table(
  inset: 8pt,
  stroke: 0.5pt + luma(180),
)

// Center code blocks on the page (monospace output tables, etc.)
#show raw.where(block: true): set align(center)

// Style chapter headings (level 1) with pagebreak
// CRITICAL: use `set` + return `it` to preserve heading identity for #outline()
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(2em)
  block[
    #set text(size: 24pt, weight: "bold")
    #it
  ]
  v(1em)
}

// Keep admonition/blockquote boxes together across page breaks
// Pandoc renders MyST admonitions ({tip}, {note}, etc.) as #quote(block: true)
// No admonition exceeds 40 lines, so breakable: false is safe here
#show quote.where(block: true): set block(breakable: false)

// Prevent orphaned headings (heading stranded at bottom of page with no following content)
#show heading: set block(below: 1.5em, above: 2em, breakable: false)

// Style level 2 headings
#show heading.where(level: 2): it => {
  v(1.5em)
  block[
    #set text(size: 16pt, weight: "bold")
    #it
  ]
  v(0.5em)
}
