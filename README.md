# Table View Index

*The alphabetical scrubber down the side of a sectioned list.*

![Swift](https://img.shields.io/badge/Swift-5.0-F05138?style=flat-square&logo=swift&logoColor=white) ![UIKit](https://img.shields.io/badge/UIKit-2396F3?style=flat-square&logo=uikit&logoColor=white) ![iOS](https://img.shields.io/badge/iOS-17.5%2B-000000?style=flat-square&logo=apple&logoColor=white) ![Topic](https://img.shields.io/badge/topic-sectioned%20data-6366F1?style=flat-square) ![Dependencies](https://img.shields.io/badge/dependencies-none-16A34A?style=flat-square)

## Overview

The index strip used by Contacts. Two data source methods provide it, but they only work if the underlying data is genuinely grouped by first letter, which is the part that has to be built.

## How it works

```mermaid
flowchart TD
    FLAT["flat array of names"] --> GROUP["group by first letter"]
    GROUP --> MODEL["[Group]<br/>letter and its members"]
    MODEL --> NS["numberOfSections"]
    MODEL --> NR["numberOfRowsInSection"]
    MODEL --> TH["titleForHeaderInSection<br/>the section letter"]
    MODEL --> SI["sectionIndexTitles(for:)<br/>the scrubber contents"]
    SI --> JUMP["tapping a letter scrolls to that section"]
```

## Implementation notes

- **The index mirrors the sections.** `sectionIndexTitles` must line up with the section order, otherwise a tap scrolls to the wrong place.
- **Grouping happens once.** The array is transformed into a `Group` model at setup rather than being filtered inside the data source methods, which would run on every cell.
- **Letters without entries are skipped.** Only letters that actually have members become sections, so the list has no empty headers.
- **Headers and index share a source.** Both read from the same model, so they cannot disagree.

## Project structure

```
TableViewIndex/
└── ViewController.swift   Group model, data source and index
```

## Requirements

Xcode 15 or later, iOS 17.5 or later. No external dependencies.
