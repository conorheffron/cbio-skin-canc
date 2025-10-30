# cbio-skin-canc

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

![Proof HTML](https://github.com/conorheffron/cbio-skin-canc/actions/workflows/proof-html.yml/badge.svg)

### Summary

- The dataset I have selected for this assignment is from the CBio Portal for Cancer Genomics website.
- The full data set is in tar / gzip format that can be downloaded directly from https://www.cbioportal.org/study/summary?id=mel_mskimpact_2020.
- I will focus on the clinical data files (data_clinical_patient.txt, data_clinical_sample.txt, and data_mutations.txt), primarily the clinical patient file. These are tab delimited plain text files that can be accessed after the tar is decompressed.
- There is a mix of categorical (factors), continuous and numerical features (some to be inferred by R code).
- This data represents the targeted sequencing (MSK-IMPACT) of 696 melanoma tumour / normal pairs.
- There is a corresponding published medical journal entitled “Therapeutic Implications of Detecting MAPK-Activating Alterations in Cutaneous and Unknown Primary Melanomas”.

**Run All Code Chunks in _`final-project-report.qmd`_ from RStudio project & render to HTML or PDF**

- See skin cancer dataset analysis in **Full HTML report** format at: [Full Report](https://conorheffron.github.io/cbio-skin-canc/final-project-report.html)
