Analytical QC Metrics
=====================

Section membership
------------------

Analytical section has 8 metrics in UI, with 5 scored and 3 informational.

Scored metrics (counted in section score)
------------------------------------------

- ``missingness_structure``
- ``assay_platform_comparability``
- ``feature_correlation_burden``
- ``outlier_burden``
- ``feature_level_missingness``

Informational metrics (not counted)
-----------------------------------

- ``qc_blank_presence``
- ``batch_info_availability``
- ``scale_diagnostics``

Section score uses fixed denominator 5.

Canonical missingness semantics
-------------------------------

MERIT uses a unified missing parser in ``_is_missing`` with source-aware zero handling.

A value is missing if it is:

- ``None``
- non-finite numeric (NaN/Inf)
- empty string
- known missing token (NA/N/A/null/none/nd/bdl/bql/lod/lloq/bloq/nq/loq/missing/not detected, etc.)
- a string starting with ``<``

Zero handling is source-aware:

- datatable: zero is valid
- mwtab/untarg/results: zero is missing

1) qc_blank_presence (informational)
------------------------------------

Purpose
  Detect QC/pool/reference and blank controls by keywords.

Score

.. math::

   score = 0.5\cdot I(qc\_present) + 0.5\cdot I(blank\_present)

Status
  - pass if score >= 0.5
  - warn otherwise

Informational
  Excluded from analytical section arithmetic.

2) missingness_structure (scored)
---------------------------------

Purpose
  Sample-level missingness over biological samples only.

Per-sample rate

.. math::

   r_s = \frac{\#\text{missing features in sample }s}{\#\text{features}}

Per-analysis score

.. math::

   score_a = 1 - median\left(\{r_s\}_{s \in biological}\right)

Aggregate score

.. math::

   score = mean\left(\{score_a\}_{analyses}\right)

Class-dependent gap (diagnostic)

Difference between max and min class-wise missingness rates. Reported and can trigger warnings,
but is not added as a weighted arithmetic term in score.

Status
  - pass if score >= 0.85 and class gap < 10%
  - warn otherwise

3) scale_diagnostics (informational)
------------------------------------

Purpose
  Distribution-shape and value-scale diagnostics for interpretation/preprocessing guidance.

Classification logic (binary)

- ``raw`` if high-count/wide-tail signature
- ``likely_transformed`` otherwise

Per-analysis details include:

- min, median, p90, max
- log10(median)
- median/p90
- low-signal feature diagnostics (p90 bottom decile)
- near-zero variance diagnostics:

  .. math::

     mad\_rel = \frac{MAD(x)}{median(|x|)+10^{-8}}

  with NZV if ``mad_rel < 1e-3`` or ``IQR == 0``.

Informational
  Excluded from analytical section arithmetic.

4) batch_info_availability (informational)
------------------------------------------

Purpose
  Detect run/batch/order metadata keys in sample attributes.

Score

- 0.5 baseline when unavailable
- up to 1.0 as fraction of analyses with batch keys

Informational
  Excluded from analytical section arithmetic.

5) assay_platform_comparability (scored)
----------------------------------------

Purpose
  Compare central numeric scale across analyses.

Per-analysis summary

- Keep finite, non-missing, strictly positive cells
- Compute ``log10_median`` per analysis

Spread

.. math::

   spread = \max(log10\_median_a) - \min(log10\_median_a)

Score

.. math::

   score = \frac{1}{1 + spread}

Edge cases

- no usable analyses -> score 0.0
- one usable analysis -> score 1.0

Status
  - pass if score >= 0.5
  - warn otherwise

6) feature_correlation_burden (scored)
--------------------------------------

Purpose
  Detect high pairwise feature redundancy.

Rule

- Compute Pearson correlation matrix per analysis (with NaN imputation via column mean)
- Count pair as high-correlation if ``|r| >= 0.95``

Score

.. math::

   score = 1 - \frac{\#high\_corr\_pairs}{\#sampled\_pairs}

Status
  - pass if score >= 0.85
  - warn otherwise

7) outlier_burden (scored)
--------------------------

Purpose
  Outlier burden at sample and feature levels using IQR rule.

Outlier rule

.. math::

   x < Q1 - 1.5\cdot IQR \quad \text{or} \quad x > Q3 + 1.5\cdot IQR

Components

- sample component from per-sample medians
- feature component from per-feature value points

Score

.. math::

   score = \frac{sample\_component + feature\_component}{2}

Status
  - pass if score >= 0.9
  - warn otherwise

8) feature_level_missingness (scored)
-------------------------------------

Purpose
  Feature-wise missingness burden and high-missing feature flags.

Per-feature rate

.. math::

   r_f = \frac{\#missing\_cells\_for\_feature\ f}{\#samples}

Summary metrics

- ``mean_missingness_rate = mean(r_f)``
- ``median_missingness_rate = median(r_f)``
- high-missing feature threshold = 30%

Score

.. math::

   score = 1 - mean\_missingness\_rate

Status
  - pass if fraction(features >30% missing) < 10%
  - warn otherwise

Representative tooltip/output text
----------------------------------

Examples aligned with current UI copy:

- "Source-aware zero handling: datatable zeros are treated as valid (curated structural fill); mwTab/untarg_data zeros are treated as missing (below detection)."
- "Score = 1 / (1 + spread), where spread is in log10 units."
- "For each listed feature, the percentage in parentheses is outlier_rate = n_outlier_values / n_values × 100."

