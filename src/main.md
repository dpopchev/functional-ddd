---
title: Functional Domain Driven Design
subtitle: what I should have known from the start
author: Dimitar Popchev
institute: GlobalFoundries
# titlegraphic: img/aleph0.png
# logo: img/aleph0-small.png
date: \today
theme: metropolis
colortheme: dolphin
fonttheme: structurebold
fontsize: 8pt
fontfamilyoptions: default
section-titles: false
toc: true
aspectratio: 169
slide-level: 2
output:
    beamer_presentation:
        variant: markdown_strict+pipe_tables+backtick_code_blocks+auto_identifiers+strikeout+yaml_metadata_block+implicit_figures+all_symbols_escapable+link_attributes+smart+fenced_divs
dpi: 300
listings: true
pdf-engine-opt: -shell-escape
header-includes:
    - \usepackage{minted}
#   - \AtBeginSection[] { \begin{frame}<beamer>{} \tableofcontents[currentsection] \end{frame} }
# https://pandoc.org/lua-filters.html#pandoc.cli.default_options
---

# Functional Domain Driven Design

@include: functional-domain-driven-design.md

# Exponential Data Demand

@include: exponential-data-demand.md

# Domain Driven Design

@include: domain-driven-design.md

# Command Query Responsibility Segregation

@include: command-query-responsibility-segregation.md

# Type Hinting

@include: type-hinting.md

# Take away

## Take away

- **Enable** domain experts involvement using Domain Driven Design techniques
- Improve your codebase adopting type hinting
- Be critical where things belong
- Use this presentation as a kata to explore your style

## Inspiration

- [Domain Modeling Made Functional](https://pragprog.com/titles/swdddf/domain-modeling-made-functional/)
- [Robust Python](https://www.oreilly.com/library/view/robust-python/9781098100650/)
- [Cosmic Python](https://www.cosmicpython.com/)
- [Implementing Domain Drivend Design](https://www.amazon.com/Implementing-Domain-Driven-Design-Vaughn-Vernon/dp/0321834577)
- [Domain-Driven Design Distilled](https://www.amazon.com/Domain-Driven-Design-Distilled-Vaughn-Vernon/dp/0134434420)
- [Learning Domain-Driven Design: Aligning Software Architecture and Business Strategy](https://www.amazon.com/Learning-Domain-Driven-Design-Aligning-Architecture/dp/1098100131)

## Simple Functional Domain Driven Design project structure

```
src/gravityml/
    gravity/commands.py     ; parameters to change an aggregate
            events.py       ; messages for aggregate change
            model.py        ; Point, Solution, append_point
            handlers.py     ; handle_append_point
            interfaces.py   ; type hints and other interfaces
    machine_learning/       ; the ML domain
    application.py          ; where domain coupling happens,
    views.py                ; read model of the domains
```

## Thank you!

QA
