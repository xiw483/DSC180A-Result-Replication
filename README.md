# DSC180A-Result-Replication
This project follows the structure of the work by Professor Armin Schwartzman. We aim to find out if multiple testing with empirical null will improve the results than with theoretical null. We will use the false discovery rate as a treshold. 
- To access the data, enter in command line: Rscript run-data.R data
- To run the analysis code, enter: Rscript run-data.R dataanalysis. This will generate multiple graphs in data/out folder.
- data: contains raw data and data output.
- src: contains source code for data loading and data analysis.
- config: contains configuration for parameter setups.
- reference: contains external references.
- notebook: contains reports.
- run-data.R: data ingestion pipeline.


### Responsibilities
- Raymond Wang developed the ingestion pipeline "run-data.r" and adapted the analysis codes "MoothaAnalysis" from the demonstration during discussion sections.
- Jacob Benson developed part of the ingestion pipeline.
