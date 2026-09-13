# conjoint-product-design-analytics
# Product Design Analytics: Conjoint Analysis & Perceptual Mapping

MSc Marketing Analytics, Assignment 2, Queen's Business School. Uses conjoint analysis to
understand which product attributes customers value most, and perceptual mapping to see
how competing products/brands are positioned in customers' minds.

**Portfolio angle:** Education/Academic-Research — Reporting Analyst. This is the most
visual, dashboard-driven project in the portfolio — a good one to screenshot.

## Problem

Product teams need to know which attributes actually drive preference (not just which
attributes customers say they like), and how their product is perceived relative to
competitors.

## Approach

- Conjoint analysis to estimate part-worth utilities for each product attribute
- Attribute-importance measures, in both raw and percentage form
- Principal Component Analysis (PCA) to reduce and interpret perception data
- Perceptual mapping to visualise brand/product positioning
- Interactive Tableau dashboards for both the conjoint results and the perceptual map

## Tools

R (conjoint/PCA analysis), Tableau

## Files in this repo

- `report/Assignment-2-Report.pdf` — full write-up
- `code/conjoint-analysis.R` — conjoint analysis script
- `code/pca-analysis.R` — PCA script
- `dashboards/Perceptual-Mapping.twb` — Tableau workbook
- `dashboards/Analysis-on-Partsworth.twb` — Tableau workbook
- `dashboards/screenshots/` — PNG exports of both dashboards, for anyone browsing without Tableau
- `data/` — assignment datasets

## Reproducing this

Open the `.twb` files in Tableau Public/Desktop, or run the R scripts directly.
If you don't have Tableau, the `dashboards/screenshots/` folder shows the same output.
