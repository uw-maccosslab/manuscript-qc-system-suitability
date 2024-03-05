# MacCoss Lab QC for sample preparation, system suitability, and quantitative results.

This repository contains most of the input files and the analyses described in the manuscript **"Moving beyond protein and peptide identifications: A holistic approach to quality control in bottom-up proteomics experiments spanning sample preparation, system suitability, and quantitative analyses"**, which is currently located on bioRxiv under the DOI (TBD). Any files not located here are freely and openly accessible on this [public Panorama page](https://panoramaweb.org/MacCoss/Tsantilas_Public/20240214_QC_Companion_Page/project-begin.view).

Data was processed manually or with Nextflow workflows using Skyline and Limelight. The results were exported using the Skyline document grid or from Limelight. Downstream analyses and figure generation were perfomed using Skyline, Panorama, R scripts, and Inkscape.


**Please note this initial commit will be edited later (likely multiple times) with:**

* Updated manuscript title

* Updated bioRxiv DOI

* Updated panorama link which will have all raw data files accessible


$~$


## Repository Layout

* **bin:** Contains scripts used to generate figures

* **figs:** Contains copies of figures

* **input:** Contains files used as input for the scripts in the bin folder

* **miscellaneous:** Contains additional, miscellaneous files.

* **skyline_reports_templates:** Contains Skyline report format files (.skyr) and template Skyline documents for DIA sample QC and PRM system suitability


$~$

## Important resources

* **Temporary data deposition:** [Public Panorama project containing large script input files](https://panoramaweb.org/MacCoss/Tsantilas_Public/20240214_QC_Companion_Page/project-begin.view)

* **Panorama Public:** In progress

* **Limelight Project:** [MacCoss QC Paper 2024 - Project 131](https://limelight.yeastrc.org/limelight/d/pg/project/131)


$~$

## Scripts

Scripts are located in the **bin** folder.

* **maccoss_qc_figures_3_4_5_6_S1.Rmd:** R Markdown that is used to generate the following figures:

  - Figure 3
  - Figure 4
  - Figure 5
  - Figure 6
  - Supplementary Figure 1

* **bin/data** subfolder contains scripts needed to process data to generate Figure 7 using two additional scripts found in **figs** subfolder

  - functions.r
  - interim_dat.r
  - processed_dat.r

* **bin/figs** subfolder contrains scripts used to generate figure 7

  - **plot_7a.r:** R script that is used to generate the Figure 7A
  - **plot_7b.r:** R script that is used to generate the following Figure 7B and 7C

$~$


## Files

Input files for scripts are located in the **input** folder. All of the files uploaded to **input** will also located on the MacCoss QC (2024) page of PanoramaWeb.

### maccoss_qc_figures_3_4_5_6_S1.Rmd input files

#### ***Skyline Document:*** figure3_PRM_system_suitability.sky.zip
* **Figure3_PRM_metadata.csv:** Metadata of PRM system suitability runs shown in Figure 3.
* **Figure3_PRM_PeakArea_RetTime_Chromatogram_Export.csv:** Peak areas, retention times, and chromatograhy data from PRM system suitability runs shown in Figure 3. Located only on Panorama.
* **Figure3_PRM_MS1area_idotp.csv:** Isotope dot products of PRM system suitability runs shown in Figure 3.

#### ***Skyline Document:*** figure4_DIA_samples.sky.zip
* **Figure4_DIA_PeakArea_RetTime_Chromatogram_Export.csv:** Peak areas, retention times, and chromatography data from DIA sample runs runs shown in Figure 4 and Supplementary Figure 1. Located only on Panorama.
* **Figure4_DIA_metadata.csv:** Metadata of DIA samples runs shown in Figure 4 and Supplementary Figure 1.

#### ***Skyline Document:*** figure4_PRM_system_suitability.sky.zip
* **Figure4_PRM_PeakArea_RetTime_Chromatogram_Export.csv:** Peak areas, retention times, and chromatography data from PRM system suitability runs runs shown in Figure 4 and Supplementary Figure 1. Located only on Panorama.
* **Figure4_PRM_metadata.csv:** Metadata of PRM system suitability runs shown in Figure 4 and Supplementary Figure 1.

#### ***Skyline Document:*** figure5_DIA_samples.sky.zip
* **Figure5_DIA_PeakArea_RetTime_Chromatogram_Export.csv:**  Peak areas, retention times, and chromatography data from DIA sample runs runs shown in Figure 5. Located only on Panorama.
* **Figure5_DIA_metadata.csv:** Metadata of DIA samples runs shown in Figure 5.

#### ***Skyline Document:*** figure5_PRM_system_suitability.sky.zip
* **Figure5_PRM_PeakArea_RetTime_Chromatogram_Export.csv:** Peak areas, retention times, and chromatography data from PRM system suitability runs runs shown in Figure 5. Located only on Panorama.
* **Figure5_PRM_metadata.csv:** Metadata of PRM system suitability runs shown in Figure 5.

#### ***Skyline Document:*** figure6_DIA_samples.sky.zip
* **Figure6_DIA_LongForm_Peptide_TAF.csv:** Total area fragment of DIA sample runs shown in Figure 6.
* **Figure6_DIA_metadata.csv:** Metadata of DIA samples runs shown in Figure 6.

#### ***Skyline Document:*** figure6_PRM_system_suitability.sky.zip
* **Figure6_PRM_LongForm_Peptide_TAF.csv:** Total area fragment of PRM system suitability runs shown in Figure 6.
* **Figure6_PRM_metadata.csv:** Metadata of PRM system suitability runs shown in Figure 6.

#### ***Limelight Project:*** [MacCoss QC Paper 2024 - Project 131](https://limelight.yeastrc.org/limelight/d/pg/project/131).
* **Figure3_DDA_Limelight_PSMs.txt:** Peptides and PSMs identified using Comet and Percolator.

#### ***Additional input files:*** 
* **Figure3_timeline_format.csv:** Organizer .csv to set-up and label the maintenance timeline in Figure 3A.
* **Figure6_timeline_format.csv:** Organizer .csv to set-up and label the maintenance timeline in Figure 6A.
* **Figure6_Run_Organizer.csv:** Organizer .csv to set-up and label Figure 6B.

#### ***Please note some Input files are only located on Panorama:*** [Public Panorama project](https://panoramaweb.org/MacCoss/Tsantilas_Public/20240214_QC_Companion_Page/project-begin.view) that contains script input files that are larger than 25 MB.

* Figure3_PRM_PeakArea_RetTime_Chromatogram_Export.csv

* Figure4_DIA_PeakArea_RetTime_Chromatogram_Export

* Figure5_DIA_PeakArea_RetTime_Chromatogram_Export

* Figure5_PRM_PeakArea_RetTime_Chromatogram_Export


### functions.r input files

* None. Contains functions used in **interim_dat.r**, **processed_dat.r**, **plot_7a.r**, and **plot_7b.**r


### interim_dat.r input files

* **Figure7_DIAPeptideTotalAreaFragmentPivot.csv.csv:** Total area fragment values extracted using Skyline (Figure 7A,7B, and 7C).

* **Figure7_TPAD_CSF_meta-12-13-2022.csv.csv:** Metadata exported from Skyline (Figure 7A,7B, and 7C).


### processed_dat.r input files

* **int.rdata:** Input file of log2 transformed data. Also written to .csv file "tpad-csf_sp3-1_5-log2_raw-v230512.csv"


### plot_7a.r and plot_7b.r input files

* **int.rdata:** Input file of log2 transformed data.
  
* **proc.rdata:** Input file of processed data and metadata generated in processed_dat.r



$~$


## Figure Generation

Details of how each figure panel was generated.

* **Figure 1:**
Both panels generated using Inkscape. No script or files on github - located on Panorama.
  - **1A:** Summary of quality control and system suitability methods described in the manuscript.
  - **1B:** Integration of quality control and system suitability methods into workflow.

* **Figure 2:**
Panels assembled in "maccoss_qc_figures_3_4_5_6_S1.Rmd". Simplified, combined, and resized both panels in Inkscape. No script or files on github - located on Panorama.
  - **2A:** Exported PDF of Panorama AutoQC plot of transition area. Plot area simplified using inkscape.
  - **2B:** Exported PDF of Panorama AutoQC plot of Trailing CV of the previous 5 replicates. Plot area simplified using inkscape.

* **Figure 3:**
Panels generated in "maccoss_qc_figures_3_4_5_6_S1.Rmd".
  - **3A:** Maintenance timeline on Orbitrap Fusion Lumos.
  - **3B:** MS1 chromatogram of representative LTILEELR peptide from each instrument batch exported from Skyline and annotated with isotope dot product (idotp).
  - **3C:** MS1 chromatogram of representative LVNELTEFAK peptide from each instrument run exported from Skyline and annotated with isotope dot product (idotp).
  - **3D:** Average unique peptides identified in each DDA instrument batch. 
  - **3E:** Average total area frament of LTILEELR in each PRM instrument batch.

* **Figure 4:**
Panels generated in "maccoss_qc_figures_3_4_5_6_S1.Rmd".
  - **4A:** Exported Skyline MS2 peak areas of yeast enolase peptide VNQIGTLSESIK from samples in running order.
  - **4B:** Exported Skyline MS2 peak areas of yeast enolase peptide VNQIGTLSESIK from samples grouped by sample preparation condition.

* **Figure 5:**
Panels generated in "maccoss_qc_figures_3_4_5_6_S1.Rmd". Data exported using Skyline report "QC_PeakArea_RetTime_Chromatogram.skyr". Adjusted x-axis title positions in Inkscape.
  - **5A:** Peak area of yeast enolase peptide AVDDFLISLDGTANK from sample runs.
  - **5B:** Peak area of yeast enolase peptide GLIVGGYGTR from sample runs.
  - **5C:** MS2 chromatogram of yeast enolase peptide AVDDFLISLDGTANK from sample 07 exported from Skyline plus zoomed-in inset.
  - **5D:** MS2 chromatogram of yeast enolase peptide AVDDFLISLDGTANK from sample 09 exported from Skyline.
  - **5E:** MS2 chromatogram of PRTC peptide GLIVGGYGTR from sample 07 exported from Skyline plus zoomed-in inset.
  - **5F:** MS2 chromatogram of PRTC peptide GLIVGGYGTR from sample 09 exported from Skyline.
  - **5G:** Retention times of yeast enolase peptide AVDDFLISLDGTANK from sample runs.
  - **5H:** Retention times of yeast enolase peptide GLIVGGYGTR from sample runs.

* **Figure 6:**
Panels generated in "maccoss_qc_figures_3_4_5_6_S1.Rmd".
  - **6A:** Maintenance timeline of Orbitrap Fusion Lumos Tribrid.
  - **6B:** Total Area Fragment of 8 individual PRTC peptides in system suitability and sample runs across 4 batches.

* **Figure 7:**
Panels generated in "plot_7a.r" and "plot_7b.r".
  - **7A:** Assessing the effect of median normalization and batch correction on peptide and protein CVs in the inter-batch external QC samples within each batch.
  - **7B:** Plotting the CV vs Log2(Median Abundance) across all batches to assess the effects of normalization and batch correction on peptide and protein CVs in the inter-batch external QC samples.
  - **7C:** Plotting Frequency distribution of the protein and peptide CVs across all batches to assess the effects of normalization and batch correction on peptide and protein CVs in the inter-batch external QC samples.

* **Supplementary Figure S1:**
  - **S1A:** Exported Skyline MS2 peak areas of yeast enolase peptide AADALLLK from samples in running order.
  - **S1B:** Re-print of exported Skyline MS2 peak areas of yeast enolase peptide VNQIGTLSESIK from samples in running order.
  - **S1C:** Exported Skyline MS2 peak areas of PRTC peptide AADALLLK from samples grouped by sample preparation condition.
  - **S1D:** Re-print of exported Skyline MS2 peak areas of yeast enolase peptide VNQIGTLSESIK from samples grouped by sample preparation condition.
  - **S1E:** Exported Skyline MS2 peak areas of PRTC peptide NGFILDGFPR from samples in running order.
  - **S1F:** Exported Skyline MS2 peak areas of PRTC peptide TASEFDSAIAQDK from samples in running order.
  - **S1G:** Exported Skyline MS2 peak areas of PRTC peptide NGFILDGFPR from samples grouped by sample preparation condition.
  - **S1H:** Exported Skyline MS2 peak areas of PRTC peptide TASEFDSAIAQDK from samples grouped by sample preparation condition.
