# Pathway Enrichment Workflow

## Overview

This repository is part of the [Pathway Commons Guide](http://pathwaycommons.github.io/guide/). It contains code relevant to the [Pathway Enrichment - Custom](http://pathwaycommons.github.io/guide/workflows/pathway_enrichment_custom/index/) workflow.

In practical terms, this repository provides a web app that can be run inside of R Studio. The app walks a user through the steps required to 'upload' RNA Sequencing metadata and data then automatically generates all the required files for a [Gene Set Enrichment Analysis](http://pathwaycommons.github.io/guide/workflows/pathway_enrichment_gdc/identify_pathways/) and visualizing these results via an [Enrichment Map](http://apps.cytoscape.org/apps/enrichmentmap).


#### Technical Details

The repository provides the necessary code to source and run a [Docker container](https://hub.docker.com/r/jvwong/pc_guide_rstudio/) preloaded with a in-browser version of [RStudio](https://hub.docker.com/r/rocker/rstudio/) containing the necessary [Bioconductor](https://www.bioconductor.org/) dependencies. Data files produced will be saved to your computer.

---

## Software requirements

- [Docker](https://docs.docker.com/engine/installation/): version > 1.12.3

---

## Getting started

### Descriptions

- `src`
  - `scripts`: R code
  - `output`: Files saved during the course of the R code
- `docker-compose.yml`: Runs the RStudio container and links to `src`

### Running the container

1. Get this repository

  ```shell
  $ git clone https://github.com/jvwong/pc_guide_workflows_pathway_enrichment_custom.git
  ```

2. Run

  a. With Compose

    ```shell
    $ cd pc_guide_workflows_pathway_enrichment_custom
    $ docker-compose up
    ```

  b. Without Compose

    ```shell
    $ docker run --rm --tty --volume "$(pwd)/src:/home/TCGA" --publish 8787:8787 jvwong/pc_guide_workflows_pathway_enrichment_custom
    ```

  > Note: A Docker image will be pulled from the DockerHub. It will be run and link the `src` contents inside the container at `/home/TCGA`. This means that changes written to `src/output` by the R scripts will be available, even after the container exits.

3. Point your browser to `127.0.0.1:8787`

4. Use RStudio!

  The username and password are both `rstudio`. In RStudio, the directories declared in `src` will be avilable at `/home/custom` (click the `...` button in the Files tab).

  ```shell
  home
  |
  |--- custom
  |   |
  |   |--- scripts
  |   |    |
  |   |    |--- get_data.R
  |   |
  |   |--- data
  |   |    |
  |   |    |--- Verhaak_JCI_2013_tableS1.txt
  |   |
  |   |--- output
  |
  |--- rstudio
  |   |
  ...
  ```

<hr/>

## References
