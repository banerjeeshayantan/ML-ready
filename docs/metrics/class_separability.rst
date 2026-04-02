Class Separability (Diagnostic)
===============================

Purpose
-------

``class_separability`` is a diagnostic metric (rendered as its own tab) that
estimates label separability under a simple linear model.

It is intentionally separate from the core readiness score.

Current implementation summary
------------------------------

For each analysis matrix:

1. Keep biological samples with usable labels.
2. Require enough data to evaluate AUROC robustly.
3. Impute missing cells by per-feature median.
4. Remove constant features.
5. Cap features at top-variance 2000.
6. Z-score each retained feature.
7. Compute repeated stratified train/test logistic AUROC.

Per-analysis eligibility constraints
------------------------------------

- At least 20 labeled biological samples
- At least 2 classes
- At least 3 samples per class

If constraints fail, the analysis is kept in output with ``eligible_for_auroc=False``
and a concrete ``skipped_reason``.

Model and AUROC calculation
---------------------------

Model
  ``LogisticRegression(max_iter=1000)``

Validation
  3 stratified repeats with ``test_size=0.25``.

AUROC mode
  - Binary: standard ROC-AUC from positive-class probability
  - Multiclass: macro one-vs-rest AUROC

Per-analysis score
  Mean AUROC across valid repeats.

Study-level score
  Unweighted mean AUROC across eligible analyses only.

Additional robustness summaries
-------------------------------

Returned in metric details:

- mean AUROC (eligible analyses)
- median AUROC
- IQR AUROC
- 95% CI around mean (normal approximation)
- eligible/ineligible analysis counts and coverage
- per-analysis PCA projection payload for plotting

Status thresholds
-----------------

- pass if score >= 0.7
- warn if 0.6 <= score < 0.7
- fail if score < 0.6

Representative formula string from code
---------------------------------------

``analysis_score = mean(cv_auroc across stratified repeats)``

``study_score = mean(analysis_score across eligible analyses)``

Notes
-----

- This is an empirical separability probe, not a causal validity guarantee.
- AUROC can be optimistic under dataset shift; always pair with external validation.
- Ineligible analyses are surfaced explicitly so users can distinguish
  "not computable" from "poor separability".
