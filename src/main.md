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
# fontfamily:
# mainfont:
# sansfont:
# monofont:
# mathfont:
# urlcolor: red
# linkstyle: bold
# lang: en-US
section-titles: true
toc: true
aspectratio: 169
# slide-level: 2
output: beamer_presentation
header-includes:
    - \usepackage{minted}
#   - \AtBeginSection[] { \begin{frame}<beamer>{} \tableofcontents[currentsection] \end{frame} }
---

# Section with two slides

## Slide 1.1

```python
def hello_word():
    return "Hello word"
```

## Slide 1.2

Some content

# Section with one slide

## Slide 2.2

Content of another section

# Section with several slides

@include: fff.md

# Section without slides

# Section with one slide

## Thank you


# This program adds two numbers

## aslide

```python
num1 = 1.5
num2 = 6.3
```

# Add two numbers

## aslide

```python
sum = num1 + num2
```

# Display the sum

## aslide

```python
print('The sum of {0} and {1} is {2}'.format(num1, num2, sum))
```
