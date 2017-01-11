# Pathway Enrichment Workflow

## Overview

This repository is part of the [Pathway Commons Guide](http://pathwaycommons.github.io/guide/). It contains code relevant to the [Pathway Enrichment - Custom](http://pathwaycommons.github.io/guide/workflows/pathway_enrichment_custom/index/) workflow.

In practical terms, this repository provides a web app that can be run from inside R Studio. The app walks a user through the steps required to upload RNA Sequencing metadata and data relevant to a pair-wise comparison, then automatically generates all the required files for downstream analysis inclduing [Gene Set Enrichment Analysis](http://pathwaycommons.github.io/guide/workflows/pathway_enrichment_gdc/identify_pathways/) and [Enrichment Map](http://apps.cytoscape.org/apps/enrichmentmap).

---

## Getting started

The repository provides the code requires to source and run a [Docker container](https://hub.docker.com/r/jvwong/pc_guide_rstudio/) preloaded with a in-browser version of [RStudio](https://hub.docker.com/r/rocker/rstudio/) and the necessary [Bioconductor](https://www.bioconductor.org/) dependencies. Data files produced during the session will be saved to your computer, allowing you to use them in subsequent analyses.

### Software requirements

- [Docker](https://docs.docker.com/engine/installation/): version > 1.12.3
- (Optional) [Docker Compose](https://docs.docker.com/compose/): version > 1.9.0

### Descriptions

- `docker-compose.yml`: Runs the RStudio container and links to the contents of `src`

### Running the container

1. Run the app

  a. Using Docker

    ```shell
    $ docker run --rm --tty --volume "$(pwd)/src:/home/pc_workflows" --publish 8787:8787 jvwong/pc_guide_workflows
    ```

  b. Using Docker Compose

  ```shell
  $ cd pc_guide_workflows
  $ docker-compose up
  ```

  > Note: A Docker image will be pulled from the DockerHub. It will be run and link the `src` contents inside the container at `/home/pc_workflows`. This means that changes written to `/home/pc_workflows/` by the R scripts will be available, even after the container exits.

3. Point your browser to `127.0.0.1:8787`

4. Use RStudio!

  The username and password are both `rstudio`. In RStudio, the directories declared in `src` will be avilable at `/home/pc_workflows` (click the `...` button in the Files tab).

  ```shell
  home
  |
  |--- pc_workflows
  |   |
  |   |--- pathway_enrichment_gdc
  |   |    |
  |   |    |--- scripts
  |   |    |--- output
  |   |
  |   |--- src/pathway_enrichment_custom
  |        |
  |        |--- scripts
  |        |--- output
  |
  |--- rstudio
  |   |
  ...
  ```

<hr/>

## References
