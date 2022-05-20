# nanoporeRunSVAnalysis

nanoporeRunSVAnalysis, workflow that generates structural variant files from input of nanopore fastq files, a wrapper of the workflow https://github.com/mike-molnar/nanopore-SV-analysis

## Overview

## Dependencies

* [nanopore_sv_analysis 20220505](https://gitlab.oicr.on.ca/ResearchIT/modulator/-/blob/master/code/gsi/70_nanopore_sv_analysis.yaml)


## Usage

### Cromwell
```
java -jar cromwell.jar run nanoporeRunSVAnalysis.wdl --inputs inputs.json
```

### Inputs

#### Required workflow parameters:
Parameter|Value|Description
---|---|---
`sample`|String|name of all samples
`normal`|String|name of the normal samples
`tumor`|String|name of the tumor samples
`samplefile`|String|sample file
`smkConfig.generateConfig_modules`|String|modules needed to run generateConfig
`runSVAnalysis.modules`|String|Names and versions of modules


#### Optional workflow parameters:
Parameter|Value|Default|Description
---|---|---|---


#### Optional task parameters:
Parameter|Value|Default|Description
---|---|---|---
`smkConfig.generateConfig.jobMemory`|Int|8|memory allocated for Job
`smkConfig.generateConfig.timeout`|Int|24|Timeout in hours, needed to override imposed limits
`runSVAnalysis.jobMemory`|Int|8|memory allocated for Job
`runSVAnalysis.timeout`|Int|24|Timeout in hours, needed to override imposed limits


### Outputs

Output | Type | Description
---|---|---
`insertions`|File|output from rule run_SV_analysis of the original workflow
`deletions`|File|output from rule run_SV_analysis of the original workflow
`duplications`|File|output from rule run_SV_analysis of the original workflow
`inversions`|File|output from rule run_SV_analysis of the original workflow
`translocations`|File|output from rule run_SV_analysis of the original workflow
`CNVs`|File|output from rule run_SV_analysis of the original workflow

