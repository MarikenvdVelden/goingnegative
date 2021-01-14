# When the cat’s away, the mice will play. How journalistic control influences political parties' decision to go negative

Data &amp; Analysis Compendium for the When the cat’s away, the mice will play. How journalistic control influences political parties' decision to go negative paper. 
No ethical approval was required for this study.

## Draft
View the [draft of the paper here](report/draft.pdf).

## Code
The main analysis code is located in the [src/data-processing](src/data-processing/README.md). 
Of interest might be:

* [prep_data.Rmd](src/data-processing/prep_data.md) Combine manually annotated data with CHES, Manifesto Project, Polling Data, and data from [KiesKompas](https://www.kieskompas.nl/en/) 

## Data

The following data files might be of interest:

* [coded-data-NL-2017-campaign.csv](data/raw/coded-data-NL-2017-campaign.csv)
* [cleaned_data.RData](data/intermediate/cleaned_data.RData) 
* [data/intermediate/Subset_data_intercoder_reliability.xlsx](data/intermediate/data/intermediate/Subset_data_intercoder_reliability.xlsx)

See the files in [src/data-processing](src/data-processing/README.md) for details on how these files were constructed.

## Results as presented in the paper

* [Performance, learning curve, correlations](src/analysis/performance.md)

## Supplementary Results

* [Confusion Matrices of all methods](src/analysis/confusion_matrix.md)
* [Grid Search for CNN](src/analysis/cnn_gridsearch.md) (code: [30_cnn_gridsearch.py](src/data-processing/30_cnn_gridsearch.py)
* [Grid Search for SVM](src/analysis/svm_gridsearch.md) (code: [19_svm_gridsearch.py](src/data-processing/19_svm_gridsearch.py)
* [Validation of ML results against student codings](src/analysis/ml_versus_students.md)
* [Error analysis](src/analysis/error_analysis.md)
