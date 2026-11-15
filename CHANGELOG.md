# Changelog

All notable changes to this package are documented here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and the package adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.1.0] - 2026-10-01

First release, published on Typst Universe as `@preview/elsevier-cas-unofficial`.

### Added

- `article` show rule porting Elsevier's `cas-sc` (single column) and `cas-dc` (double column) classes, version 2.4: page geometry, front matter, first-page notes, running heads and body styles.
- Front matter options: authors with affiliations, ORCID and contact links, title and author notes, abstract, keywords, `msc`/`jel`/`pacs` codes, graphical abstract and highlights.
- `blind` (double-blind review), `review` (double line spacing), `long-title`, `fleqn`, `line-numbers`, `logos` and font overrides.
- Project template for `typst init` and `examples/sample.typ`, a port of `cas-dc-sample.tex`.

[Unreleased]: https://github.com/CarloLucibello/elsevier-cas.typ/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/CarloLucibello/elsevier-cas.typ/releases/tag/v0.1.0
