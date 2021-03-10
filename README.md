# When the Cat’s Away, the Mice will Play? How Journalistic Intervention Influences Political Parties' Decision to Go Negative

Data &amp; Analysis Compendium for the _When the Cat’s Away, the Mice will Play? How Journalistic Intervention Influences Political Parties' Decision to Go Negative_ paper. 
No ethical approval was required for this study.

## Draft
View the [draft of the paper here](report/draft.pdf).

## Code
The main code to prepare the data is located in the [src/data-processing](src/data-processing/). 
Of interest might be:

* [Prepare Data](src/data-processing/prep_data.md) This file combines manually annotated data with [CHES](https://www.chesdata.eu/), [Manifesto Project](https://manifesto-project.wzb.eu/), [polling data](https://nl.wikipedia.org/wiki/Tweede_Kamerverkiezingen_2017/Peilingen), and data from [KiesKompas](https://www.kieskompas.nl/en/) and creates the variables for the [analysis](src/analysis/analysis.md).

## Data

The following data files might be of interest:

* [coded-data-NL-2017-campaign.csv](data/raw/coded-data-NL-2017-campaign.csv) Manually coded data by first author
* [data/intermediate/Subset_data_intercoder_reliability.xlsx](data/intermediate/data/intermediate/Subset_data_intercoder_reliability.xlsx) Gold standard expert coding 
* [cleaned_data.RData](data/intermediate/cleaned_data.RData) Data cleaned for the analyses
* [table_descriptives.md](report/figures/table_descriptives.md) Descriptive information of the variables under study

## Results

The main code to conduct the multiverse analyses is combined in the [src/analysis/analysis.md](src/analysis/analysis.md). 
Of interest might be:
* [Code](src/analysis/) to conduct the seperate multiverse analyses
* [Figures](report/figures) visualizing the descriptives and the results of the analyses 

## Replication 

To run all scripts, call [`doit`](https://github.com/ccs-amsterdam/ccs-compendium) in your command line:

```
sudo pip3 install doit
doit
```

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to
abide by its terms.