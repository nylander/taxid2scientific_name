# README.md

- Last modified: mån jan 22, 2024  10:56
- Sign: nylander

## Description

Build sif

    $ sudo apptainer build edirect.sif edirect.def

Make symlinks. Note that not all programs provided by ediredt are linked!

    $ mkdir -p ../bin
    $ cd ../bin
    $ for p in esearch elink efilter efetch esummary einfo nquire transmute xtract ; do
        ln -s ../singularity/edirect.sif "$p"
      done
    $ ln -s ../singularity/edirect.sif taxid2sci
    $ ln -s ../singularity/edirect.sif sci2taxid

