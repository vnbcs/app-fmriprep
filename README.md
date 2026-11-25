<h1 align="center">fmriprep</h1>

<p align="center">
  Preprocesses BOLD fMRI with fMRIPrep 21.0.1 and outputs surface time series (GIFTI and CIFTI) on fsaverage or fsnative surfaces, confound regressors, brain masks and an HTML report.
</p>

<p align="center">
  <a href="https://github.com/brainlife/abcd-spec"><img src="https://img.shields.io/badge/ABCD_Spec-v1.1-green.svg" alt="ABCD Spec v1.1"></a>
  <a href="https://doi.org/10.25663/brainlife.app.686"><img src="https://img.shields.io/badge/Brainlife-brainlife.app.686-blue.svg" alt="Run on brainlife.io"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-see_LICENSE-lightgrey.svg" alt="License"></a>
</p>

## At a glance

<!-- brainlife-app:begin (generated from the App manifest; edit the manifest, not this block) -->

> **Preprocesses BOLD fMRI with fMRIPrep 21.0.1 and outputs surface time series (GIFTI and CIFTI) on fsaverage or fsnative surfaces, confound regressors, brain masks and an HTML report.**

Fork of the brainlife fMRIPrep surface App that runs fMRIPrep 21.0.1 with a FreeSurfer input and maps the surface-space BOLD outputs (left/right GIFTI, 91k CIFTI dtseries and, for fsnative, the surface vertices) to brainlife datatypes. Needs a T1w, a raw BOLD and the FreeSurfer output of the same T1w. Although the App lists an ICA-AROMA output, this configuration has no aroma parameter, so ICA-AROMA is never enabled and that output stays empty.

| | |
|---|---|
| **Inputs** | `neuro/anat/t1w` · `neuro/func/task` · `neuro/freesurfer` · `neuro/anat/t2w` (optional) · `neuro/fmap` (optional) |
| **Outputs** | `neuro/regressors` ×2 · `neuro/anat/t1w` · `neuro/mask` · `report/html` · `neuro/cifti` · `neuro/surface/data` · `neuro/surface/vertices` |
| **Container** | `nipreps/fmriprep:21.0.1` |
| **Resources** | 16 CPUs · 28 GB memory · 9 h walltime |
| **Requires** | `FREESURFER_LICENSE` |
| **Run it** | [doi.org/10.25663/brainlife.app.686](https://doi.org/10.25663/brainlife.app.686) |

#### Inputs

| Input | Datatype | Required | Description |
|---|---|---|---|
| `t1w` | `neuro/anat/t1w` | yes | t1 anatomy to register the input fmri data. Please be sure to use the same t1 used to generate the freesurfer input. Must be the same T1w used to generate the FreeSurfer input. |
| `fmri` | `neuro/func/task` (!preprocessed) | yes | fmri data to preprocess |
| `freesurfer` | `neuro/freesurfer` (!v5) | yes | freesurfer output used to aid preprocessing |
| `t2w` | `neuro/anat/t2w` | no | Optional T2-weighted image of the same subject, converted into the BIDS input given to fMRIPrep. |
| `fmap` | `neuro/fmap` | no | 2phasemag fieldmap is not yet supported by fmriprep (https://github.com/poldracklab/sdcflows/issues/15) - testing 1.5.2 should should support it. |

#### Outputs

| Output | Datatype | Description |
|---|---|---|
| `regress` | `neuro/regressors` | fMRIPrep confounds time series (regressors.tsv and its JSON sidecar). |
| `anat` | `neuro/anat/t1w` | preprocessed t1 (same alignment as the original t1, but level adjusted - editme) |
| `anat_mask` | `neuro/mask` | Brain mask of the preprocessed T1w in the original T1w space. |
| `output_report` | `report/html` | fmriprep HTML report and figures |
| `cifti` | `neuro/cifti` | surface timeseries data in cifti |
| `surface-data` | `neuro/surface/data` | Preprocessed BOLD time series on the left and right hemisphere surfaces (GIFTI func.gii) in the selected surface space. |
| `surface-vertices` | `neuro/surface/vertices` | surface vertices. only meaningful for fsnative. |
| `aroma` | `neuro/regressors` | AROMA ICA regressors |

<details>
<summary><b>Parameters</b> (2)</summary>

| Parameter | Type | Default | Description |
|---|---|---|---|
| `space` | enum | `fsaverage5` | Surface output space for the BOLD time series: fsaverage5, fsaverage6 or the subject's native FreeSurfer surface (fsnative). Options: `fsaverage5`, `fsaverage6`, `fsnative`. |
| `skipbidsvalidation` | boolean | `false` | Skip the BIDS validation of input data. Try this option if your data is not BIDS compatible but you'd like to go ahead and process it through fmriprep anyway. |

</details>

<!-- brainlife-app:end -->

## Versions on brainlife.io

This repository hosts several Apps, each built from its own branch.

| App | Branch | Run it | Status |
|---|---|---|---|
| fMRIPrep - Surface Output - ICA-AROMA | [`ic-aroma`](https://github.com/vnbcs/app-fmriprep/tree/ic-aroma) | [doi:10.25663/brainlife.app.686](https://doi.org/10.25663/brainlife.app.686) | current |
| fMRIPrep - Volume Output - ICA-AROMA | [`ic-aroma`](https://github.com/vnbcs/app-fmriprep/tree/ic-aroma) | [doi:10.25663/brainlife.app.682](https://doi.org/10.25663/brainlife.app.682) | available |

## Running the App

### On brainlife.io

Open the App at [doi.org/10.25663/brainlife.app.686](https://doi.org/10.25663/brainlife.app.686), choose `neuro/anat/t1w`, `neuro/func/task`, `neuro/freesurfer`, `neuro/anat/t2w`, `neuro/fmap` from your project, set the parameters and press **Execute**. The results are saved to your project as `neuro/regressors`, `neuro/anat/t1w`, `neuro/mask`, `report/html`, `neuro/cifti`, `neuro/surface/data`, `neuro/surface/vertices`, `neuro/regressors`.

### Locally

You need [Singularity/Apptainer](https://apptainer.org/) (the App runs in `nipreps/fmriprep:21.0.1`), [`jq`](https://jqlang.github.io/jq/), `FREESURFER_LICENSE`.

1. Clone this repository and check out the App's branch (`git checkout ic-aroma`).
2. Create `config.json` with the paths to your inputs and the parameters:

   ```json
   {
       "t1": "/path/to/t1w/t1",
       "fmri": "/path/to/fmri/fmri",
       "sbref": "/path/to/fmri/sbref",
       "sbref_json": "/path/to/fmri/sbref_json",
       "events": "/path/to/fmri/events",
       "events_json": "/path/to/fmri/events_json",
       "physio": "/path/to/fmri/physio",
       "physio_json": "/path/to/fmri/physio_json",
       "fsin": "/path/to/freesurfer/fsin",
       "t2": "/path/to/t2w/t2",
       "phasediff": "/path/to/fmap/phasediff",
       "phasediff_json": "/path/to/fmap/phasediff_json",
       "magnitude": "/path/to/fmap/magnitude",
       "magnitude1": "/path/to/fmap/magnitude1",
       "magnitude2": "/path/to/fmap/magnitude2",
       "fieldmap": "/path/to/fmap/fieldmap",
       "fieldmap_json": "/path/to/fmap/fieldmap_json",
       "phase1": "/path/to/fmap/phase1",
       "phase1_json": "/path/to/fmap/phase1_json",
       "phase2": "/path/to/fmap/phase2",
       "phase2_json": "/path/to/fmap/phase2_json",
       "epi1": "/path/to/fmap/epi1",
       "epi1_json": "/path/to/fmap/epi1_json",
       "epi2": "/path/to/fmap/epi2",
       "epi2_json": "/path/to/fmap/epi2_json",
       "space": "fsaverage5",
       "skipbidsvalidation": false
   }
   ```

3. Run `./main`.

## Troubleshooting

- **app needs minimally a T1w and fmri. exiting**: Provide both a T1w and an fMRI input.
- **Please set FREESURFER_LICENSE in .bashrc**: Set FREESURFER_LICENSE in the environment of the resource running the App.

## Citing

If you use this App, please cite it, the software it builds on and brainlife.io:

- fMRIPrep - Surface Output - ICA-AROMA. brainlife.io App. [doi:10.25663/brainlife.app.686](https://doi.org/10.25663/brainlife.app.686)
- Esteban O. et al. fMRIPrep: a robust preprocessing pipeline for functional MRI. Nature Methods 16, 111-116 (2019). [doi:10.1038/s41592-018-0235-4](https://doi.org/10.1038/s41592-018-0235-4)
- Fischl. FreeSurfer. *NeuroImage* 62:774-781 (2012). [doi:10.1016/j.neuroimage.2012.01.021](https://doi.org/10.1016/j.neuroimage.2012.01.021)
- Hayashi S, Caron BA, Heinsfeld AS, et al. brainlife.io: a decentralized and open-source cloud platform to support neuroscience research. *Nature Methods* 21:809–813 (2024). [doi:10.1038/s41592-024-02237-2](https://doi.org/10.1038/s41592-024-02237-2)
- Avesani P, McPherson B, Hayashi S, et al. The open diffusion data derivatives, brain data upcycling via integrated publishing of derivatives and reproducible open cloud services. *Scientific Data* 6:69 (2019). [doi:10.1038/s41597-019-0073-y](https://doi.org/10.1038/s41597-019-0073-y)

## Authors

- Josh Faskowitz ([@faskowit](https://github.com/faskowit))
- Soichi Hayashi ([@soichih](https://github.com/soichih))

**Project director**

- Franco Pestilli ([@francopestilli](https://github.com/francopestilli))

## Funding

[![Wellcome-226486/Z/22/Z](https://img.shields.io/badge/Wellcome-226486%2FZ%2F22%2FZ-purple.svg)](https://wellcome.org/)
[![NIH-NINDS-U24NS140384](https://img.shields.io/badge/NIH_NINDS-U24NS140384-green.svg)](https://reporter.nih.gov/project-details/11261037)
[![NIH-NINDS-UM1NS132207](https://img.shields.io/badge/NIH_NINDS-UM1NS132207-green.svg)](https://reporter.nih.gov/project-details/11411328)
[![NIH-NIBIB-R01EB029272](https://img.shields.io/badge/NIH_NIBIB-R01EB029272-green.svg)](https://reporter.nih.gov/project-details/10262925)
[![NIH-NIBIB-R01EB030896](https://img.shields.io/badge/NIH_NIBIB-R01EB030896-green.svg)](https://reporter.nih.gov/project-details/10428625)
[![NIH-NIMH-R01MH126699](https://img.shields.io/badge/NIH_NIMH-R01MH126699-green.svg)](https://reporter.nih.gov/project-details/10460628)
[![NIH-NIDCD-R01DC020088](https://img.shields.io/badge/NIH_NIDCD-R01DC020088-green.svg)](https://reporter.nih.gov/project-details/11140284)
[![NSF-BCS-1734853](https://img.shields.io/badge/NSF_BCS-1734853-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1734853)
[![NSF-BCS-2203524](https://img.shields.io/badge/NSF_BCS-2203524-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2203524)
[![NSF-IIS-1636893](https://img.shields.io/badge/NSF_IIS-1636893-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1636893)
[![NSF-OAC-2148729](https://img.shields.io/badge/NSF_OAC-2148729-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148729)
[![NSF-IIS-1912270](https://img.shields.io/badge/NSF_IIS-1912270-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1912270)
[![NSF-IIS-2148700](https://img.shields.io/badge/NSF_IIS-2148700-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2148700)
[![NSF-OAC-1916518](https://img.shields.io/badge/NSF_OAC-1916518-blue.svg)](https://www.nsf.gov/awardsearch/showAward?AWD_ID=1916518)

<sub>brainlife.io, which runs this App, is publicly funded by Wellcome, the U.S. National Institutes of Health and the U.S. National Science Foundation; acknowledging that support helps keep it running.</sub>

## License

See [LICENSE](LICENSE).
