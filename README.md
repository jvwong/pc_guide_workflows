# Pathway Commons Guide: Workflows

## Overview

This repository is part of the [Pathway Commons Guide](http://pathwaycommons.github.io/guide/). It contains code that support several  [workflows](http://pathwaycommons.github.io/guide/workflows/index/) for biological pathway analysis described in the Guide.

## Available workflows

1. [Pathway Enrichment - Custom](http://pathwaycommons.github.io/guide/workflows/pathway_enrichment_custom/index/)
  - Use your own RNA sequencing data generated from your custom experimental design
2. [Pathway Enrichment - GDC](http://pathwaycommons.github.io/guide/workflows/pathway_enrichment_gdc/index/)
  - Use provided RNA sequencing data provided by a large cancer genome database (Genomic Data Commons).

---

## Software requirements

- [Docker](https://docs.docker.com/engine/installation/): version > 1.12.3

---

## Getting started

### Descriptions

- `docker-compose.yml`: Runs the RStudio container and links to the contents of `src`

### Running the container

1. Get this repository

  ```shell
  $ git clone https://github.com/jvwong/pc_guide_workflows.git
  ```

2. Run

  a. With Compose

    ```shell
    $ cd pc_guide_workflows
    $ docker-compose up
    ```

  b. Without Compose

    ```shell
    $ docker run --rm --tty --volume "$(pwd)/src:/home/pc_workflows" --publish 8787:8787 jvwong/pc_guide_workflows
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
