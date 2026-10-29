# Covariate adjustment hackathon repository

This repository contains the R environment and the exercises for the hackathon. It is structured as follows:

```text
.
├── setup-r.R       # installs the required R packages
├── renv.lock       # pinned package versions
├── renv/           # renv infrastructure (activated via .Rprofile)
└── exercises/      # exercise sheets (Quarto documents)
    └── solutions/  # solutions (uploaded later)
```

## R setup

The setup assumes that you work on RStudio Workbench (bifrost) and expects R 4.4.1, the version available there.

Run `setup-r.R` from the repository root. It installs the packages pinned in `renv.lock` and, at the end, prints the installed versions of `targeted`  and `lava`.

> **Note:** Installation can take a while. Please make sure that everything is set up and running before the hackathon.

## Exercises

The exercise sheets are in `exercises/`. Solutions will be uploaded to `exercises/solutions/`.
