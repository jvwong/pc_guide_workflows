# Pathway Enrichment Workflow

## Overview

This repository is part of the [Pathway Commons Guide](http://pathwaycommons.github.io/guide/). It contains code relevant to the [Pathway Enrichment - Custom](http://pathwaycommons.github.io/guide/workflows/pathway_enrichment_custom/index/) workflow.

In practical terms, this repository provides a web app that can be run inside of R Studio. The app walks a user through the steps required to 'upload' RNA Sequencing metadata and data then automatically generates all the required files for a [Gene Set Enrichment Analysis](http://pathwaycommons.github.io/guide/workflows/pathway_enrichment_gdc/identify_pathways/) and visualizing these results via an [Enrichment Map](http://apps.cytoscape.org/apps/enrichmentmap).


#### Technical Details

The repository provides the necessary code to source and run a [Docker container](https://hub.docker.com/r/jvwong/pc_guide_rstudio/) preloaded with a in-browser version of [RStudio](https://hub.docker.com/r/rocker/rstudio/) containing the necessary [Bioconductor](https://www.bioconductor.org/) dependencies. Data files produced will be saved to your computer.

---

## Getting started

### Descriptions

- `scripts`: R code
- `output`: Files saved during the course of the R code
