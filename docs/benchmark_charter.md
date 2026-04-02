# MERIT Benchmark Charter

## Primary Claim

Metabolomics-specific readiness scores should predict downstream model stability, external generalization, and cross-study harmonization quality better than generic tabular data checks alone.

## Initial Cohort Scope

- Human studies only
- Disease-labeled samples only
- Mass spectrometry studies only
- Public processed abundance matrices available locally
- Sample-level labels and provenance required

## Fixed Score Families

- Structural
- Metadata / FAIR
- Analytical QC
- Annotation / Interoperability
- Cohort / Bias
- ML Task Readiness
- Cross-Study Harmonization

## Baseline Task Types

1. Within-study case/control classification
2. Leave-one-study-out validation across harmonized studies
3. Cross-repository transfer (implemented as study holdout with repository-aware provenance)

## Baseline Models

- Logistic regression
- Random forest

## Core Endpoints

- AUROC
- AUPRC
- Brier score
- Calibration error
- Variance across repeated splits
- Performance drop under external holdout

## Reproducibility Rules

- All studies must be stored in canonical JSON form.
- Bundles, canonical studies, assessments, and benchmark outputs are versioned artifacts.
- File-level hashes are preserved in provenance.
- Any metric semantics change requires a version bump.
