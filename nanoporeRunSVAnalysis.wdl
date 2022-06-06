version 1.0
import "imports/pull_smkConfig.wdl" as smkConfig

workflow nanoporeRunSVAnalysis {
    input {
        String sample
        String normal
        String tumor
        File samplefile  
    }
    parameter_meta {
        sample: "name of all samples"
        normal: "name of the normal samples"
        tumor: "name of the tumor samples"
        samplefile: "sample file"
    }

    call smkConfig.smkConfig{
        input:
        sample = sample,
        normal = normal,
        tumor = tumor,
        samplefile = samplefile    
    }

    call runSVAnalysis {
        input:
        config = smkConfig.config,
        sample=sample
    }

    output {
      File insertions = runSVAnalysis.insertions
      File deletions = runSVAnalysis.deletions 
      File duplications = runSVAnalysis.duplications
      File inversions = runSVAnalysis.inversions
      File translocations = runSVAnalysis.translocations
      File CNVs = runSVAnalysis.CNVs
        }

    meta {
     author: "Gavin Peng"
     email: "gpeng@oicr.on.ca"
     description: "nanoporeRunSVAnalysis, workflow that generates structural variant files from input of nanopore fastq files, a wrapper of the workflow https://github.com/mike-molnar/nanopore-SV-analysis"
     dependencies: [
      {
        name: "nanopore_sv_analysis/20220505",
        url: "https://gitlab.oicr.on.ca/ResearchIT/modulator/-/blob/master/code/gsi/70_nanopore_sv_analysis.yaml"
      }
     ]
     output_meta: {
       insertions: "output from rule run_SV_analysis of the original workflow",
       deletions: "output from rule run_SV_analysis of the original workflow", 
       duplications: "output from rule run_SV_analysis of the original workflow", 
       inversions: "output from rule run_SV_analysis of the original workflow", 
       translocations: "output from rule run_SV_analysis of the original workflow", 
       CNVs: "output from rule run_SV_analysis of the original workflow" 
     }
    }
}

    # ==========================================================
    # run the nanopore workflow for structural variant analysis
    # ==========================================================
    task runSVAnalysis {
        input {
        String sample
        File config   
        String modules
        Int jobMemory = 8
        Int timeout = 24
        }

        parameter_meta {
        sample: "name of the sample"
        jobMemory: "memory allocated for Job"
        modules: "Names and versions of modules"
        timeout: "Timeout in hours, needed to override imposed limits"
        }

        command <<<
        set -euo pipefail
        module load nanopore-sv-analysis
        unset LD_LIBRARY_PATH
        cp $NANOPORE_SV_ANALYSIS_ROOT/Snakefile .
        cp ~{config} .
        $NANOPORE_SV_ANALYSIS_ROOT/bin/snakemake --jobs 16 --rerun-incomplete --keep-going --latency-wait 60 --cluster "qsub -cwd -V -o snakemake.output.log -e snakemake.error.log  -P gsi -pe smp {threads} -l h_vmem={params.memory_per_thread} -l h_rt={params.run_time} -b y "  run_SV_analysis
        >>> 

    runtime {
    memory:  "~{jobMemory} GB"
    modules: "~{modules}"
    timeout: "~{timeout}"
    }

    output {
    File insertions = "~{sample}/analysis/structural_variants/~{sample}.insertions.bed"
    File deletions = "~{sample}/analysis/structural_variants/~{sample}.deletions.bed"
    File duplications = "~{sample}/analysis/structural_variants/~{sample}.duplications.bed"
    File inversions = "~{sample}/analysis/structural_variants/~{sample}.inversions.bed"
    File translocations = "~{sample}/analysis/structural_variants/~{sample}.translocations.bedpe"
    File CNVs = "~{sample}/analysis/structural_variants/~{sample}.CNVs.bed"
    }
    }
