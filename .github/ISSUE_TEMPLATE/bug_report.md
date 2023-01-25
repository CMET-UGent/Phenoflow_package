---
name: Bug report
about: Create a report to help us improve
title: "[User reported bug]"
labels: triage
assignees: ''

---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**

Please tell us (step-by-step) how to reproduce the error on our side. The good folks at posit/tidyverse have made a package that can help you to generate a reproducible example (a.k.a. "reprex"): https://reprex.tidyverse.org/ , please leverage it while reporting an issue.

If your dataset (flowSet) is too big - consider using `FCS_resample` to downsample it - or (preferably) try to reproduce your issue with one of the builtin flowSets (`data(package="Phenoflow")`

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

** R/Rstudio Desktop (please complete the following information):**
 - OS: [e.g. Windows 10, Ubuntu 20.04]
 - R version: [e.g. 4.2.1]
 - Bioconductor version: [e.g. 3.16]
 - Used IDE and version: [e.g. Rstudio Cherry Blossom]
 - Other output of `sessionInfo()`
 - if you use [renv](https://rstudio.github.io/renv/index.html) the renv.lock file 

**Rstudio server/Posit Workbench (please complete the following information):**
 - OS (if known): [e.g. Windows 10, Ubuntu 20.04]
 - Browser: [e.g. firefox]
 - R version: [e.g. 4.2.1]
 - Bioconductor version: [e.g. 3.16]
 - Used IDE and version: [e.g. Rstudio Cherry Blossom]
 - Other output of `sessionInfo()`
 - if you use [renv](https://rstudio.github.io/renv/index.html) the renv.lock file 

**Additional context**
Add any other context about the problem here.
