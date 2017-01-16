# Pathway Enrichment Workflow

## Overview

This repository is part of the [Pathway Commons Guide](http://pathwaycommons.github.io/guide/). It contains code relevant to the [Pathway Enrichment - II](http://pathwaycommons.github.io/guide/workflows/pathway_enrichment_ii/index/) workflow.

This repository provides access to a web application that walks a user through the steps required to upload RNA Sequencing metadata and data relevant to a pair-wise comparison, then automatically generates the files required for downstream analysis using [Gene Set Enrichment Analysis](http://pathwaycommons.github.io/guide/workflows/pathway_enrichment_gdc/identify_pathways/) and [Enrichment Map](http://apps.cytoscape.org/apps/enrichmentmap).

---

## Getting started

The web app is packaged in a set of [Docker](https://www.docker.com/) containers. You will be able to upload data and save the results to your local computer. We have provided a set of sample data RNA sequencing data and metadata to get you started.

### Software requirements

- [Docker](https://docs.docker.com/engine/installation/): version > 1.12
- [Docker Compose](https://docs.docker.com/compose/): version > 1.9

### Descriptions

You should see the following directory structure.

```shell
|--- pathway_enrichment_ii
|   |
|   |--- data
|   |    |
|   |    |--- gitr_phenotypes.txt
|   |    |--- SMARTA_GITR_WT_1_htsqct.txt
|   |    |--- SMARTA_GITR_WT_2_htsqct.txt
|   |    |--- SMARTA_GITR_WT_3_htsqct.txt
|   |    |--- SMARTA_GITR_KO_1_htsqct.txt
|   |    |--- SMARTA_GITR_KO_2_htsqct.txt
|   |    |--- SMARTA_GITR_KO_3_htsqct.txt
|   |
|   |--- docker-compose.yml
...
```

- `docker-compose.yml`: Instructs Docker as to what images to pull from the DockerHub and runs the web application
- `/data`
  - `gitr_phenotypes.txt`: The metadata describing the data file names and classes
  - `SMARTA_GITR_xx_y_htsqct.txt`: The RNA sequencing counts for a given class (xx) and biological replicate (y)

### Start

1. Build, create, start, and attach to containers for the webapp service.

  Assuming you have Docker and Docker Compose, open up a terminal and navigate to the directory `pathway_enrichment_ii`.

  ```shell
  $ docker-compose up -d
  ```

2. Point your browser to `localhost:8080`

### Stop

You can stop the app by `$ docker-compose stop` or stop and remove the containers completely by using `$ docker-compose down`.

## Troubleshooting

1. Running Docker through a [virtual machine](https://docs.docker.com/machine/get-started/)

  You can find the IP address by typing `echo $(docker-machine ip machinename)` where 'machinename' is the name of your virtual machine (e.g. 'default').

2. Port conflicts

  Feel free to modify the 'ports' attribute inside the 'webapp' service within  `docker-compose.yml` if you get a port conflict on your machine.

<hr/>
