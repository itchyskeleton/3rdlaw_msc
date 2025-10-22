<h2>General overview</h2>
This repository contains data and code generated through and used in the analyses for the dissertation titled <b><i>Investigating biological, paleontological and statistical aspects of the third paleobiological law.</i></b>

<h2>Context</h2>

Speciation (or origination) and extinction rates are the ultimate descriptors of any lineage's diversification dynamic. For decades, scientists have been observing that those rates seem to be correlated for different groups of organisms, pointing to many ecological factors as reasons for this pattern - which, with time, became known as the third law of paleobiology, or Stanley's rule. This pattern, however, was based off few datapoints and tested only for supraspecific levels, which may not reflect the actual mechanisms that might influence origination and extinction rates at species level. Concurrently, for extinct levels, and in lesser degree, those that are close to extinction, the correlation between mean speciation and extinction rates is mathematically expected, which urges for a closer look at the different diversification windows that might be present in a lineage's diversification trajectory - namely, diversity expansion, equilibrium, and decline. In this work, we study the Kendall correlations between speciation and extinction rates obtained through [PyRate](https://github.com/dsilvestro/PyRate/) for 18 family-continent datasets comprised of 12 Carnivora families, dividing their diversification trajectories in the aforementioned stages.

<h2>Repository structure</h2>

```
|---data/
    |---occs/
    |---pyrate/
        |---mcmc_logs/
        |---pyrate_RTT_plots/
        |---other_work/
    |---processed/
|---R/
    |---eta/
    |---correlations/
    |---images_scripts/
    |---occs_data_prep/
|---output/
    |---images/
    |---eta/
        |---images/
        |---tables/
    |---correlations/
        |---data/
        |---images/
```

<h3>data</h3>

Raw and processed data used to perform analyses in this study.

<h4>occs</h4>

Occurrences used to run PyRate analyses. Each subfolder corresponds to one family-continent pair (see full list in the table below), and each one contains the following files:

- **PAIR_NAME_data_final_now_&_pbdb.txt:** full list of occurrences for a given family-continent pair, containing species name, status, last fossil occurrence (MinT), and first fossil occurrence (MaxT).
- **PAIR_NAME.png:** visual representation of occurrences per Myr (TPP visualization plots), highlighting the ones that cross through time intervals.
- **epochs.txt:** time intervals for PyRate preservation shifts in Myr, when applicable.


|**Pair code**|**Family**|**Location**|
|-------------|:--------:|:----------:|
|amph_eu|Amphicyonidae|Eurasia|
|amph_na|Amphicyonidae|North America|
|cani_eu|Canidae|Eurasia|
|cani_na|Canidae|North America|
|feli_eu|Felidae|Eurasia|
|feli_na|Felidae|North America|
|herp_eu|Herpestidae|Eurasia|
|hyae_eu|Hyaenidae|Eurasia|
|meph_na|Mephitidae|North America|
|must_eu|Mustelidae|Eurasia|
|must_na|Mustelidae|North America|
|nimr_eu|Nimravidae|Eurasia|
|nimr_na|Nimravidae|North America|
|perc_eu|Percrocutidae|Eurasia|
|proc_na|Procyonidae|North America|
|ursi_eu|Ursidae|Eurasia|
|ursi_na|Ursidae|North America|
|vive_eu|Viverridae|Eurasia|

<h4>pyrate</h4>

Data obtained through PyRate analyses.

<h5>mcmc_logs</h5>

.txt files containing tables with the logs for the MCMC analyses performed by PyRate.

<h5>pyrate_RTT_plots</h5>

R scripts to generate the speciation, extinction and diversification rates, speciation and extinction shifts, and longevity through time plots, created using PyRate function `-plotRJ` and the MCMC logs.

<h5>other_work</h5>

MCMC logs obtained from literature to compose 

<h4>processed</h4>

- **00_eta_prerequisites.RData:** R objects needed to run the function `eta`.
- **corrs_prereqs_CUT_1t.RData:** R objects necessary to run the correlations between speciation and extinction rates, using data divided in time windows using the one threshold method. The different cuts are described in the file names.
- **corrs_prereqs_CUT_2t.RData:** R objects necessary to run the correlations between speciation and extinction rates, using data divided in time windows using the two thresholds method. The different cuts are described in the file names.
- **gillinsky_data.csv:** data obtained from Gillinsky (1994) and used to create Fig. 1 from the dissertation text.
- **mean_rates.RData:** mean speciation and extinction rates, obtained through function `eta.means`.
- **img-intro.RData:** R objects needed to generate Fig. 2 of the manuscript.


<h3>R</h3>

<h4>eta</h4>
Scripts used to generate `eta` analyses for all family-continent pairs, using the one threshold or two thresholds methods and different `cuts` (see dissertation text for more information).

- **00_eta_function.R:** function `eta`, used to divide the family-continent pairs' diversification dynamics into time windows.
- **01_eta_analysis_CUT_2t.R:** `eta` analyses performed using the two thresholds method and different cuts, informed in the file names.
- **02_eta_analysis_CUT_1t.R:** `eta` analyses performed using the one threshold method and different cuts, informed in the file names.

<h4>correlations</h4>
Scripts for the Kendall correlations between speciation and extinction rates.

- **01_correlations_CUT_2t.R:** correlation analyses ran with data divided in time windows using the `eta` function with the two thresholds method and different cuts, informed in the file names.
- **02_correlations_CUT_1t.R:** correlation analyses ran with data divided in time windows using the `eta` function with the one threshold method and different cuts, informed in the file names.
- **03_correlations_nowindows.R:** correlations without dividing the diversification dynamics in time windows.

<h4>images_scripts</h4>
Scripts to generate images contained in the dissertation text.

- **gillinsky-img.R:** R script to generate Fig. 1 of the manuscript.
- **intro-img.R:** R script to generate Fig. 2 of the manuscript.
- **img-zliobate.R:** R script to generate Fig. 4 of the manuscript.
- **eta_explanation.R:** R script to generate Fig. 5 of the manuscript.
- **example_diversification.R:** artificial diversification dynamic, created by modifying the real Eurasian Amphicyonidae one, to better exemplify the effect that the parameters of the function `eta` can have in the analysis.
- **results_correlations_bycut.R:** R script to generate Figs. 6, 7, S15, S16, S17, S18, and S19 of the manuscript.
- **tpp_plots.R:** R script to generate TPP visualization plots for each family-continent pair (Figs. S1 and S2).
- **functions.RData:** functions necessary to generate TPP plots.

<h4>occs_data_prep</h4>
Necessary files to prepare occurrences for PyRate analyses.

- **data_prep_tutorial.R:** model script to prepare occurrences for PyRate analyses. This is annexed in the text for this dissertation.
- **needed_functions.RData:** R functions necessary to properly run the data prep script.
- **now_for_analysis.txt:** full database obtained from NOW, which is prepared through the data prep script, following the step by step detailed in the dissertation Appendix 2.
- **pbdb_for_analysis.txt:** full database obtained from PBDB, which is prepared through the data prep script, following the step by step detailed in the dissertation Appendix 2.

<h3>output</h3>

<h4>images</h4>

Outputs of the sub-folder *images_scripts* in folder *R*.

<h4>eta</h4>

Outputs of the function `eta`.

<h5>images</h5>

PDF files showing the diversification dynamics divided in time windows. The files are organized by threshold method, and file names follow the standard `PAIR_CUT_THRESHOLDS`. Pair names follow the table presented in section *data*.

<h5>tables</h5>
Contains two types of files:

- Tables containing mean speciation and extinction rates, locality, and status for each family-continent pair for all time windows (`rise` for expansion, `eq` for equilibrium, and `dec` for decline). Those files are named as `THRESHOLD_mean_WINDOW_CUT.txt`.
- Tables containing threshold rates estimated through function `eta` for each family-continent pair. Those files are named as `THRESHOLD_threshold_rates_CUT.txt`.


<h4>correlations</h4>

Outputs of the correlation analyses.

<h5>data</h5>

RData files containing the results of Kendall correlations between speciation and extinction rates divided by status (`dead` or `alive`), continent (`eu` or `nam`), and not segregated (`neutral`), for all time windows. The file names indicate cut and threshold method. 

<h5>images</h5>

PDF files showing the individual plots for the correlations between speciation and extinction rates, organized in folders named by cut and threshold method. Inside each folder, the file names indicate whether the correlation was performed by status, continent, or without segregation, and for expansion, equilibrium or decline (for example, file `neutral_equilibrium.pdf` in folder cut01_1t shows the correlation for the equilibrium window, without any segregation within the data, with parameters cut = 0.1 and one threshold method in the function `eta`).

<h2>Authors</h2>
<a href="https://orcid.org/0009-0003-8578-6347">Nathália Caldeira</a>, <a href="https://orcid.org/0000-0001-8862-9839">Lucas M. V. Porto</a>, and <a href="https://orcid.org/0000-0002-4832-9468">Tiago B. Quental</a>.

<h2>Contact</h2>

If you have any issues, suggestions or commentary, please contact <a href="https://github.com/itchyskeleton">Nathália Caldeira</a>.

<h2>Session info</h2>

```{.r}
R version 4.1.1 (2021-08-10)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 19045)

Matrix products: default

locale:
[1] LC_COLLATE=Portuguese_Brazil.1252  LC_CTYPE=Portuguese_Brazil.1252    LC_MONETARY=Portuguese_Brazil.1252
[4] LC_NUMERIC=C                       LC_TIME=Portuguese_Brazil.1252    

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] data.table_1.14.8      plyr_1.8.8             fitdistrplus_1.1-8     survival_3.2-11        MASS_7.3-54           
 [6] geosphere_1.5-18       tidyr_1.3.0            DescTools_0.99.45      TeachingDemos_2.12     LaplacesDemon_16.1.6  
[11] RecordLinkage_0.4-12.4 ff_4.0.7               bit_4.0.4              RSQLite_2.2.14         DBI_1.1.3             
[16] RColorBrewer_1.1-3     scales_1.4.0           here_1.0.1            

loaded via a namespace (and not attached):
 [1] Rcpp_1.0.10        mvtnorm_1.1-3      lattice_0.20-44    listenv_0.8.0      class_7.3-19       rprojroot_2.0.3    digest_0.6.28     
 [8] ipred_0.9-13       utf8_1.2.2         parallelly_1.32.0  R6_2.5.1           cellranger_1.1.0   ada_2.0-5          rootSolve_1.8.2.3 
[15] e1071_1.7-11       httr_1.4.7         pillar_1.9.0       rlang_1.1.5        Exact_3.1          readxl_1.4.2       rstudioapi_0.16.0 
[22] blob_1.2.3         rpart_4.1-15       Matrix_1.3-4       splines_4.1.1      proxy_0.4-27       compiler_4.1.1     pkgconfig_2.0.3   
[29] globals_0.15.1     tidyselect_1.2.0   nnet_7.3-16        evd_2.3-6.1        tibble_3.2.1       lmom_2.9           prodlim_2019.11.13
[36] expm_0.999-6       codetools_0.2-18   fansi_0.5.0        future_1.26.1      dplyr_1.1.0        grid_4.1.1         xtable_1.8-4      
[43] lifecycle_1.0.4    magrittr_2.0.3     gld_2.6.5          future.apply_1.9.0 cli_3.6.1          cachem_1.0.6       farver_2.1.0      
[50] sp_1.6-0           vctrs_0.6.1        generics_0.1.1     boot_1.3-28        lava_1.6.10        tools_4.1.1        bit64_4.0.5       
[57] glue_1.6.2         purrr_1.0.1        maps_3.4.0         parallel_4.1.1     fastmap_1.1.0      memoise_2.0.1
```

<h2>Bibliography mentioned in this README</h2>

<ol>
<li>Gillinsky, Norman L. 1994. “Volatility and the Phanerozoic Decline of Background Extinction Intensity.” Paleobiology, 445–58. https://doi.org/10.1017/S0094837300012926.</li>
<li>“New and Old Worlds - Database of Fossil Mammals.” 2022. https://nowdatabase.org/.</li>
<li>“Palaeobiology Database.” 2022. https://paleobiodb.org/.</li>
</ol>

<h2>Acknowledgements</h2>
Huge thanks to <a href="https://github.com/GabrielNakamura">Gabriel Nakamura</a> for this README file structure, and for the moments sharing countryside Brazilian culture.