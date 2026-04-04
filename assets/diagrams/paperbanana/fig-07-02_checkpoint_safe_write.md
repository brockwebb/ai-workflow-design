# fig-07-02: Transaction-Safe Checkpoint Write Pattern

## Diagram Type
Sequential flow diagram with crash failure branches. NOT an architecture diagram. Linear happy path left-to-right. Crash outcome branches drop downward. Engineering pattern diagram showing safety guarantees.

## Layout
Top row: happy path left-to-right across 4 steps.
Below steps 2 and 3: dashed downward arrows to crash outcome boxes.
Bottom: annotation summarizing the safety guarantee.

## Elements

### Happy Path (left to right)

1. Box: "New checkpoint data ready"
   Arrow right →

2. Box: "Write to checkpoint.tmp"
   Small text: "temporary file"
   Arrow right →

3. Box: "Atomic rename: checkpoint.tmp → checkpoint.json"
   Small text: "single OS operation"
   Arrow right →

4. Box: "checkpoint.json updated"
   Small text: "success"
   Distinct fill (light green) to indicate completion

### Crash Branch — During Write (below step 2)
Dashed downward arrow →
Outcome box: "Crash during write"
Small text: "checkpoint.tmp is partial or missing. checkpoint.json is the last valid checkpoint. Resume is safe."
Fill: light amber (#FFF3CD)

### Crash Branch — During Rename (below step 3)
Dashed downward arrow →
Outcome box: "Crash during rename"
Small text: "Rename is atomic on POSIX systems. checkpoint.json is either old or new — never partial."
Fill: light amber (#FFF3CD)

### Bottom Annotation
Separator line.
Text: "Never write directly to checkpoint.json. A crash during a direct write leaves a partial, unreadable file."
Style: caption-weight italic, medium gray (#666666)

## Visual Style
- Engineering flow diagram — rectangular boxes, clean arrows
- Happy path boxes: white (#FFFFFF) fill, dark gray (#333333) outline
- Success box (step 4): light green (#F0FFF0) fill
- Crash outcome boxes: light amber (#FFF3CD) fill, amber outline (#D9A000)
- Happy path arrows: solid dark gray (#333333)
- Crash branch arrows: dashed, medium gray (#888888)
- No icons, no decorative elements
- Sans-serif font throughout
- Generous whitespace between rows

## Dimensions
- Landscape orientation, roughly 3:1 aspect ratio (wide, relatively short)
- Full page width

## What This Is NOT
- Not a sequence diagram with actors
- Not a state machine diagram
- Crash boxes show outcomes (safety guarantees), not error handling code
- Do not show OS-level implementation details beyond "atomic rename"

## Caption
"Transaction-safe checkpoint write pattern. Writing to a temp file and atomically renaming prevents checkpoint corruption on crash. A crash during the write phase leaves the old checkpoint intact. A crash during the rename (atomic on POSIX systems) leaves either the old or new checkpoint intact, never a partial file."
