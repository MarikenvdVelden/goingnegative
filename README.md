# When the Cat’s Away, the Mice will Play? How Journalistic Intervention Influences Political Parties' Decision to Go Negative

Data &amp; Analysis Compendium for the _When the Cat’s Away, the Mice will Play? How Journalistic Intervention Influences Political Parties' Decision to Go Negative_ paper. 
No ethical approval was required for this study.

## Draft
View the [draft of the paper here](report/draft.pdf).

## Code
The main analysis code is located in the [src/data-processing](src/data-processing/). 
Of interest might be:

* [Prepare Data](src/data-processing/prep_data.md) This file combines manually annotated data with CHES, Manifesto Project, Polling Data, and data from [KiesKompas](https://www.kieskompas.nl/en/) and creates the variables for the [analysis](src/analysis/analysis.md).

## Data

The following data files might be of interest:

* [coded-data-NL-2017-campaign.csv](data/raw/coded-data-NL-2017-campaign.csv) Manually coded data by first author
* [data/intermediate/Subset_data_intercoder_reliability.xlsx](data/intermediate/data/intermediate/Subset_data_intercoder_reliability.xlsx) Gold standard expert coding 
* [cleaned_data.RData](data/intermediate/cleaned_data.RData) Data cleaned for the analyses
* [table_descriptives.md](report/figures/table_descriptives.md) Descriptive information of the variables under study


## Results

* [Code](src/analysis/analysis.md) to conduct the multiverse analyses
* [Figures](report/figures) visualizing the descriptives and the results of the analyses 

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to
abide by its terms.