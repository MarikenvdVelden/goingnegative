# When the cat’s away, the mice will play. How journalistic control influences political parties' decision to go negative

Data &amp; Analysis Compendium for the _When the cat’s away, the mice will play. How journalistic control influences political parties' decision to go negative_ paper. 
No ethical approval was required for this study.

## Draft
View the [draft of the paper here](report/draft.pdf).

## Code
The main analysis code is located in the [src/data-processing](src/data-processing/). 
Of interest might be:

* [Prepare Data](src/data-processing/prep_data.md) This file combines manually annotated data with CHES, Manifesto Project, Polling Data, and data from [KiesKompas](https://www.kieskompas.nl/en/) and creates the variables for the analysis.

## Data

The following data files might be of interest:

* [coded-data-NL-2017-campaign.csv](data/raw/coded-data-NL-2017-campaign.csv) Manually coded data by first author
* [data/intermediate/Subset_data_intercoder_reliability.xlsx](data/intermediate/data/intermediate/Subset_data_intercoder_reliability.xlsx) Gold standard expert coding 
* [cleaned_data.RData](data/intermediate/cleaned_data.RData) Data cleaned for the analyses

See [src/data-processing/prep_data.md](src/data-processing/prep_data.md) for details on how these files were constructed.

## Results as presented in the paper

* [Code](src/analysis/analysis.md) to conduct the multiverse analyses
* [Figures](report/figures) visualizing the descriptives and the results of the analyses 

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to
abide by its terms.