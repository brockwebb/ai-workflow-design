# fig-07-03: Config Validation Flow

## Diagram Type
Top-to-bottom flowchart with a binary gate at the end. Sequential validation steps with a final pass/fail decision. Engineering process diagram.

## Layout
Vertical flow from top to bottom. Each step is a rectangle. Final step splits into two branches: Pass (right, proceed) and Fail (left, stop).

## Elements

### Steps (top to bottom)

1. Box: "Load configuration file"
   Small text: "model name, endpoint, parameters, batch size"
   Arrow down →

2. Box: "Validate model name"
   Small text: "confirm model exists at provider; flag if deprecated or unknown"
   Arrow down →

3. Box: "Validate parameters"
   Small text: "confirm parameters accepted by target model; flag unknowns"
   Arrow down →

4. Box: "Run smoke test"
   Small text: "10 items; verify API responds, output format matches expected schema"
   Arrow down →

5. Box: "Compare output schema"
   Small text: "validate structured output fields against expected contract"
   Arrow down →

6. Diamond decision: "All checks pass?"

### Pass Branch (right from diamond)
Arrow right, labeled "Yes" →
Box: "Proceed to full run"
Fill: light green (#F0FFF0)

### Fail Branch (left from diamond)
Arrow left, labeled "No" →
Box: "Stop and alert"
Small text: "log which check failed; do not launch full run"
Fill: light amber (#FFF3CD)

## Visual Style
- Clean top-down flowchart — rectangles for steps, diamond for decision
- Step boxes: white (#FFFFFF) fill, dark gray (#333333) outline
- Decision diamond: white fill, dark gray outline
- Pass box: light green (#F0FFF0)
- Fail box: light amber (#FFF3CD), amber outline
- Arrows: solid dark gray (#333333)
- Yes/No labels on decision branches
- No decorative elements, no icons
- Sans-serif font throughout

## Dimensions
- Portrait orientation — vertical flow suits a tall-and-narrow layout
- Half page width acceptable (does not need full width)

## What This Is NOT
- Not a deployment diagram
- Not a test framework diagram
- The smoke test (step 4) is pipeline validation, not software unit testing
- No vendor logos, no specific tool names

## Caption
"Config validation flow before full pipeline launch. Each check gates the next. A failed model name, unaccepted parameter, or failed smoke test stops the run before it processes 50,000 records on bad configuration. The cost of the smoke test is minutes; the cost of discovering a config error at record 40,000 is hours."
